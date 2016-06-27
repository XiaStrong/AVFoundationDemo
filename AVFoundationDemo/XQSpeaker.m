//
//  XQSpeaker.m
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/24.
//  Copyright © 2016年 X. All rights reserved.
//

#import "XQSpeaker.h"


@implementation XQSpeaker

+ (instancetype) sharedInstance {
    static dispatch_once_t onceToken;
    static id sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


-(id)init{
    
    if (self =[super init]) {
        _synthesizer =[[AVSpeechSynthesizer alloc]init];
    }
    return self;

}

- (void)goToReadText:(NSString *)string{
    
    AVSpeechUtterance *speech =[[AVSpeechUtterance alloc] initWithString:string];
    speech.voice=[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    speech.rate = 0.4f;//语速
    speech.pitchMultiplier = 1.0f;//音高
    speech.postUtteranceDelay = 0.1f;//目的是让语音合成器播放下一语句前有短暂的暂停
    [_synthesizer speakUtterance:speech];

}

-(void)stop{
    
    [_synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}


-(void)nowStop{
    
    [_synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
}

- (void)continueRead{
    [_synthesizer continueSpeaking];
    
}



@end
