//
//  PlayingCard.m
//  Matchismo
//
//  Created by AravinthChandran on 15/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// Super's Method
-(NSString *)contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

//@property Suit
@synthesize suit = _suit;
-(NSString *) suit{
    return _suit ? _suit : @"?" ;
}
-(void)setSuit:(NSString *)suit{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

//@property Rank
-(void)setRank:(NSUInteger)rank{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

//Public API
+(NSUInteger)maxRank {
    return [[PlayingCard rankStrings] count]- 1;
}
+(NSArray *)validSuits{
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}
-(int)match:(NSArray *)otherCards{
    int score = 0;
    if([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank){
            score  = 4;
        }else if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    }
    return score;
}

//Helper
+(NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

@end
