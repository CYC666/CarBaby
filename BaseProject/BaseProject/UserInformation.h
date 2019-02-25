//
//  UserInformation.h
//  YiYanYunGou
//
//  Created by admin on 16/3/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInformation : NSObject

//根据后台的JSON数据设置属性
@property (copy, nonatomic) NSString *UserId;
@property (copy, nonatomic) NSString *EnCode;
@property (copy, nonatomic) NSString *RealName;
@property (copy, nonatomic) NSString *RoleType;
@property (copy, nonatomic) NSString *RoleName;
@property (copy, nonatomic) NSString *IDCard;
@property (copy, nonatomic) NSString *NickName;
@property (copy, nonatomic) NSString *HeadIcon;
@property (copy, nonatomic) NSString *Gender;
@property (copy, nonatomic) NSString *Birthday;
@property (copy, nonatomic) NSString *Mobile;
@property (copy, nonatomic) NSString *Email;
@property (copy, nonatomic) NSString *QICQ;
@property (copy, nonatomic) NSString *ProvinceId;
@property (copy, nonatomic) NSString *ProvinceName;
@property (copy, nonatomic) NSString *CityId;
@property (copy, nonatomic) NSString *CityName;
@property (copy, nonatomic) NSString *CountyId;
@property (copy, nonatomic) NSString *CountyName;
@property (copy, nonatomic) NSString *Address;
@property (copy, nonatomic) NSString *Description;
@property (copy, nonatomic) NSString *WithdrawPassword;
@property (copy, nonatomic) NSString *IsSpecial;
@property (copy, nonatomic) NSString *EnabledMark;

@property (strong, nonatomic) NSMutableArray *locationArray;    // 储存地址




//单例模式
+ (UserInformation *)sharedInstance;

//清空所有数据，相当于退出账户
- (void)clearData;
//判断是否登录
- (BOOL)isLoginWithUserId;


@end





//"UserId": "62a62a55d3bc4648b2ef74d89196689f",
//"EnCode": "YR20",
//"RealName": "",
//"RoleType": 0,
//"RoleName": "普通用户",
//"IDCard": "",
//"NickName": "",
//"HeadIcon": "",
//"Gender": "",
//"Birthday": "",
//"Mobile": "13705038428",
//"Email": "",
//"QICQ": "",
//"ProvinceId": "",
//"ProvinceName": "",
//"CityId": "",
//"CityName": "",
//"CountyId": "",
//"CountyName": "",
//"Address": "",
//"Description": "",
//"WithdrawPassword": "",
//"IsSpecial": 0,
//"EnabledMark": 1



























