//
//  XQRecorder.m
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/26.
//  Copyright © 2016年 X. All rights reserved.
//

#import "XQRecorder.h"

@implementation XQRecorder

- (id)init {
    self = [super init];
    if (self) {
        
        NSString *tmpDir = NSTemporaryDirectory();
        NSString *filePath = [tmpDir stringByAppendingPathComponent:@"record.caf"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        
        NSLog(@"%@",filePath);
        
        /*
         1:id
         2.采样率
         3.通道 1，单声道 2，立体声
         4.编码器位深度
         5.编码器音频质量
         */
        NSDictionary *settings = @{
                                   AVFormatIDKey : @(kAudioFormatAppleIMA4),
                                   AVSampleRateKey : @44100.0f,
                                   AVNumberOfChannelsKey : @1,
                                   AVEncoderBitDepthHintKey : @16,
                                   AVEncoderAudioQualityKey : @(AVAudioQualityMedium)
                                   };
        
        NSError *error;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:settings error:&error];
        
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];//声音通过听筒输出
        
        //打开下面的注释将会使用扬声器播放
//        [[AVAudioSession sharedInstance] setActive: YES error: nil];
//        UInt32 doChangeDefault = 1;
//        AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefault), &doChangeDefault);
        
        
        if (self.recorder) {
            self.recorder.delegate = self;
            self.recorder.meteringEnabled = YES;
            [self.recorder prepareToRecord];
        } else {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
        
    }
    
    return self;
}

- (BOOL)record {
    return [self.recorder record];
}

- (void)pause {
    [self.recorder pause];
}

-(void)stopMyRecord{
    [self.recorder stop];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)success {
    
    if (self.stopRecord) {
        self.stopRecord(success);
    }
}

- (void)saveRecordWithName:(NSString *)name completeDo:(void (^)(BOOL ok ,id object))result{
    NSTimeInterval timestamp = [NSDate timeIntervalSinceReferenceDate];
    NSString *filename = [NSString stringWithFormat:@"%@-%f.m4a", name, timestamp];
    
    NSString *docsDir = [self documentsDirectory];
    NSString *destPath = [docsDir stringByAppendingPathComponent:filename];
    
    NSURL *srcURL = self.recorder.url;
    NSURL *destURL = [NSURL fileURLWithPath:destPath];
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] copyItemAtURL:srcURL toURL:destURL error:&error];
    if (success) {
        result(YES, [Record memoWithTitle:name url:destURL]);
        [self.recorder prepareToRecord];
    } else {
        result(NO, error);
    }

}


- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


- (BOOL)playRecord:(Record *)record {
    
    [self.player stop];
    NSLog(@"%@",record.url);
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:record.url error:nil];
    if (self.player) {
        [self.player play];
        return YES;
    }
    return NO;
}


- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder {
    if (self.delegate) {
        [self.delegate interruptionBegan];
    }
}

@end
