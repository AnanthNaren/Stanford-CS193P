//
//  setCardDeck.h
//  Matchismo
//
//  Created by AravinthChandran on 19/12/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "Deck.h"
#import "setCard.h"

@interface setCardDeck : Deck

-(instancetype)initWithColor:(NSArray *)colors
                   andShapes:(NSArray *)shapes;

@end
