//
//  EnumCell.h
//  BaseProject
//
//  Created by 曹老师 on 2019/2/26.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoinModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EnumCell : UITableViewCell

@property (strong, nonatomic) CoinModel *model;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;


@end

NS_ASSUME_NONNULL_END
