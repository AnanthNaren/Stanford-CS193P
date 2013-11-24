//
//  PlayingCard.h
//  Matchismo
//
//  Created by AravinthChandran on 15/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString* suit;
@property (nonatomic) NSUInteger rank;

+(NSUInteger)maxRank;
+(NSArray *)validSuits;
-(int)match:(NSArray *)otherCards;

@end