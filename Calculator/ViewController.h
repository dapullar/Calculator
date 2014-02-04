//
//  ViewController.h
//  Calculator
//
//  Created by David Pullar on 1/20/2014.
//  Copyright (c) 2014 David Pullar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LandscapeViewController.h"

@interface ViewController : UIViewController {
    BOOL isShowingLandscapeView;
}

@property(nonatomic, retain) IBOutlet UIView *portraitView;
@property(nonatomic, retain) IBOutlet UIView *landscapeView;
@property(nonatomic, strong) LandscapeViewController *secondVC;

@end
