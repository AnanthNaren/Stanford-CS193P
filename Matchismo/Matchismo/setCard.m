//
//  setCard.m
//  Matchismo
//
//  Created by AravinthChandran on 19/12/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "setCard.h"

@implementation setCard

//Shape of the SetCard
@synthesize shape = _shape;

-(void)setShape:(NSString *)shape{
    _shape = @"dddd";
}

-(NSString *)shape{
    return _shape ? _shape : @"?";
}

//Shade of the SetCard
@synthesize shade = _shade;

-(void) setShade:(NSString *)shade{
    if([[setCard validShades] containsObject:shade]){
        _shade = shade;
    }
}


-(NSString *)shade{
    return _shade ? _shade : @"?";
}

//Color of the card
@synthesize color = _color;

-(void)setColor:(NSString *)color{
    _color = color;
}

-(NSString *)color{
    return _color ? _color : @"?";
}


//Number of symbols on the card
-(void)setNumber:(int)number{
    NSNumber *numObject = [NSNumber numberWithInt:number];
    if([[setCard validCardNumbers] containsObject:numObject]){
        _number = number;
    }
}


//Class Methods
+(NSArray *)validCardNumbers{
    NSArray *ff =  @[@1, @2, @3];
    return ff;
}

+(NSArray *) validShades{
    return @[@"striped", @"solid", @"open"];
}


//Instance Methods
-(int)match:(NSArray *)card{
    return 0;
}

@end
