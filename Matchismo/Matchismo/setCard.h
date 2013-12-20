//
//  setCard.h
//  Matchismo
//
//  Created by AravinthChandran on 19/12/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "Card.h"

@interface setCard : Card

//Properties of a SET card
@property (nonatomic)int number;
@property (nonatomic, strong)NSString *shape;
@property (nonatomic, strong)NSString *color;
@property (nonatomic, strong)NSString *shade;

-(int)match:(NSArray *)card;
+(NSArray *)validCardNumbers;
+(NSArray *) validShades;


@end
