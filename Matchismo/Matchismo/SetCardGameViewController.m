//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by AravinthChandran on 17/12/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "setCardDeck.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

-(Deck *)createDeck{
    return [[setCardDeck alloc]init];
}


-(int)setGameMode{
    return SET_3_CARD_MODE;
}

@end
