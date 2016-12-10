//
//  AUUFuncTableViewCell.m
//  WebJSWithOC
//
//  Created by 胡金友 on 2016/12/9.
//  Copyright © 2016年 胡金友. All rights reserved.
//

#import "AUUFuncTableViewCell.h"

@interface AUUFuncTableViewCell()

@property (retain, nonatomic) UILabel *label;

@property (retain, nonatomic) UILabel *slabel;

@end

@implementation AUUFuncTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.label = [[UILabel alloc] init];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.label];
        
        self.slabel = [[UILabel alloc] init];
        self.slabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.slabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.slabel];
        
        for (NSString *vfl in @[
                                @"V:|-10-[_label]-5-[_slabel]-10-|",
                                @"H:|-15-[_label]-40-|",
                                @"H:|-15-[_slabel]-40-|"
                                ]) {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl
                                                                         options:NSLayoutFormatDirectionMask
                                                                         metrics:nil
                                                                           views:NSDictionaryOfVariableBindings(_label, _slabel)]];
        }
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (title)
    {
        self.label.text = title;
    }
}

- (void)setSubtitle:(NSString *)subtitle
{
    if (subtitle)
    {
        self.slabel.text = subtitle;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
