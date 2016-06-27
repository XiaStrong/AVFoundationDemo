//
//  XQSpeaker.h
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/24.
//  Copyright © 2016年 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface XQSpeaker : NSObject

@property (strong,nonatomic)AVSpeechSynthesizer *synthesizer;

+ (instancetype) sharedInstance;

- (void)goToReadText:(NSString *)string;

-(void)nowStop;//暂停

- (void)continueRead;//继续

-(void)stop;//停止


@end
