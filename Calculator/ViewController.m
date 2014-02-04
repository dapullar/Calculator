//
//  ViewController.m
//  Calculator
//
//  Created by David Pullar on 1/20/2014.
//  Copyright (c) 2014 David Pullar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

@synthesize portraitView, landscapeView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    isShowingLandscapeView = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    switch(device.orientation)
    {
        case UIDeviceOrientationPortrait:
            NSLog(@"Portrait");
            if(isShowingLandscapeView) {
                [self performSegueWithIdentifier:@"Landscape_Segue" sender:self];
                isShowingLandscapeView = NO;
            }
            break;
            
        case UIDeviceOrientationLandscapeRight:
            NSLog(@"Landscape");
            if(!isShowingLandscapeView) {
                [self performSegueWithIdentifier:@"Landscape_Segue" sender:self];
                isShowingLandscapeView = YES;
            }
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"Landscape 2");
            if(!isShowingLandscapeView) {
                [self performSegueWithIdentifier:@"Landscape_Segue" sender:self];
                isShowingLandscapeView = YES;
            }
            break;
            
        default:
            break;
    };
}
@end