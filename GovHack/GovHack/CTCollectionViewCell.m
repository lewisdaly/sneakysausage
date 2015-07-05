//
//  CTCollectionViewCell.m
//  CareerTraining
//
//  Created by Lewis Daly on 12/07/2014.
//  Copyright (c) 2014 Fruit Toast. All rights reserved.
//

#import "CTCollectionViewCell.h"
#define FONT_NAME @"AvenirNext-DemiBold"
#define FONT_SIZE_MED 16


@implementation CTCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frameRect
{
    self = [super initWithFrame:frameRect];
    if (self)
    {
        int labelHeight = 60;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frameRect.size.height - labelHeight, frameRect.size.width, labelHeight)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:FONT_NAME size:FONT_SIZE_MED];
        self.titleLabel.backgroundColor = [UIColor clearColor];
//        self.titleLabel.textColor = UIColorFromRGB(0x646464);
        self.titleLabel.numberOfLines = 2;
        
        int indent = 20;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frameRect.size.width, frameRect.size.height)];
        [self.imageView setAlpha:0.25];
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];

    }
    return self;
}

- (void) prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = @"";
    self.imageView.image = nil;
}

@end
