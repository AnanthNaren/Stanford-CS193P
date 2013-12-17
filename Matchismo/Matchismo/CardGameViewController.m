//
//  CardGameViewController.m
//  Matchismo
//
//  Created by AravinthChandran on 22/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//
#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameStatusLabel;
@property (nonatomic,strong) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISlider *gameHistorySlider;
@property (nonatomic, strong) NSMutableArray *gameHistory;
@property (nonatomic)  BOOL isGameConfigured;
@end

@implementation CardGameViewController

//Lazy Instantiations
-(NSMutableArray *)gameHistory{
    if(!_gameHistory)_gameHistory = [[NSMutableArray alloc]init];
    return _gameHistory;
}
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
    return nil;
}

//Configuring the GameMode before playing the game
- (void)configureGameMode{
    self.game.gameMode = 2;
    [self setHistorySlider];
    self.isGameConfigured = YES;
}

//ActionMethods of a card selection
- (IBAction)touchCardButton:(UIButton*)sender {
    [self configureGameMode];
    if(self.isGameConfigured){
        int cardButtonIndex = [self.cardButtons indexOfObject:sender];
        [self.game chooseCardAtIndex:cardButtonIndex];
        [self updateUI];
    }else{
        [self displayStatusMessage:@"Please select the game mode"];
        return;
    }
}

- (IBAction)historySlider:(UISlider *)sender {
    if(self.isGameConfigured){
        self.gameStatusLabel.textColor = [UIColor grayColor];
        int value = sender.value;
        if(value < [self.gameHistory count]){
            NSString *message = [self.gameHistory objectAtIndex:(int)sender.value];
            [self displayStatusMessage:message];
        }
        self.gameStatusLabel.textColor = [UIColor blackColor];
    }else{
        [self displayStatusMessage:@"Choose a card to start new game"];
        return;
    }
}

//setHistorySlider
static const int SLIDER_STARTING_VALUE = 0;
static const int SLIDER_RESET_VALUE = 0;
static const int SLIDER_EXPAND_VALUE = 10;
-(void) setHistorySlider{
    self.gameHistorySlider.minimumValue = SLIDER_STARTING_VALUE;
    self.gameHistorySlider.maximumValue = [self.cardButtons count]/self.game.gameMode;
}




-(void) updateUI{
    [self updateCardButtonUI];
    [self updateGameStatusLabel];
}

//updateCardButton
-(void) updateCardButtonUI{
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

//UpdateGameStatusLabel
-(void) updateGameStatusLabel{
    if([self.game.cardsInvolved count]){
        if(self.game.currentMatchState == matchNotCheckedyet){
            [self generateMatchMessage:@"selected"];
        }else if(self.game.currentMatchState == matchSuccess){
            [self generateMatchMessage:@"Matched 4 points"];
        }else if(self.game.currentMatchState == matchFailed){
            [self generateMatchMessage:@"Match Failed! penalty 2 points"];
        }
        [self updateHistorySlider];
    }else{
        self.gameStatusLabel.text = @"";
    }
}

-(void)updateHistorySlider{
    float currentValue = [self.gameHistorySlider value];
    if(currentValue == self.gameHistorySlider.maximumValue){
        self.gameHistorySlider.maximumValue = self.gameHistorySlider.maximumValue + SLIDER_EXPAND_VALUE;
    }
    [self.gameHistorySlider setValue:(++currentValue) animated:YES];
}

-(void) displayStatusMessage:(NSString *)message{
    self.gameStatusLabel.text = message;
    
}
-(void) generateMatchMessage:(NSString *)message{
    NSString *status = @"The card ";
    for(Card *card in self.game.cardsInvolved){
        status = [status stringByAppendingString:[NSString stringWithFormat:@" %@ ",card.contents]];
    }
    status = [status stringByAppendingString:message];
    self.gameStatusLabel.text = status;
    [self.gameHistory addObject:status];
}

-(NSString *)titleForCard:(Card *)card{
    return card.isChosen ? card.contents : @"";
}
-(UIImage *)backgroundImageForCard:(Card *)card{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
- (IBAction)dealButton:(UIButton *)sender {
    self.game = nil;
    [self updateCardButtonUI];
    [self resetHistorySlider];
    [self.gameHistory removeAllObjects];
    self.isGameConfigured = NO;
    self.gameStatusLabel.text = @"Welcome To Card Matching Game";
}
-(void) resetHistorySlider{
    self.gameHistorySlider.value = SLIDER_RESET_VALUE;
    self.gameHistorySlider.minimumValue = SLIDER_RESET_VALUE;
    self.gameHistorySlider.maximumValue = SLIDER_RESET_VALUE;
}



@end
