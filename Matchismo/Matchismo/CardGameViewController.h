//
//  CardGameViewController.h
//  Matchismo
//
//  Created by AravinthChandran on 22/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//
//  Abstract Class. Must implement the methods below

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController


//Methods To Override

/**
 *  Protected for subclasses
 *  @return Desired deck of card
 */
-(Deck *) createDeck;


/**
 *  Configure the CardMatchingGame Mode to choose
 *  how many cards to match. Default value is
 *  MODE_NOT_YET_CHOSEN.
 *  @return A valid GameMode constant
 */
-(int)setGameMode;


/**
 *  GameMode Constants
 */
typedef enum{
    MODE_NOT_YET_CHOSEN = 0,
    SET_2_CARD_MODE = 2,
    SET_3_CARD_MODE = 3,
} gameMode;

-(UIImage *)chosenCardBackgroundImage;

-(UIImage *)UnChosenCardBackgroundImage;

-(NSString *)cardContents:(Card *)card;


@end
