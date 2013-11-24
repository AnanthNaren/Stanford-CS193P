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




-(Card *)cardAtIndex:(NSUInteger)index{
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


static const int MISMATCH_PENALTY = 2;
static const int MISMATCH_BONUS = 2;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched){
        
        //Toggle the card state.
        if(card.isChosen){
            card.chosen = NO;
        }else{
            //Match against other chosen cards
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.score += matchScore * MISMATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    }else{
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break;  //For choosing only 2 cards
                }
                
            }
            self.score += COST_TO_CHOOSE;
        card.chosen = YES;
            
        }
    }
}











@end
