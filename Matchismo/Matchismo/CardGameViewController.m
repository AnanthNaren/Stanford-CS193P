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

//Abstract Methods
-(Deck *) createDeck{
    return nil;
}

-(UIImage *)chosenCardBackgroundImage{
    return nil;
}

-(UIImage *)UnChosenCardBackgroundImage{
    return nil;
}

-(NSString *)cardContents:(Card *)card{
    return nil;
}

- (int)setGameMode{
    return MODE_NOT_YET_CHOSEN;
}

//Game will not be allowed to run unless you override setGameMode method.
- (void)configureGameSettings{
    int chosenGameMode = [self setGameMode];
    if(chosenGameMode){
        self.game.gameMode = chosenGameMode;
        self.isGameConfigured = YES;
    }
}

//ActionMethods of a card selection
- (IBAction)touchCardButton:(UIButton*)sender {
    [self configureGameSettings];
    if(self.isGameConfigured){
        int cardButtonIndex = [self.cardButtons indexOfObject:sender];
        [self.game chooseCardAtIndex:cardButtonIndex];
        [self updateUI];
    }
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

-(NSString *)titleForCard:(Card *)card{
    return card.isChosen ? [self cardContents:card] : @"";
}

-(UIImage *)backgroundImageForCard:(Card *)card{
    return card.isChosen ? [self chosenCardBackgroundImage] :
    [self UnChosenCardBackgroundImage];
}


//UpdateGameStatusLabel
-(void) updateGameStatusLabel{
    if([self.game.cardsInvolved count]){
        if(self.game.currentMatchState == MATCH_NOT_CHECKED_YET){
            [self generateMatchMessage:@"selected"];
        }else if(self.game.currentMatchState == MATCH_SUCCESS){
            [self generateMatchMessage:@"Matched 4 points"];
        }else if(self.game.currentMatchState == MATCH_FAILED){
            [self generateMatchMessage:@"Match Failed! penalty 2 points"];
        }
    }else{
        self.gameStatusLabel.text = @"";
    }
}

-(void) displayStatusMessage:(NSString *)message{
    self.gameStatusLabel.text = message;
    
}

-(void) generateMatchMessage:(NSString *)message{
    NSString *status = @"The card ";
    for(Card *card in self.game.cardsInvolved){
        status = [status stringByAppendingString:[NSString stringWithFormat:@" %@ ",[self cardContents:card]]];
    }
    status = [status stringByAppendingString:message];
    self.gameStatusLabel.text = status;
    [self.gameHistory addObject:status];
}

- (IBAction)dealButton:(UIButton *)sender {
    self.game = nil;
    [self updateCardButtonUI];
    [self.gameHistory removeAllObjects];
    self.isGameConfigured = NO;
    self.gameStatusLabel.text = @"Starting New Game";
}

@end
