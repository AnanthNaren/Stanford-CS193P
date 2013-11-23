    //
//  CardMatchingGame.m
//  Matchismo
//
//  Created by AravinthChandran on 23/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

#import "CardMatchingGame.h"

//Class Extension
@interface  CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray* cards;
@end


@implementation CardMatchingGame

//Lazy Instantiation of our dataStructure
-(NSMutableArray *)cards
{
    if(_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self  = [super init]; //Super's Designated Initializer (of NSObject)
    
    if(self){
        
        for(int i=0; i<count; i++){
            Card *card = [deck drawRandomCard];
            [self.cards addObject:card];
        }
        
    }
    
    return self;
}

@end
