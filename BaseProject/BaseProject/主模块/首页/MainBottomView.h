//
//  MainBottomView.h
//  BaseProject
//
//  Created by 曹老师 on 2019/2/26.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *button1; // 消息
@property (weak, nonatomic) IBOutlet UIButton *button2; // 收藏
@property (weak, nonatomic) IBOutlet UIButton *button3; // 展开
@property (weak, nonatomic) IBOutlet UIButton *button4; // 保存
@property (weak, nonatomic) IBOutlet UIButton *button5; // 分享

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;


@end

NS_ASSUME_NONNULL_END
