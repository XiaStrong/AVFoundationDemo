//
//  XQRecorder.h
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/26.
//  Copyright © 2016年 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Record.h"
#import <AVFoundation/AVFoundation.h>


@protocol XQRecorderDelegate <NSObject>
- (void)interruptionBegan;
@end


@interface XQRecorder : NSObject<AVAudioRecorderDelegate>

@property (weak, nonatomic) id <XQRecorderDelegate> delegate;

@property (nonatomic, readonly) NSString *formattedCurrentTime;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) AVAudioRecorder *recorder;

@property (nonatomic,copy) void (^stopRecord)(BOOL result);

- (BOOL)record;//记录

- (void)pause;//暂停

-(void)stopMyRecord;//停止记录

- (void)saveRecordWithName:(NSString *)name completeDo:(void (^)(BOOL ok ,id object))result;//保存信息

- (BOOL)playRecord:(Record *)record;


@end
