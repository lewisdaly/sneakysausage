//
//  GHData.h
//  GovHack
//
//  Created by Lewis Daly on 4/07/2015.
//  Copyright (c) 2015 Lewis Daly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GHData : NSObject

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, strong) NSArray *industryNames;
@property (nonatomic, strong) NSDictionary *occupations;

+ (GHData *) sharedInstance;

@end
