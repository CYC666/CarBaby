//
//  UserInformation.m
//  YiYanYunGou
//
//  Created by admin on 16/3/21.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UserInformation.h"

@implementation UserInformation

static UserInformation *instance;
+ (UserInformation *)sharedInstance{
    @synchronized(self) {
        if (!instance) {
            instance = [[UserInformation alloc]init];
        }
    }
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    @synchronized(self) {
        if (!instance) {
            instance = [super allocWithZone:zone];
        }
    }
    return instance;
}

- (NSMutableArray *)locationArray {
    if (_locationArray == nil) {
        _locationArray = [NSMutableArray array];
    }
    return _locationArray;
}



//清空所有数据，相当于退出账户
- (void)clearData{
    
    _UserId = nil;
    _EnCode = nil;
    _RealName = nil;
    _RoleType = nil;
    _RoleName = nil;
    _IDCard = nil;
    _NickName = nil;
    _HeadIcon = nil;
    _Gender = nil;
    _Birthday = nil;
    _Mobile = nil;
    _Email = nil;
    _QICQ = nil;
    _ProvinceId = nil;
    _ProvinceName = nil;
    _CityId = nil;
    _CityName = nil;
    _CountyId = nil;
    _CountyName = nil;
    _Address = nil;
    _Description = nil;
    _WithdrawPassword = nil;
    _IsSpecial = nil;
    _EnabledMark = nil;
}
//判断是否登录了
- (BOOL)isLoginWithUserId{
    
    if ([_UserId isEqualToString:@""] || _UserId == nil) {
        return NO;
    } else {
        return YES;
    }
    
}



@end
