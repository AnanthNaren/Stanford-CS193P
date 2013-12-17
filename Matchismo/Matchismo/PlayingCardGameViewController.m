//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by AravinthChandran on 14/12/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck{
    return [[PlayingCardDeck alloc]init];
}


-(int)setGameMode{
    return SET_3_CARD_MODE;
}



@end

