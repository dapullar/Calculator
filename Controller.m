//
//  Controller.m
//  Calculator
//
//  Created by David Pullar on 1/23/2014.
//  Copyright (c) 2014 David Pullar. All rights reserved.
//

#import "Controller.h"
#import "CalculatorBrain.h"

@implementation Controller

static CalculatorBrain *brain;
NSString *curr_num = @"";
BOOL equalsPressed = false;

- (IBAction)operationHandler:(UIButton *)sender {
    NSArray *operators = [NSArray arrayWithObjects: @"+", @"-", @"÷", @"x", @"+/-", @"cos", @"x²", nil]; // include all operators
    NSArray *unaryOperators = [NSArray arrayWithObjects: @"sqrt", @"sin", @"tan", @"cos", @"sin", @"x²", nil]; // only unary
    NSString *button_pressed = [sender currentTitle];
    
    if (!brain)
        brain = [[CalculatorBrain alloc] init];
    
    for (NSString *op in operators) {
        if ([button_pressed isEqual:op]) {
            if ([[brain operator] isEqual:@""]) { //If operator wasn't previously assigned
                if (equalsPressed) {
                    //Check if unary here
                    for (NSString *op in unaryOperators) {
                        if([button_pressed isEqual:op]) {
                            [self compute:op brain:brain];
                            //equalsPressed = false;
                            return;
                        }
                    }
                    equalsPressed = false;
                    [brain setOperator:op];
                    return;
                } else {
                    //Check if unary here
                    for (NSString *op in unaryOperators) {
                        if([button_pressed isEqual:op]) {
                            [brain setOperand:[curr_num doubleValue]];
                            [brain setOperator:op];
                            [brain setOperand:[brain performOperation:[brain operator]]];
                            curr_num = [NSString stringWithFormat:@"%g", [brain operand]];
                            display.text = curr_num;
                            equalsPressed = true;
                            //[self compute:op brain:brain];
                            return;
                        }
                    }
                    //else do this
                    [brain setOperator:op];
                    [brain setOperand:[curr_num doubleValue]];
                    curr_num = @"";
                    return;
                }
            } else { //If operator was previously assigned
                for (NSString *op in unaryOperators) {
                    if([button_pressed isEqual:op]) {
                        [brain setOperand:[curr_num doubleValue]];
                        [brain setOperand:[brain performOperation:[brain operator]]];
                        [self compute:op brain:brain];
                        return;
                    }
                }
                [brain setOperand:[curr_num doubleValue]];
                [brain setOperand:[brain performOperation:[brain operator]]];
                curr_num = [NSString stringWithFormat:@"%g", [brain operand]];
                display.text = curr_num;
                [brain setOperator:op];
                curr_num = @"";
                return;
            }
        }
    }
    
    if ([button_pressed isEqual:@"="]) {
        equalsPressed = true;
        [brain setOperand:[curr_num doubleValue]];
        [brain setOperand:[brain performOperation:[brain operator]]];
        curr_num = [NSString stringWithFormat:@"%g", [brain operand]];
        display.text = curr_num;
        [brain setOperator:@""];
        curr_num = @"";
        return;
    } else {
        if (equalsPressed) {
            curr_num = @"";
            equalsPressed = false;
        }
        curr_num = [curr_num stringByAppendingString:button_pressed];
        display.text = curr_num;
    }
    
    return;
}

- (void)compute:(NSString *)operator brain:(CalculatorBrain *)brain {
    [brain setOperator:operator];
    [brain setOperand:[brain performOperation:[brain operator]]];
    curr_num = [NSString stringWithFormat:@"%g", [brain operand]];
    display.text = curr_num;
    curr_num = @"";
}


- (IBAction)switchColour:(UISwitch *)sender {
    [radDeg setOnTintColor:[UIColor colorWithRed:0 green:175.0/255.0 blue:176.0/255.0 alpha:1.0]];
}

@end
