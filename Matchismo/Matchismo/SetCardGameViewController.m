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
    return [[setCardDeck alloc]initWithDefaults];
}

-(int)setGameMode{
    return SET_3_CARD_MODE;
}

-(UIImage *)chosenCardBackgroundImage{
    return [UIImage imageNamed:@"setcardchosen"];
}

-(UIImage *)UnChosenCardBackgroundImage{
    return [UIImage imageNamed:@"cardfront"];
}


//Interospect the set_Card if it is one.
-(id)cardContents:(Card *)card{
    NSString *contents = @"";
    NSMutableAttributedString *attributedContents;
    setCard *set_Card = (setCard *)card;
    for(int i=0; i<set_Card.number; i++){
        NSString *shape = set_Card.shape;
        contents = [contents stringByAppendingString:shape];
    }
    return contents;
}

@end
