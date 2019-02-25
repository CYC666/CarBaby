//
//  ShowController.m
//  BaseProject
//
//  Created by 曹老师 on 2019/2/25.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import "ShowController.h"

@interface ShowController ()

@property (weak, nonatomic) IBOutlet UIImageView *icon1;
@property (weak, nonatomic) IBOutlet UIImageView *icon2;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;
@property (weak, nonatomic) IBOutlet UILabel *label10;
@property (weak, nonatomic) IBOutlet UILabel *label11;
@property (weak, nonatomic) IBOutlet UILabel *label12;
@property (weak, nonatomic) IBOutlet UILabel *label13;
@property (weak, nonatomic) IBOutlet UILabel *label14;
@property (weak, nonatomic) IBOutlet UILabel *label15;
@property (weak, nonatomic) IBOutlet UILabel *label16;
@property (weak, nonatomic) IBOutlet UILabel *label17;
@property (weak, nonatomic) IBOutlet UILabel *label18;


@end

@implementation ShowController


#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [_icon1 sd_setImageWithURL:[NSURL URLWithString:self.model.filepath]];
    [_icon2 sd_setImageWithURL:[NSURL URLWithString:self.model.backfilepath]];
    
    self.label1.text = [NSString stringWithFormat:@"钱币名称: %@", self.model.fullname];
    self.label2.text = [NSString stringWithFormat:@"目录编号: %@", self.model.encode];
    self.label3.text = [NSString stringWithFormat:@"国家: %@", self.model.barcode];
    self.label4.text = [NSString stringWithFormat:@"发行日期: %@", self.model.issuedate];
    self.label5.text = [NSString stringWithFormat:@"最后发型年份 %@", self.model.lastreleaseyear];
    self.label6.text = [NSString stringWithFormat:@"使用: %@", self.model.synopsis];
    self.label7.text = [NSString stringWithFormat:@"组成: %@", self.model.composition];
    self.label8.text = [NSString stringWithFormat:@"形状: %@", self.model.shape];
    self.label9.text = [NSString stringWithFormat:@"重量: %@", self.model.weight];
    self.label10.text = [NSString stringWithFormat:@"尺寸: %@", self.model.size];
    self.label11.text = [NSString stringWithFormat:@"面值: %@", self.model.facevalue];
    self.label12.text = [NSString stringWithFormat:@"正面: %@", self.model.positive];
    self.label13.text = [NSString stringWithFormat:@"背面: %@", self.model.back];
    self.label14.text = [NSString stringWithFormat:@"备注: %@", self.model.des];
    self.label15.text = [NSString stringWithFormat:@"排序号: %@", self.model.sortcode];
    self.label16.text = [NSString stringWithFormat:@"创建时间: %@", self.model.createdate];
    self.label17.text = [NSString stringWithFormat:@"收藏状态: %@", self.model.iscollect];
    self.label18.text = [NSString stringWithFormat:@"币种类型名: %@", self.model.currencytypename];
}


#pragma mark ========================================动作响应=============================================




#pragma mark ========================================网络请求=============================================


#pragma mark ========================================代理方法=============================================






































@end
