//
//  ShowController.h
//  BaseProject
//
//  Created by 曹老师 on 2019/2/25.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoinModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShowController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) CoinModel *model;

@end

NS_ASSUME_NONNULL_END
