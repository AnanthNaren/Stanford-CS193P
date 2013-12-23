//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by AravinthChandran on 14/12/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@implementation PlayingCardGameViewController

-(Deck *)createDeck{
    return [[PlayingCardDeck alloc]init];
}

-(int)setGameMode{
    return SET_2_CARD_MODE;
}

-(UIImage *)chosenCardBackgroundImage{
    return [UIImage imageNamed:@"cardfront"];
}

-(UIImage *)UnChosenCardBackgroundImage{
    return [UIImage imageNamed:@"cardback"];
}

-(NSString *)cardContents:(Card *)card{
    return card.contents;
}

@end