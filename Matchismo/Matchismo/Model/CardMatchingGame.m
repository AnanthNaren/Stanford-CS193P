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
@property (nonatomic, strong) NSMutableArray* cardsToBeMatched;
@property (nonatomic, strong, readwrite) NSMutableArray* contentsOfcardsInvolved;

@end

@implementation CardMatchingGame

-(NSMutableArray *)cardsToBeMatched{
    if(!_cardsToBeMatched) _cardsToBeMatched = [[NSMutableArray alloc]init];
    return _cardsToBeMatched;
}

/**
 *  Stores the current state of the card matching game.
 *  It has a NSNumber object at the 0th index, which represents the
 *  current matching state, NotCheckedYet -0 , MatchSuccess -1, MatchFailed -2
 *  which is then followed by array of cards involved on that match.
 *  @return gameState Array
 */
-(NSMutableArray *)contentsOfcardsInvolved{
    if(!_contentsOfcardsInvolved)_contentsOfcardsInvolved = [[NSMutableArray alloc] init];
    return _contentsOfcardsInvolved;
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
            [self.contentsOfcardsInvolved removeAllObjects];
        }else{
            card.chosen = YES;
            [self.cardsToBeMatched addObject:card];
            [self loadCurrentGameStateWith:self.cardsToBeMatched andMatchStatus:matchNotCheckedyet];
            if([self.cardsToBeMatched count] == self.gameMode){
                int matchScore = [card match:self.cardsToBeMatched];
                [self.contentsOfcardsInvolved removeAllObjects];
                if(matchScore){
                    [self loadCurrentGameStateWith:self.cardsToBeMatched andMatchStatus:matchSuccess];
                    [self markCardsAsMatched];
                    [self.cardsToBeMatched removeAllObjects];
                    self.score += matchScore * MATCH_BONUS;
                }else{
                    // Will change the logic after using animation
                    [self loadCurrentGameStateWith:self.cardsToBeMatched andMatchStatus:matchFailed];
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


-(void)loadCurrentGameStateWith:(NSMutableArray *)cards andMatchStatus:(int)state{
    self.currentMatchState = state;
    if(cards){
        [self copyCardContents];
    }
    
}

-(void)copyCardContents{
    for (Card* card in self.cardsToBeMatched) {
        [self.contentsOfcardsInvolved addObject:card.contents];
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
