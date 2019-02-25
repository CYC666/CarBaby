//
//  CYC666.h
//  BaseProject
//
//  Created by 曹老师 on 2018/8/13.
//  Copyright © 2018年 众利创投. All rights reserved.
//

#import <Foundation/Foundation.h>

// 圆角
#define CRadius(View,Radius) [View.layer setCornerRadius:(Radius)]; [View.layer setMasksToBounds:YES];
#define CRadiusBorder(View,Radius,Color,Width) [View.layer setCornerRadius:(Radius)];[View.layer setMasksToBounds:YES];[View.layer setBorderWidth:(Width)];[View.layer setBorderColor:[Color CGColor]];

// 图片
#define CImage(name) [UIImage imageNamed:name]

// 按钮
#define CButtonTitle(Button,Title) [Button setTitle:Title forState:UIControlStateNormal];
#define CButtonImage(Button,Image) [Button setImage:[UIImage imageName:Image] forState:UIControlStateNormal];

//弹出提示
#define SVP_ERROR(msg) [SVProgressHUD showErrorWithStatus:msg];[SVProgressHUD dismissWithDelay:1];
#define SVP_SUCCESS(msg) [SVProgressHUD showSuccessWithStatus:msg];[SVProgressHUD dismissWithDelay:1];


@interface CYC666 : NSObject

//============================================字符串===========================================
// 判断日期字符串str1是否比str2大 （yyyy-MM-dd）0相等 1大于 2小于 3其他错误
+ (NSInteger)checkBigDate:(NSString *)str1 smallDate:(NSString *)str2;

// 判断时间字符串str1是否比str2大 （hh:mm:ss）0相等 1大于 2小于 3其他错误
+ (NSInteger)checkBigTime:(NSString *)str1 smallTime:(NSString *)str2;

// 判断日期时间字符串str1是否比str2大 （yyyy-MM-dd hh:mm:ss）0相等 1大于 2小于 3其他错误
+ (NSInteger)checkBigDateTime:(NSString *)str1 smallDateTime:(NSString *)str2;

// 获取两个日期的天数差  (日期格式yyyy-MM-dd)
+ (NSInteger)getDistanceByDay1:(NSString *)day1 day2:(NSString *)day2;

// 判断字符串是否是空的
+ (BOOL)isEmptyString:(NSString *)text;

//============================================按钮===========================================
// 创建一个按钮
+ (UIButton *)creatButton:(UIView *)superView
                    Frame:(CGRect)frame
                    Image:(NSString *)image
                    Title:(NSString *)title
               TitleColor:(UIColor *)titleColor
          BackgroundColor:(UIColor *)bgColor;

//============================================输入框===========================================

// 设置几个输入框，点击return，下个输入框自动变成第一响应者
+ (void)setTextFieldsActive:(NSArray<UITextField *> *)fields;












@end
