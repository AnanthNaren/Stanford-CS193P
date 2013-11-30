//
//  PlayingCard.m
//  Matchismo
//
//  Created by AravinthChandran on 15/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)Cards{
    int score = 0;
    if([Cards count] == 2){
       score = [self match:Cards[0] With:Cards[1]];
    }else if([Cards count] == 3){
        score = [self match:Cards[0] With:Cards[1]] + [self match:Cards[1] With:Cards[2]] + [self match:Cards[0] With:Cards[2]];
        if (score == 2) score = 1;
        if (score == 3) score = 2;
    }
    return score;
}

-(int)match:(PlayingCard *)cardA With:(PlayingCard *)cardB{
    int score = 0 ;
    
    if(cardA.rank == cardB.rank){
        score = 1;
    }else if([cardA.suit isEqualToString:cardB.suit]){
        score = 1;
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
