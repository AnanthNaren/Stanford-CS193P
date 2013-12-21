//
//  MatchismoTests.m
//  MatchismoTests
//
//  Created by AravinthChandran on 22/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "setCard.h"
#import "setCardDeck.h"
#import "PlayingCardDeck.h"
#import "playingCardGameViewController.h"

@interface MatchismoTests : XCTestCase

@end

@implementation MatchismoTests


- (void)testSetCard
{
    setCard *newCard = [[setCard alloc]init];
    int number = 1;
    NSString *shade = @"solid";
    newCard.shade = shade;
    newCard.number = number;
    newCard.shape = @"triangle";
    newCard.color = @"red";
    XCTAssertEqual( number,newCard.number, @"Number not assigned");
    
    number = 5;
    newCard.number = number;
    XCTAssertNotEqual( number,newCard.number, @"Number is not protective against wrong inputs");
    
    shade = @"glued";
    newCard.shade = shade;
    XCTAssertNotEqual(shade, newCard.shade, @"Number is not protective against wrong inputs");
    PlayingCardGameViewController *cgvc = [[PlayingCardGameViewController alloc] init];
    [cgvc setGameMode];
}

@end
