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


-(void)configureCardButtonUI:(UIButton *)cardButton withCard:(Card *)card{
    [cardButton setTitle:[self getStringContentOfCard:card]
                forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
}

-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback" ];
}

-(NSString *)getStringContentOfCard:(Card *)card{
    return card.isChosen ? [self cardContents:card] : @"";
}

-(NSString *)cardContents:(Card *)card{
    return card.contents;
}

@end