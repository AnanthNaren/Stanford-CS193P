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
@property (nonatomic, strong) NSMutableArray* cardsToBeMatched; //
@end

@implementation CardMatchingGame

-(NSMutableArray *)cardsToBeMatched{
    if(!_cardsToBeMatched) _cardsToBeMatched = [[NSMutableArray alloc]init];
    return _cardsToBeMatched;
}


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

static const int MATCH_BONUS = 4;
static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;

//Card Matching Game Logic
-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
            [self.cardsToBeMatched removeObject:card];
            self.score -= COST_TO_CHOOSE;
        }else{
            card.chosen = YES;
            [self.cardsToBeMatched addObject:card];
            if([self.cardsToBeMatched count] == self.gameMode){
                int matchScore = [card match:self.cardsToBeMatched];
                if(matchScore){
                    [self markCardsAsMatched];
                    [self.cardsToBeMatched removeAllObjects];
                    self.score += matchScore * MATCH_BONUS;
                }else{
                    // Will change the logic after using animation
                    [self.cardsToBeMatched removeLastObject];
                    [self markCardsAsNotChosen];
                    [self.cardsToBeMatched removeAllObjects];
                    [self.cardsToBeMatched addObject:card];
                    self.score -= MISMATCH_PENALTY;
                }
            }
        }
    }
}




-(void) markCardsAsMatched{
    for(Card* card in self.cardsToBeMatched){
        card.matched = YES;
    }
}

-(void) markCardsAsNotChosen{
    for(Card* card in self.cardsToBeMatched){
        card.chosen = NO;
    }
    
}


@end
