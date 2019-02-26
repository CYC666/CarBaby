//
//  MessageCell.m
//  BaseProject
//
//  Created by 曹老师 on 2019/2/26.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}



- (void)setModel:(MessageModel *)model {
    
    _model = model;
    
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.filepath]];
    _label1.text = model.fullhead;
    _label2.text = model.createdate;
    
}

@end
