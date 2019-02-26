//
//  NetTool.h
//  BaseProject
//
//  Created by 曹老师 on 2019/2/25.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^IdBlock)(id object);

@interface NetTool : NSObject

// 获取钱币列表
+ (void)loadCoinList:(NSInteger)pageIndex List:(IdBlock)listBlock;

// 获取消息列表
+ (void)loadNewsList:(NSInteger)pageIndex List:(IdBlock)listBlock;

// 获取钱币目录
+ (void)loadCoinEnumList:(NSInteger)pageIndex List:(IdBlock)listBlock;

@end

NS_ASSUME_NONNULL_END
