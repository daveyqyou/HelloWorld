//
//  ViewController.m
//  YQAlertView
//
//  Created by yongqiang.you on 2017/4/1.
//  Copyright © 2017年 yongqiang.you. All rights reserved.
//

#import "ViewController.h"
#import "YQAlertView.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *clickedBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.clickedBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 100, 40)];
    [self.clickedBtn setTitle:@"点击弹窗" forState:UIControlStateNormal];
    [self.clickedBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    self.clickedBtn.backgroundColor = [UIColor blackColor];
    [self.clickedBtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.clickedBtn];
}
- (void)clicked:(UIButton *)sender {
    YQAlertView *tmpView = [YQAlertView alterViewWithChooseBoy:@" 男" girl:@" 女"];
    [self.view addSubview:tmpView];
}

@end
