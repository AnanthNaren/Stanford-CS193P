//
//  PlayingCard.m
//  Matchismo
//
//  Created by AravinthChandran on 15/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards{
    int score = 0;
    if([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject];
        if(otherCard.rank == self.rank){
            score = 4;
        }else if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    }
    return score;
}


-(NSString *) contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;
-(NSString *) suit{
    return _suit ? _suit : @"?" ;
}
-(void)setSuit:(NSString *)suit{
    
    if([ [PlayingCard validSuits] containsObject:suit ]){
        _suit = suit;
    }
}

-(void)setRank:(NSUInteger)rank{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}


+(NSArray *)validSuits{
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}

+(NSArray *)rankStrings{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank {
    return [[PlayingCard rankStrings] count]- 1;
}

@end
