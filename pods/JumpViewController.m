//
//  JumpViewController.m
//  pods
//
//  Created by 高山峰 on 2017/5/17.
//  Copyright © 2017年 高山峰. All rights reserved.
//

#import "JumpViewController.h"
#import "Masonry.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface JumpViewController ()

@end

@implementation JumpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Masonry";
    UIView *view1 = [[UIView alloc]init];
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding.bottom);
        make.right.equalTo(self.view.mas_right).with.offset(-padding.right);
    }];
    
    WS(ws);
    UIView *sv = [UIView new];
    sv.backgroundColor = [UIColor blackColor];
    [view1 addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
    UIView *sv1 = [UIView new];
    sv1.backgroundColor = [UIColor redColor];
    [sv addSubview:sv1];
    [sv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv).with.insets(padding);
    }];
    
    UIImageView *leftview = [[UIImageView alloc]init];
    leftview.backgroundColor = [UIColor whiteColor];
    leftview.image = [UIImage imageNamed:@"loadVideo"];
    [sv1 addSubview:leftview];
    UIImageView *rightView = [[UIImageView alloc]init];
    rightView.image = [UIImage imageNamed:@"loadVideo"];
    rightView.backgroundColor = [UIColor whiteColor];
    [sv1 addSubview:rightView];
    int padding1 = 10;
    [leftview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sv1.mas_centerY);
        make.left.equalTo(sv1.mas_left).with.offset(padding1);
        make.right.equalTo(rightView.mas_left).with.offset(-padding1);
        make.height.mas_equalTo(@150);
        make.width.equalTo(rightView);
    }];

    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sv1.mas_centerY);
        make.left.equalTo(leftview.mas_right).with.offset(padding1);
        make.right.equalTo(sv1.mas_right).with.offset(-padding1);
        make.height.mas_equalTo(@150);
        make.width.equalTo(leftview);
    }];
    
    UIButton *button = [UIButton new];
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClick) forControlEvents:UIControlEventTouchUpInside];
    [sv1 addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightView.mas_bottom).with.offset(padding1);
        make.right.equalTo(rightView.mas_right).with.offset(-padding1);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
    }];
    
}
-(void)didClick{
    
}

@end
