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
NSString *curr_input = @"";
BOOL equalsPressed = false;

- (IBAction)operationHandler:(UIButton *)sender {
    NSArray *operators = [NSArray arrayWithObjects: @"+", @"-", @"÷", @"x", @"+/-", @"sin", @"cos", @"tan", @"x²", @"√x", @"log₂", @"xʸ", @"1/x", @"+/-", @"n!", @"%", @"ln", nil]; // include all operators
    NSArray *unaryOperators = [NSArray arrayWithObjects: @"sin", @"tan", @"cos", @"x²", @"√x", @"log₂", @"1/x", @"+/-", @"n!", @"%", @"ln", nil]; // only unary
    NSArray *specialChars = [NSArray arrayWithObjects:@"del", @"C", @"CE", @"ms", @"mr", @"m+", @"m-", @"mc", @"π", @".", nil]; //Special operators
    NSString *button_pressed = [sender currentTitle];
    
    curr_input = [[curr_input stringByAppendingString:button_pressed] stringByAppendingString:@" "];
    currInput.text = curr_input;
    
    if (!brain)
        brain = [[CalculatorBrain alloc] init];
    
    for(NSString *character in specialChars) {
        if ([button_pressed isEqual: character]) {
            if([character isEqual:@"π"]) {
                button_pressed = [NSString stringWithFormat:@"%2.2f", M_PI];
                break;
            } else if([character isEqual:@"ms"]) {
                [brain memoryStorage:[curr_num doubleValue]];
                button_pressed = @"=";
                break;
            } else if([character isEqual:@"mr"]) {
                curr_num = [NSString stringWithFormat:@"%g", [brain memoryRecall]];
                //Displays currnum
            } else if([character isEqual:@"mc"]) {
                [brain memoryClear];
                //Displays 0
            } else if([character isEqual:@"m+"]) {
                [brain memoryAdd:[curr_num doubleValue]];
                //Display memory
            } else if([character isEqual:@"m-"]) {
                [brain memorySubtract:[curr_num doubleValue]];
                //Displays memory
            } else if([character isEqual:@"C"]) {
                //Clear display
                //Clear label
                //Resets operand
                //Resets operator
            } else if([character isEqual:@"CE"]) {
                curr_num = @"";
                //Clear screen
            } else if([character isEqual:@"del"]) {
                //Subtracts 4 characters from label
                //If currnum has something in it, subtract one char
            }
            return;
        }
    }
    
    for (NSString *op in operators) {
        if ([button_pressed isEqual:op]) {
            if ([[brain operator] isEqual:@""]) { //If operator wasn't previously assigned
                if (equalsPressed) {
                    //Check if unary here
                    for (NSString *op in unaryOperators) {
                        if([button_pressed isEqual:op]) {
                            [self compute:op brain:brain];
                            [brain setOperator:@""];
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
                            curr_num = @"";
                            equalsPressed = true;
                            [brain setOperator:@""];
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
        curr_input = @"";
        return;
    } else {
        if (equalsPressed) {
            curr_num = @"";
            display.text = curr_num;
            equalsPressed = false;
        }
        
        NSError *error = NULL;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"." options:NSRegularExpressionCaseInsensitive error:&error];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:curr_num options:0 range:NSMakeRange(0, [curr_num length])];
        if (numberOfMatches > 1 && [button_pressed isEqual:@"."]) {
            return;
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
