//
//  CardGameViewController.m
//  Matchismo
//
//  Created by AravinthChandran on 22/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *flipsLabel;
@property (nonatomic) int flipsCount;
@property (nonatomic, strong) Deck *deck;
@end 

@implementation CardGameViewController


-(void)setFlipsCount:(int)flipsCount{
    _flipsCount = flipsCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips : %d", _flipsCount];
}

-(Deck *)deck{
    if(!_deck) _deck = [[PlayingCardDeck alloc]init];
    return _deck;
}

- (IBAction)touchCardButton:(UIButton*)sender {
    
    if([sender.currentTitle length ]){
            [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                              forState:UIControlStateNormal];
            [sender setTitle:@"" forState:UIControlStateNormal];
            
        }else{
            Card *card = [self.deck drawRandomCard];
        if(card){
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:[card contents]
                    forState:UIControlStateNormal];
            self.flipsCount++;
        }else{
            self.flipsLabel.text = [NSString stringWithFormat:@"There are no card to flip !!!"];

        }
    }
}

@end
