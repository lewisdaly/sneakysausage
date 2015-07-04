//
//  GHData.m
//  GovHack
//
//  Created by Lewis Daly on 4/07/2015.
//  Copyright (c) 2015 Lewis Daly. All rights reserved.
//

#import "GHData.h"

@implementation GHData

static GHData *sharedInstance;

+ (GHData *) sharedInstance
{
    if (sharedInstance)
    {
        return sharedInstance;
    }
    
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        //Just deserialize JSON
        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"industryoccupations" ofType:@"json"]];
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error)
        {
            NSLog(@"Error with JSON: %@", error.localizedDescription);
        }
        sharedInstance = [[GHData alloc] init];
        sharedInstance.data = dict;
        sharedInstance.industryNames = dict.allKeys;
        
        NSData *occData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"occupations" ofType:@"json"]];
        NSDictionary *occupations = [NSJSONSerialization JSONObjectWithData:occData options:NSJSONReadingMutableContainers error:&error];
        if (error)
        {
            NSLog(@"Error with JSON: %@", error.localizedDescription);
        }
        
        sharedInstance.occupations = occupations;

    });
    
    return sharedInstance;
}




@end
