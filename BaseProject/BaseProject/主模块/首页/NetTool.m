//
//  NetTool.m
//  BaseProject
//
//  Created by 曹老师 on 2019/2/25.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import "NetTool.h"
#import "CoinModel.h"
#import "MessageModel.h"

@implementation NetTool


// 获取钱币列表
+ (void)loadCoinList:(NSInteger)pageIndex List:(IdBlock)listBlock {
    
    NSString *PageIndex = [NSString stringWithFormat:@"%ld", pageIndex];
    
    NSString *method = [NSString stringWithFormat:@"GetPageCommodity"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"default",@"UserId",
                         @"25",@"PageSize",
                         PageIndex,@"PageIndex",
                         @"default",@"Level1",
                         @"default",@"Level2",
                         @"default",@"Level3",
                         @"default",@"FullName",
                         @"default",@"HomeMark",
                         @"default",@"IsPopularity",
                         @"100",@"MallMark",
                         nil];
    
    SVP_SHOW(@"加载中")
    [SOAPUrlSession SOAPDataWithMethod:method parameter:dic success:^(id responseObject) {
        
        
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"Code"]];
        
        NSMutableArray *tempList = [NSMutableArray array];
        if ([code isEqualToString:@"200"]) {
            
            
            NSArray *list = responseObject[@"Data"][@"rows"];
            for (NSDictionary *dic in list) {
                [tempList addObject:[CoinModel mj_objectWithKeyValues:dic]];
            }
            
            
        }
        listBlock(tempList);
        SVP_DISMISS
        
        
        
    } failure:^(NSError *error) {
        
        listBlock(@[]);
        SVP_DISMISS
        
    }];
    
    
}


// 获取钱币列表
+ (void)loadNewsList:(NSInteger)pageIndex List:(IdBlock)listBlock {
    
    NSString *PageIndex = [NSString stringWithFormat:@"%ld", pageIndex];
    
    NSString *method = [NSString stringWithFormat:@"GetInformationPageList"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"20",@"PageSize",
                         PageIndex,@"PageIndex",
                         @"default",@"Keyword",
                         @"default",@"Category",
                         @"default",@"UserId",
                         nil];
    
    SVP_SHOW(@"加载中")
    [SOAPUrlSession SOAPDataWithMethod:method parameter:dic success:^(id responseObject) {
        
        
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"Code"]];
        
        NSMutableArray *tempList = [NSMutableArray array];
        if ([code isEqualToString:@"200"]) {
            
            
            NSArray *list = responseObject[@"Data"][@"rows"];
            for (NSDictionary *dic in list) {
                [tempList addObject:[MessageModel mj_objectWithKeyValues:dic]];
            }
            
            
        }
        listBlock(tempList);
        SVP_DISMISS
        
        
        
    } failure:^(NSError *error) {
        
        listBlock(@[]);
        SVP_DISMISS
        
    }];
    
    
}


// 获取钱币目录
+ (void)loadCoinEnumList:(NSInteger)pageIndex List:(IdBlock)listBlock {
    
    NSString *PageIndex = [NSString stringWithFormat:@"%ld", pageIndex];

    NSString *method = [NSString stringWithFormat:@"GetPageCommodity"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"default",@"UserId",
                         @"100",@"PageSize",
                         PageIndex,@"PageIndex",
                         @"default",@"Level1",
                         @"default",@"Level2",
                         @"default",@"Level3",
                         @"default",@"FullName",
                         @"default",@"HomeMark",
                         @"default",@"IsPopularity",
                         @"100",@"MallMark",
                         nil];
    
    SVP_SHOW(@"加载中")
    [SOAPUrlSession SOAPDataWithMethod:method parameter:dic success:^(id responseObject) {
        
        
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"Code"]];
        
        NSMutableArray *tempList = [NSMutableArray array];
        if ([code isEqualToString:@"200"]) {
            
            
            NSArray *list = responseObject[@"Data"][@"rows"];
            for (NSDictionary *dic in list) {
                [tempList addObject:[CoinModel mj_objectWithKeyValues:dic]];
            }
            
            
        }
        listBlock(tempList);
        SVP_DISMISS
        
        
        
    } failure:^(NSError *error) {
        
        listBlock(@[]);
        SVP_DISMISS
        
    }];
    
    
}



@end
