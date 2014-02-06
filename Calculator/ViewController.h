#import <UIKit/UIKit.h>
#import "LandscapeViewController.h"

@interface ViewController : UIViewController {
    BOOL isShowingLandscapeView;
}

@property(nonatomic, retain) IBOutlet UIView *portraitView;
@property(nonatomic, retain) IBOutlet UIView *landscapeView;
@property(nonatomic, strong) LandscapeViewController *secondVC;

@end
