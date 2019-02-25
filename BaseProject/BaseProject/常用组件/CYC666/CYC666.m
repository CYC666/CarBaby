//
//  CYC666.m
//  BaseProject
//
//  Created by 曹老师 on 2018/8/13.
//  Copyright © 2018年 众利创投. All rights reserved.
//

#import "CYC666.h"
#import "UITextField+Action.h"

@implementation CYC666

#pragma mark ========================================字符串=============================================
#pragma mark - 判断日期字符串str1是否比str2大 （yyyy-MM-dd）0相等 1大于 2小于 3其他错误
+ (NSInteger)checkBigDate:(NSString *)str1 smallDate:(NSString *)str2 {
    
    NSArray *startList = [str1 componentsSeparatedByString:@"-"];
    NSArray *endList = [str2 componentsSeparatedByString:@"-"];
    
    if (startList.count < 3 || endList.count < 3) {
        return 3;
    }
    
    NSInteger startValue = [startList[0] integerValue] * 360 + [startList[1] integerValue] * 30 + [startList[2] integerValue];
    NSInteger endValue = [endList[0] integerValue] * 360 + [endList[1] integerValue] * 30 + [endList[2] integerValue];
    
    if (startValue > endValue) {
        return 1;
    } else if (startValue == endValue) {
        return 0;
    } else {
        return 2;
    }
    
    
}

#pragma mark - 判断时间字符串str1是否比str2大 （hh:mm:ss）0相等 1大于 2小于 3其他错误
+ (NSInteger)checkBigTime:(NSString *)str1 smallTime:(NSString *)str2 {
    
    NSArray *startList = [str1 componentsSeparatedByString:@":"];
    NSArray *endList = [str2 componentsSeparatedByString:@":"];
    
    if (startList.count < 3 || endList.count < 3) {
        return 3;
    }
    
    NSInteger startValue = [startList[0] integerValue] * 360 + [startList[1] integerValue] * 30 + [startList[2] integerValue];
    NSInteger endValue = [endList[0] integerValue] * 360 + [endList[1] integerValue] * 30 + [endList[2] integerValue];
    
    if (startValue > endValue) {
        return 1;
    } else if (startValue == endValue) {
        return 0;
    } else {
        return 2;
    }
    
    
}

#pragma mark - 判断日期时间字符串str1是否比str2大 （yyyy-MM-dd hh:mm:ss）0相等 1大于 2小于 3其他错误
+ (NSInteger)checkBigDateTime:(NSString *)str1 smallDateTime:(NSString *)str2 {
    
    NSArray *list1 = [str1 componentsSeparatedByString:@" "];
    NSArray *list2 = [str2 componentsSeparatedByString:@" "];
    
    if (list1.count < 2 || list2.count < 2) {
        return 3;
    }
    
    if ([self checkBigDate:list1.firstObject smallDate:list2.firstObject] == 1) {
        return 1;
    } else if ([self checkBigDate:list1.firstObject smallDate:list2.firstObject] == 0) {
        
        if ([self checkBigTime:list1.lastObject smallTime:list2.lastObject] == 1) {
            return 1;
        } else if ([self checkBigTime:list1.lastObject smallTime:list2.lastObject] == 0) {
            return 0;
        } else {
            return 2;
        }
        
    } else {
        return 2;
    }
}

#pragma mark - 获取两个日期的天数差  (日期格式yyyy-MM-dd)
+ (NSInteger)getDistanceByDay1:(NSString *)day1 day2:(NSString *)day2 {
    
    // 将入住日转为时间戳
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat = @"yyyy-MM-dd";
    NSDate *date1 = [formatter1 dateFromString:day1];
    NSInteger timeSp1 = [[NSNumber numberWithDouble:[date1 timeIntervalSince1970]] integerValue];
    
    // 将离开日转为时间戳
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    formatter2.dateFormat = @"yyyy-MM-dd";
    NSDate *date2 = [formatter2 dateFromString:day2];
    NSInteger timeSp2 = [[NSNumber numberWithDouble:[date2 timeIntervalSince1970]] integerValue];
    
    NSInteger dayCount = (timeSp2 - timeSp1) / (24 * 60 * 60);
    
    return dayCount;
    
}

#pragma mark - 判断字符串是否是空的
+ (BOOL)isEmptyString:(NSString *)text {
    return [text isKindOfClass:[NSNull class]] || text == nil || [text length] < 1 ? YES : NO ;
}

#pragma mark ========================================按钮=============================================

#pragma mark - 创建一个按钮，不需要设置的值传nil即可
+ (UIButton *)creatButton:(UIView *)superView
                    Frame:(CGRect)frame
                    Image:(NSString *)image
                    Title:(NSString *)title
               TitleColor:(UIColor *)titleColor
          BackgroundColor:(UIColor *)bgColor {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (image) {
         [button setImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (bgColor) {
        button.backgroundColor = bgColor;
    }
    
    [superView addSubview:button];
    return button;
}



#pragma mark ========================================输入框=============================================

#pragma mark - 设置几个输入框，点击return，下个输入框自动变成第一响应者
+ (void)setTextFieldsActive:(NSArray<UITextField *> *)fields {
    
    for (NSInteger i = 0; i < fields.count; i++) {
        
        UITextField *field = fields[i];
        field.returnKeyType = UIReturnKeyNext;
        
        [field addReturnAction:^{
            // 点击了return
            if (i != fields.count-1) {
                
                // 不是最后一个，那么回车跳到下一个
                UITextField *field2 = fields[i+1];
                [field2 becomeFirstResponder];
                
            } else {
                
                // 最后一个，收起键盘
                [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            }
        }];
        
        
        
    }
    
    
}























@end
