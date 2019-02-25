//
//  CYC666.h
//  BaseProject
//
//  Created by 曹老师 on 2018/8/13.
//  Copyright © 2018年 众利创投. All rights reserved.
//

#import <Foundation/Foundation.h>


// 打印 #str 相当于给str加""
#define CYCLog(str) [NSString stringWithFormat:@"%@",@#str]

// 弱引用 ## 相当于把两个值拼接在一起
#define CYCWeakSelf(type)  __weak typeof(type) weak##type = type;

// 提示(不加符号)
#define SHOW_HUD(msg) [SVProgressHUD showWithStatus:@#msg];
#define ERROR_HUD(msg) [SVProgressHUD showErrorWithStatus:@#msg];[SVProgressHUD dismissWithDelay:1.5];
#define SUCCESS_HUD(msg) [SVProgressHUD showSuccessWithStatus:@#msg];[SVProgressHUD dismissWithDelay:1.5];
#define DISMISS_HUD [SVProgressHUD dismiss];

// 圆角
#define CRadius(View,Radius) [View.layer setCornerRadius:(Radius)]; [View.layer setMasksToBounds:YES];
#define CRadiusBorder(View,Radius,Color,Width) [View.layer setCornerRadius:(Radius)];[View.layer setMasksToBounds:YES];[View.layer setBorderWidth:(Width)];[View.layer setBorderColor:[Color CGColor]];

// 图片
#define CImage(name) [UIImage imageNamed:name]

// 按钮
#define CButtonTitle(Button,Title) [Button setTitle:Title forState:UIControlStateNormal];
#define CButtonColor(Button,Color) [Button setTitleColor:Color forState:UIControlStateNormal];
#define CButtonImage(Button,Name) [Button setImage:CImage(Name) forState:UIControlStateNormal];

//弹出提示
#define SVP_STATUS(msg) [SVProgressHUD showWithStatus:msg];[SVProgressHUD dismissWithDelay:1.5];
#define SVP_ERROR(msg) [SVProgressHUD showErrorWithStatus:msg];[SVProgressHUD dismissWithDelay:1.5];
#define SVP_SUCCESS(msg) [SVProgressHUD showSuccessWithStatus:msg];[SVProgressHUD dismissWithDelay:1.5];
#define SVP_INFO(msg) [SVProgressHUD showWithStatus:msg];[SVProgressHUD dismissWithDelay:1.5];
#define SVP_SHOW(msg) [SVProgressHUD showWithStatus:msg];
#define SVP_DISMISS [SVProgressHUD dismiss];

//设置状态栏样式
#define CStatusLight [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
#define CStatusDefault [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;


typedef void(^CYC666VoidBlock)(void);
typedef void(^CYC666IdBlock)(id object);

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

// 创建一个富文本字符串
+ (NSMutableAttributedString *)loadMutableStringWithString:(NSString *)text
                                               lineSpacing:(CGFloat)lineSpacing
                                          paragraphSpacing:(CGFloat)paragraphSpacing;

// 创建一个图文混排的富文本
+ (NSMutableAttributedString *)loadMutableStringWithString:(NSString *)text
                                                 imageName:(NSString *)name
                                                    bounds:(CGRect)bounds
                                                     index:(NSInteger)index;

// 计算文本的大小
+ (CGSize)loadSizeWithString:(NSString *)text
                       width:(CGFloat)width
                    fontSize:(CGFloat)fontSize
                   attribute:(NSMutableAttributedString *)attribute;

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

//============================================视图===========================================
// 指定圆角
+ (void)cornerRadiusAction:(UIView *)view
                    radius:(CGFloat)radius
         byRoundingCorners:(UIRectCorner)corners;

// 颜色渐变
+ (void)flowColorWithView:(UIView *)view
                   color1:(UIColor *)color1
                   color2:(UIColor *)color2
               startPoint:(CGPoint)point1
                 endPoint:(CGPoint)point2;

// 暂无数据页面 分页20
+ (void)setReloadAndNoDataView:(UITableView *)tableView list:(NSArray *)list;

// 颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color;


@end

