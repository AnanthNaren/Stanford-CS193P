//
//  Card.h
//  Matchismo
//
//  Created by AravinthChandran on 15/11/13.
//  Copyright (c) 2013 AravinthChandran. All rights reserved.
//

@import Foundation;

@interface Card : NSObject

@property (strong,nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic,getter = isMatched) BOOL matched;

- (int)match:(NSArray *) card;



@end
