//
//  Macros.h
//  YiYanYunGou
//
//  Created by maco on 2017/4/25.
//  Copyright © 2017年 admin. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//打印函数名与行数
#ifdef  DEBUG
#define DebugLog(s, ...) NSLog(@"%s(%d): %@", __FUNCTION__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DebugLog(s, ...)
#endif

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#define kTipAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show]

#define kKeyWindow  [UIApplication sharedApplication].keyWindow

#define RGBA(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]
//通知中心
#define XTYWNotificationCenter [NSNotificationCenter defaultCenter]

#define PATH_OF_DOCUMENT  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kColorBrandGreen [UIColor colorWithHexString:@"0x2EBE76"]

#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)


//版本号
#define kVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define kVersionBuild [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

#define  kBadgeTipStr @"badgeTip"

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)

#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_HEIGHT/SCREEN_WIDTH >= 2)

#define FFFNavigatioBarHeight (IS_IPHONE_X?88.0:64.0)
#define FFFTabBarHeight (IS_IPHONE_X?73.0:49.0)
#define FFFXSafeAreaTopHeight (IS_IPHONE_X?44.0:20.0)
#define FFFXSafeAreaBottomHeight (IS_IPHONE_X?34.0:0)
#define kScaleFrom_iPhone5_Desgin(_X_) (_X_ * (SCREEN_WIDTH/320))

//高度或距离相关
#define BannerTitleTop (70 + (SCREEN_WIDTH - 70) *23/61.0 + 20)
#define BannerViewHeight  (SCREEN_HEIGHT - FFFTabBarHeight - 60.0)

//********************** 租房项目中使用的 ************************
#define FFFCurrentCityName [FFFAddressManager defaultManager].currentCityName//当前的选中城市名字
#define FFFCurrentCityID [FFFAddressManager defaultManager].currentCityCode//当前的选中城市

//一些存储的key
#define FFFKeyCurrentCityModel @"FFFCurrentCity"


//本地当前城市下的区域数据路径
#define FFFAreasPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"FFFAreas.data"]
//热门商圈、办公类型、团队规模
#define FFFBuildingType1Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"FFFBuildingType1.data"]
#define FFFBuildingType2Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"FFFBuildingType2.data"]
#define FFFBuildingType3Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"FFFBuildingType3.data"]
#define FFFBannerDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"FFFBannerDataPath.data"]
#endif /* Macros_h */
