//
//  Record.m
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/26.
//  Copyright © 2016年 X. All rights reserved.
//

#import "Record.h"

@implementation Record

+ (instancetype)memoWithTitle:(NSString *)title url:(NSURL *)url {
    return [[self alloc] initWithTitle:title url:url];
}

- (id)initWithTitle:(NSString *)title url:(NSURL *)url {
    self = [super init];
    if (self) {
        _title = [title copy];
        _url = url;
        
        NSDate *date = [NSDate date];
        _dateString = [NSDate dateStringWithDate:date] ;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    
    
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.url forKey:@"url"];
    [coder encodeObject:self.dateString forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        _title = [decoder decodeObjectForKey:@"title"];
        _url = [decoder decodeObjectForKey:@"url"];
        _dateString = [decoder decodeObjectForKey:@"date"];
    }
    return self;
}


- (BOOL)deleteMemo {
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] removeItemAtURL:self.url error:&error];
    if (!success) {
        NSLog(@"Unable to delete: %@", [error localizedDescription]);
    }
    return success;
}

@end
