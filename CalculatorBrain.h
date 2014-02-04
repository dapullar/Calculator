//
//  CalculatorBrain.h
//  Calculator
//
//  Created by David Pullar on 1/20/2014.
//  Copyright (c) 2014 David Pullar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject {
    double lhs;
    double rhs;
    double memory;
    NSString *op;
}

- (NSString *)operator;
- (void)setOperator:(NSString *)currOp;
- (double)operand;
- (void)setOperand:(double)operand;
- (void)memoryStorage:(double)operand;
- (void)memoryClear;
- (double)memoryRecall;
- (void)memoryAdd:(double)operand;
- (void)memorySubtract:(double)operand;
- (double)performOperation:(NSString *)operation;
- (int)factorial:(int) n;

@end
