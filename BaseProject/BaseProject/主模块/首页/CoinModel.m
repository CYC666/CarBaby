//
//  CoinModel.m
//  BaseProject
//
//  Created by 曹老师 on 2019/2/25.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import "CoinModel.h"

@implementation CoinModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"des" : @"description"};
    
}

- (void)setFilepath:(NSString *)filepath {
    
    _filepath = [NSString stringWithFormat:@"%@%@", Image_Base_URL, filepath];
    
}

- (void)setBackfilepath:(NSString *)backfilepath {
    
    _backfilepath = [NSString stringWithFormat:@"%@%@", Image_Base_URL, backfilepath];
    
}


@end
