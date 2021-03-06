//
//  PageView.m
//  LittleAppOC
//
//  Created by 曹老师 on 2018/2/6.
//  Copyright © 2018年 CYC. All rights reserved.
//

#import "PageView.h"

// 点的宽高距离
#define pointWidth 25
#define pointHeight 2.5
#define pointDistance 8

// 视图宽高
#define selfWidth self.frame.size.width
#define selfHeight self.frame.size.height

// 默认点的个数
#define defaultCount 3

// 小点点颜色
#define deadColor [UIColor whiteColor]
#define liveColor CRGB(235,68,86,1)

@interface PageView ()  {
    
    NSInteger _pageCount;           // 总页数(不设置就默认三个)
    CGFloat width;
    CGFloat height;
    NSMutableArray *subviewArray;   // 储存子视图
    CALayer *currentLayer;          // 显示当前页的位置
    
}

@end

@implementation PageView

#pragma mark ========================================初始化方法=============================================
- (instancetype)initWithFrame:(CGRect)frame pageCount:(NSInteger)pageCount {
    
    if (self = [super initWithFrame:frame]) {
        
        _pageCount = pageCount;
        
    }
    return self;
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _pageCount = defaultCount;
        
    }
    return self;
    
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _pageCount = defaultCount;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self creatSubviewsAction];
    
    
}



#pragma mark ========================================私有方法=============================================

#pragma mark - UI模块
- (void)creatSubviewsAction {
    
    if (_pageCount == 0) {
        return;
    }
    // 计算x起点
    CGFloat xStart = (selfWidth - (pointWidth * _pageCount + pointDistance * (_pageCount - 1))) * 0.5;
    
    // 创建分页小点点按钮
    subviewArray = [NSMutableArray array];
    [self removeAllSubviews];
    
    for (NSInteger i = 0; i < _pageCount; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(xStart + (pointWidth + pointDistance) * i, (selfHeight - pointHeight) * 0.5, pointWidth, pointHeight);
        button.layer.cornerRadius = pointHeight * 0.1;
//        button.clipsToBounds = YES;
        button.tag = i;
        button.backgroundColor = deadColor;
        
        button.layer.shadowOffset = CGSizeMake(-1, 1);
        button.layer.shadowRadius = 1;
        button.layer.shadowOpacity = 0.3;
        button.layer.shadowColor = [UIColor blackColor].CGColor;
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [subviewArray addObject:button];
        
    }
    
    // 当前页
    if (currentLayer) {
        [currentLayer removeFromSuperlayer];
        currentLayer = nil;
    }
    currentLayer = [[CALayer alloc] init];
    currentLayer.frame = CGRectMake(xStart, (selfHeight - pointHeight) * 0.5, pointWidth, pointHeight);
    currentLayer.cornerRadius = pointHeight * 0.1;
    currentLayer.backgroundColor = liveColor.CGColor;
    [self.layer addSublayer:currentLayer];
    
    
    
    
}

#pragma mark - 设置当前页
- (void)setCurrentPage:(NSInteger)currentPage {
    
    if (currentPage < 0 || _pageCount <= 0 || subviewArray.count <= 0 || currentLayer == nil || currentPage > _pageCount-1) {
        return;
    }
    
    _currentPage = currentPage;
    
    UIView *indexView = subviewArray[_currentPage];
    currentLayer.frame = indexView.frame;
    
}


#pragma mark - 点击了分页小点点
- (void)buttonAction:(UIButton *)button {
    
//    self.currentPage = button.tag;
    
//    [_delegate PageViewSelectIndex:button.tag];
    
}



- (void)setPageCount:(NSInteger)count {
    
    if (count <= 0) {
        return;
    }
    
    _pageCount = count;
    
    [self creatSubviewsAction];
    
}

- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    return;
}




















@end
