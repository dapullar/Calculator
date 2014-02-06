#import <Foundation/Foundation.h>
#import "CalculatorBrain.h"

@interface Controller : NSObject {
    IBOutlet UILabel *display;
    IBOutlet UISwitch *radDeg;
    IBOutlet UILabel *currInput;
}

- (IBAction)operationHandler:(UIButton *)sender;
- (IBAction)switchColour:(UISwitch *)sender;
- (void)compute:(NSString *)operator brain:(CalculatorBrain *)brain;

@end
