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


/**
 *  protected for subclasses
 *
 *  @return Desired deck of card
 */
-(Deck *) createDeck;   //abstract

@end
