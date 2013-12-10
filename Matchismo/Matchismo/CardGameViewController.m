//
//  CardGameViewController.m
//  Matchismo
//
//  Created by AravinthChandran on 22/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//
#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic,strong) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeController;
@end

@implementation CardGameViewController

-(CardMatchingGame *)game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}
-(Deck *)deck{
    if(!_deck) _deck = [self createDeck];
    return _deck;
}
-(Deck *) createDeck{
    return [[PlayingCardDeck alloc] init];
}



- (IBAction)touchCardButton:(UIButton*)sender {
    if(self.game.gameMode){
        int cardButtonIndex = [self.cardButtons indexOfObject:sender];
        [self.game chooseCardAtIndex:cardButtonIndex];
        [self updateUI];
        [self gameModeControllerEnabled:NO];
    }else{
        self.scoreLabel.text = [NSString stringWithFormat:@"Please select the game mode"];
        return;
    }
}


-(void) updateUI{
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Matched J♥ J♠ for 4 points Score  %d",self.game.score];
    }
}

-(void) gameModeControllerEnabled:(BOOL)state{
    for(int i=0; i< [self.gameModeController numberOfSegments]; i++ ){
        [self.gameModeController setEnabled:state forSegmentAtIndex:i];
    }
}


-(NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}


-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


- (IBAction)dealButton:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
    [self gameModeControllerEnabled:YES];
}


- (IBAction)chooseMode:(UISegmentedControl *)sender {
    int index = [sender selectedSegmentIndex];
    if(index == 0) self.game.gameMode = 2;
    if(index == 1) self.game.gameMode = 3;
 }

@end
