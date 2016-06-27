//
//  ViewController.m
//  AVFoundationDemo
//
//  Created by Xia_Q on 16/6/24.
//  Copyright © 2016年 X. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *dataArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"多媒体应用";
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    dataArr=@[@"语音朗读",@"语音记录"];
    _myTab.delegate=self;
    _myTab.dataSource=self;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        ViewController1 *vc = [[ViewController1 alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row ==1) {
        ViewController2 *vc2 =[[ViewController2 alloc]init];
        [self.navigationController pushViewController:vc2 animated:YES];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *str=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:str];
    
    if (cell == nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    cell.textLabel.text = dataArr[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
