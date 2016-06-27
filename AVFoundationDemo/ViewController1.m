//
//  ViewController1.m
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/24.
//  Copyright © 2016年 X. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()
{
    XQSpeaker *speaker;
}

@end

@implementation ViewController1



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *text=@"6月20日考察中国人民银行时，李克强总理就去年8月完善人民币汇率形成机制改革明确表示：“无论从目的还是结果看，我们的改革都是使人民币汇率在合理均衡水平上保持基本稳定。”2015年8月，中国人民银行宣布决定完善人民币兑美元中间价报价，以增强人民币汇率中间价的市场化程度和基准性。这一改革被普遍认为是人民币汇率形成机制市场化改革迈出了重要一步。但这期间，也曾引发一些境外机构关于“人民币贬值”的忧虑。";
    
    _content.text=text;
    
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"读" style:UIBarButtonItemStylePlain target:self action:@selector(start)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"暂停" style:UIBarButtonItemStylePlain target:self action:@selector(nowStop)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"继续" style:UIBarButtonItemStylePlain target:self action:@selector(continueRead)];
    
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithTitle:@"停止" style:UIBarButtonItemStylePlain target:self action:@selector(stop)];



    self.navigationItem.rightBarButtonItems = @[item1,item2,item3,item4];


    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    speaker=[[XQSpeaker alloc]init];
    // Do any additional setup after loading the view from its nib.
}



-(void)start{
    [speaker goToReadText:_content.text];
}


-(void)stop{
    [speaker stop];
}


-(void)nowStop{
    [speaker nowStop];
}

- (void)continueRead{

    [speaker continueRead];
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
