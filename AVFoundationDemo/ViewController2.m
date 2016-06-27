//
//  ViewController2.m
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/26.
//  Copyright © 2016年 X. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()<XQRecorderDelegate,UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;

    _recorder = [[XQRecorder alloc] init];
    _recorder.delegate = self;
    _dataArr = [NSMutableArray array];
    self.stop.enabled = NO;
    
    _myTab.delegate=self;
    _myTab.dataSource=self;
    NSData *data = [NSData dataWithContentsOfURL:[self archiveURL]];
    
    if (!data) {
        _dataArr = [NSMutableArray array];
    } else {
        _dataArr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)interruptionBegan {
    self.start.selected = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)start:(id)sender {
    self.stop.enabled = YES;
    
    if (![sender isSelected]) {
        [_act startAnimating];
        
        [self.recorder record];
    } else {
        [_act stopAnimating];
        [self.recorder pause];

    }
    
    [sender setSelected:![sender isSelected]];

}

- (IBAction)stop:(id)sender {
    [_act stopAnimating];
    self.start.selected = NO;
    self.stop.enabled = NO;
    [self.recorder stopMyRecord];

    __weak typeof(self)weakSelf = self;
    
    [self.recorder setStopRecord:^(BOOL result) {
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_MSEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"保存"
                                                                message:@"请命名"
                                                               delegate:weakSelf
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles:@"确定", nil];
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            UITextField *textField = [alertView textFieldAtIndex:0];
            textField.text = @"录音-1";
            [alertView show];
        });
    }];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        
        NSString *filename = [alertView textFieldAtIndex:0].text;
        
        [self.recorder saveRecordWithName:filename completeDo:^(BOOL ok, id object) {
            if (ok) {
                
                [self.dataArr addObject:object];
                [self saveMemos];
                [self.myTab reloadData];
                
                
            } else {
                NSLog(@"错误信息: %@", [object localizedDescription]);
            }
        }];
        
    }
}

- (void)saveMemos {
    NSData *fileData = [NSKeyedArchiver archivedDataWithRootObject:self.dataArr];
    [fileData writeToURL:[self archiveURL] atomically:YES];
}

- (NSURL *)archiveURL {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    NSString *archivePath = [docsDir stringByAppendingPathComponent:@"records.archive"];
    return [NSURL fileURLWithPath:archivePath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *str=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str ] ;
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    Record *memo = self.dataArr[indexPath.row];
    cell.textLabel.text =memo.title;
    cell.detailTextLabel.text = memo.dateString;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Record *memo = self.dataArr[indexPath.row];
    [self.recorder playRecord:memo];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Record *memo = self.dataArr[indexPath.row];
        [memo deleteMemo];
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [self saveMemos];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


@end
