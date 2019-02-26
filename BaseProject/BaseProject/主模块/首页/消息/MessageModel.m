//
//  MessageModel.m
//  BaseProject
//
//  Created by 曹老师 on 2019/2/26.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel


- (void)setFilepath:(NSString *)filepath {
    _filepath = [NSString stringWithFormat:@"%@%@", Image_Base_URL, filepath];
}

@end
