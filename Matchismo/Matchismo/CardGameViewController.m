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
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (nonatomic,strong) IBOutletCollection(UIButton) NSArray *cardButtons;
@property(nonatomic, strong)UISegmentedControl *gameModeControl;
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
    [self configureGameMode];
    int cardButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardButtonIndex];
    [self updateUI];
}

-(void)configureGameMode{
    int gameMode = -1;
    while (true) {
        if(gameMode != UISegmentedControlNoSegment){
            if(gameMode == 0) self.game.gameMode = 2;
            if(gameMode == 1) self.game.gameMode = 3;
            break;
        }
        self.scoreLabel.text = [NSString stringWithFormat:@"Please select the game mode"];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"You have decided to play with %d cards",self.game.gameMode];
    [self gameModeSelectorState:NO];
}

-(void) gameModeSelectorState:(BOOL)state{
    for(int i=0; i<[self.gameModeControl numberOfSegments]; i++){
        [self.gameModeControl setEnabled:state forSegmentAtIndex:i];
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
        self.scoreLabel.text = [NSString stringWithFormat:@"Score  %d",self.game.score];      
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
    [self gameModeSelectorState:YES];
}

- (IBAction)gameModeSelector:(UISegmentedControl *)sender {
    self.gameModeControl = sender;
}

@end
