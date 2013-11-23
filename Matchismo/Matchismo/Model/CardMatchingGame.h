//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by AravinthChandran on 23/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#include "Card.h"

@interface CardMatchingGame : NSObject


-(instancetype) initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
