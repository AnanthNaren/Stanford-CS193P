    //
//  CardMatchingGame.m
//  Matchismo
//
//  Created by AravinthChandran on 23/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "CardMatchingGame.h"

//Class Extension
@interface  CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray* cards;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    
    self = [super init]; //superclass designated initializer
    
    if(self){
        
        for(int i=0; i<count; i++){
            Card *randomCard = [deck drawRandomCard];
            //Protecting against NIL
            if(randomCard){
                [self.cards addObject:randomCard];
            }else{
                self = nil;
                break;
            }
        }
    }
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

//Card Matching Game Logic
-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }else{
            //Match against the other cards
            for(Card* otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }else{
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;  // For choosing only 2 cards
                }
            }
            card.chosen = YES;
            self.score -= COST_TO_CHOOSE;
        }
    }
}

@end
