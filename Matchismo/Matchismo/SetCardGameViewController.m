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

//Interospect the set_Card if it is one.
-(id)cardContents:(Card *)card{
    NSString *contents = @"";
    NSMutableAttributedString *attributedContents;
    setCard *set_Card = (setCard *)card;
    for(int i=0; i<set_Card.number; i++){
        NSString *shape = set_Card.shape;
        contents = [contents stringByAppendingString:shape];
    }
    attributedContents = [[NSMutableAttributedString alloc]
                          initWithString:contents
                          attributes: @{NSForegroundColorAttributeName:[self colorAttributeOfCard:card],
                                        NSStrokeWidthAttributeName: @-3, NSStrokeColorAttributeName:[self colorAttributeOfCard:card]}];
    [self addShadeAttributeOfCard:set_Card withOldAttributes:attributedContents];
    return attributedContents;
}

-(UIColor *)colorAttributeOfCard:(Card *)card{
    setCard *set_Card = (setCard *)card;
    if([set_Card.color isEqualToString:@"green"]){
        return [UIColor greenColor];
    }else if([set_Card.color isEqualToString:@"purple"]){
        return [UIColor purpleColor];
    }else if([set_Card.color isEqualToString:@"red"]){
        return [UIColor redColor];
    }
    return nil;
}

-(void)addShadeAttributeOfCard:(setCard *)card withOldAttributes:(NSMutableAttributedString *) oldAttributes{
    NSRange range = NSMakeRange(0,[oldAttributes length]);
    if([card.shade isEqualToString:@"open"]){
        [oldAttributes addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.0 alpha:0.0]} range:range];
    }else if([card.shade isEqualToString:@"striped"]){
        if([card.color isEqualToString:@"green"]){
            [oldAttributes addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithPatternImage:[UIImage imageNamed:@"greenStripe"]]} range:range];
        }else if([card.color isEqualToString:@"purple"]){
            [oldAttributes addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithPatternImage:[UIImage imageNamed:@"purpleStripe"]]} range:range];
        }else if([card.color isEqualToString:@"red"]){
            [oldAttributes addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithPatternImage:[UIImage imageNamed:@"redStripe"]]} range:range];
        }
        
    }
}

-(void)configureCardButtonUI:(UIButton *)cardButton withCard:(Card *)card{
    [cardButton setAttributedTitle: [self getAttributedContentOfCard:card]
                forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];
}

-(id)getAttributedContentOfCard:(Card *)card{
    return [self cardContents:card];
}

-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed: card.isChosen ? @"setcardchosen" : @"cardfront" ];
}



@end
