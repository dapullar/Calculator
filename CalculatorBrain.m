//
//  CalculatorBrain.m
//  Calculator
//
//  Created by David Pullar on 1/20/2014.
//  Copyright (c) 2014 David Pullar. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain

- (id)init {
    self = [super init];
    if (self) {
        lhs = 0;
        rhs = 0;
        op = @"";
    }
    return self;
}

- (NSString *)operator {
    return op;
}

- (void)setOperator:(NSString *)currOp {
    op = currOp;
}

- (double)operand {
    return rhs;
}

- (void)setOperand:(double)operand {
    lhs = rhs;
    rhs = operand;
}

- (void)memoryStorage:(double)operand {
    memory = operand;
}

- (double)memoryRecall {
    return memory;
}

- (void)memoryAdd:(double)operand {
    memory += operand;
}

- (void)memorySubtract:(double)operand {
    memory -= operand;
}

- (int)factorial:(int)n {
    if (n == 1)
        return n;
    else
        return n * [self factorial:n - 1];
}


- (double)performOperation:(NSString *)operation {
    if ([operation isEqual:@"+"]) {
        lhs += rhs;
    } else if ([operation isEqual:@"-"]) {
        lhs -= rhs;
    } else if ([operation isEqual:@"x"]) {
        lhs *= rhs;
    } else if ([operation isEqual:@"÷"]) {
        if (rhs)
            lhs /= rhs;
    } else if ([operation isEqual:@"sin"]) {
        lhs = sin(rhs);
    } else if ([operation isEqual:@"cos"]) {
        lhs = cos(rhs);
    } else if ([operation isEqual:@"tan"]) {
        lhs = tan(rhs);
    } else if ([operation isEqual:@"!"]) {
        lhs = [self factorial:rhs];
    } else if ([operation isEqual:@"sqrt"]) {
        lhs = sqrt(rhs);
    } else if ([operation isEqual:@"x²"]) {
        lhs = pow(rhs, 2);
    } else if ([operation isEqual:@"log2"]) {
        lhs = log2(rhs);
    } else if ([operation isEqual:@"ln"]) {
        lhs = log(rhs);
    } else if ([operation isEqual:@"x^y"]) {
        lhs = pow(lhs, rhs);
    } else if ([operation isEqual:@"%"]) {
        lhs = fmod(lhs, rhs);
    } else if ([operation isEqual:@"1/x"]) {
        if (rhs)
            lhs = 1 / rhs;
    } else if ([operation isEqual:@"+/-"]) {
        lhs = -1 * rhs;
    }
    
    return lhs;
}


@end
