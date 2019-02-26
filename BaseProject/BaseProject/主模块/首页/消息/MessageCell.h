//
//  MessageCell.h
//  BaseProject
//
//  Created by 曹老师 on 2019/2/26.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : UITableViewCell

@property (strong, nonatomic) MessageModel *model;


@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;


@end

NS_ASSUME_NONNULL_END
