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

//Designated Initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
@property(nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger gameMode;

struct cardGameStatus{
    int matchStatus;
    __unsafe_unretained NSMutableArray* chosenCards;
};


@end
