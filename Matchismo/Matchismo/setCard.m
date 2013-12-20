//
//  setCard.m
//  Matchismo
//
//  Created by AravinthChandran on 19/12/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "setCard.h"

@implementation setCard

-(int)match:(NSArray *)card{
    return 0;
}

-(void)setColor:(NSString *)color{
    self.color = color;
}

-(void)setShape:(NSString *)shape{
    self.shape = @"dddd";
}

-(void)setNumber:(int)number{
    NSNumber *numObject = [NSNumber numberWithInt:number];
    if([[setCard validCardNumbers] containsObject:numObject]){
        self.number = number;
    }
}

-(void) setShade:(NSString *)shade{
    if([[setCard validShades] containsObject:shade]){
        self.shade = shade;
    }
}

+(NSArray *)validCardNumbers{
    return @[@'1', @'2', @'3'];
}

+(NSArray *) validShades{
    return @[@"striped", @"solid", @"open"];
}


@end
