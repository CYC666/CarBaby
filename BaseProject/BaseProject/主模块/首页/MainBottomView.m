//
//  MainBottomView.m
//  BaseProject
//
//  Created by 曹老师 on 2019/2/26.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import "MainBottomView.h"

@interface MainBottomView ()  {
    
    
}

@property (assign, nonatomic) BOOL didShow;


@end

@implementation MainBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"MainBottomView" owner:nil options:nil] firstObject];
        self.frame = frame;
    }
    return self;
    
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    // 防止frame错乱
    self.autoresizingMask = UIViewAutoresizingNone;
    
    _width.constant = 0;
    [_button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)button3Action {
    
    _didShow = !_didShow;
    
    float angle = 0;
    
    
    if (_didShow) {
        
        // 展开
        _width.constant = (kScreenWidth - 10 * 6 - 50) / 5.0;
        angle = -M_PI_4;
    } else {
        
        // 收起
        _width.constant = 0;
        angle = 0;
    }
    
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:.2 animations:^{
        [self layoutIfNeeded];
        _button3.transform = CGAffineTransformMakeRotation(angle);
    }];
    
}


































@end
