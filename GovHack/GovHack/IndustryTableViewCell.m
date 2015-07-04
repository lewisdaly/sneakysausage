//
//  IndustryTableViewCell.m
//  GovHack
//
//  Created by Lewis Daly on 4/07/2015.
//  Copyright (c) 2015 Lewis Daly. All rights reserved.
//

#import "IndustryTableViewCell.h"
#import "ViewUtils.h"

@implementation IndustryTableViewCell


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        CGRect frame = self.frame;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, frame.size.width - 50, frame.size.height)];
        self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right, 0, frame.size.width - self.titleLabel.left, frame.size.height)];
        self.colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.valueLabel];
        [self addSubview:self.colorView];

    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) prepareForReuse
{
    
}

@end
