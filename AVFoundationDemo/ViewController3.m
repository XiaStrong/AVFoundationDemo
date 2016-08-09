//
//  ViewController3.m
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/7/8.
//  Copyright © 2016年 X. All rights reserved.
//

#import "ViewController3.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

#define myUserDefault [NSUserDefaults standardUserDefaults]


@interface ViewController3 ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSURL *url;
}
@end

@implementation ViewController3






- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *item0 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(start)];
    UIBarButtonItem *item1 =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(play)];


    self.navigationItem.rightBarButtonItems = @[item0,item1];

    if ([self videoRecordingAvailable]) {
        
        item0.enabled=YES;
        item1.enabled=YES;
    }else{
        item0.enabled=NO;
        item1.enabled=NO;

        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:nil message:@"当前设备不支持录影" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
    // Do any additional setup after loading the view from its nib.
}

-(void)play{
    
    MPMoviePlayerViewController *mpv=[[MPMoviePlayerViewController alloc]initWithContentURL:url];
    mpv.moviePlayer.allowsAirPlay = YES;
    mpv.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    
    [self.navigationController presentViewController:mpv animated:YES completion:nil];
    
}





-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    url = nil;
    url = info[@"UIImagePickerControllerMediaURL"];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)start{
    
    UIImagePickerController *picker =[[UIImagePickerController alloc]init];
    picker.sourceType=UIImagePickerControllerSourceTypeCamera;
    //录影质量
    picker.videoQuality=UIImagePickerControllerQualityTypeMedium;
    picker.mediaTypes=@[(NSString *)kUTTypeMovie];
    NSLog(@"%@",picker.mediaTypes);
    picker.delegate=self;
    
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}



//检查设备是否可以进行视屏录制
-(BOOL)videoRecordingAvailable{
    
    //判断是否有摄像头
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        return NO;
    }
    
    //捕获的媒体类型
    NSArray *mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    
    //判断媒体类型中是否有视屏这项
    return ([mediaTypes containsObject:(NSString *)kUTTypeMovie]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
