//
//  setCardDeck.m
//  Matchismo
//
//  Created by AravinthChandran on 19/12/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "setCardDeck.h"

@implementation setCardDeck

-(instancetype)initWithColor:(NSArray *)colors
                   andShapes:(NSArray *)shapes{
    self = [super init];
    if(self){
        for(NSString *color in colors){
            for(NSString *shape in shapes){
                for(NSString *shade in [setCard validShades]){
                    for(NSNumber *cardNumber in [setCard validCardNumbers]){
                        setCard *newCard = [[setCard alloc] init];
                        newCard.number = [cardNumber intValue];
                        newCard.shade = shade;
                        newCard.shape = shape;
                        newCard.color = color;
                        [self addCard:newCard];
                    }
                }
            }
        }
    }
    return self;
}


-(instancetype)initWithDefaults{
    NSArray *colors = @[@"green", @"purple", @"red"];
    NSArray *shapes = @[@"▲", @"●", @"■"];
    return [self initWithColor:colors andShapes:shapes] ;
}

@end
