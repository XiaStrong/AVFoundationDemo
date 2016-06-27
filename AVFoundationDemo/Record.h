//
//  Record.h
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/26.
//  Copyright © 2016年 X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+XQDate.h"
@interface Record : NSObject<NSCoding>

@property (copy, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSURL *url;
@property (copy, nonatomic, readonly) NSString *dateString;

+ (instancetype)memoWithTitle:(NSString *)title url:(NSURL *)url;

- (BOOL)deleteMemo;


@end
