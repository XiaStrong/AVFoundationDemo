//
//  ViewController2.h
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/26.
//  Copyright © 2016年 X. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQRecorder.h"
#import "Record.h"
@interface ViewController2 : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *start;
@property (weak, nonatomic) IBOutlet UIButton *stop;
@property (weak, nonatomic) IBOutlet UITableView *myTab;

- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *act;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (strong, nonatomic) XQRecorder *recorder;

@end
