//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by AravinthChandran on 23/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Card Matching Game States
typedef enum {
    matchNotCheckedyet,
    matchSuccess,
    matchFailed,
} matchState;

//Designated Initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

//Instance Methods
-(Card *)cardAtIndex:(NSUInteger)index;
-(void)chooseCardAtIndex:(NSUInteger)index;

//Property
@property(nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger gameMode;
@property (nonatomic) matchState currentMatchState;
@property (nonatomic, strong, readonly) NSMutableArray* cardsInvolved;

@end
