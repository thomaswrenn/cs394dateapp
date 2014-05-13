//
//  TWCreateTabViewController.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Filter.h"
#import "UIImage+Extensions.h"


@interface TWCreateTabViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    CIContext *context;
    NSMutableArray *filters;
    CIImage *beginImage;
    UIScrollView *filtersScrollView;
    UIView *selectedFilterView;
    UIImage *finalImage;
    
}

//@property (weak, nonatomic) IBOutlet UIButton *addPic;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseLocation;
@property (weak, nonatomic) IBOutlet UITextField *locations;

//- (IBAction)album:(UIButton *)sender;
//- (IBAction)addPicture:(UIButton *)sender;
//- (IBAction)submit:(UIButton *)sender;
//- (IBAction)retakePic:(UIButton *)sender;
- (IBAction)locationToggle:(UISegmentedControl *)sender;
-(IBAction)ReturnKeyButton:(id)sender;

- (IBAction)camera:(id)sender;
- (IBAction)photoalbum:(id)sender;

//overlay
//- (IBAction)done:(id)sender;
//- (IBAction)takePhoto:(id)sender;
//- (IBAction)startStop:(id)sender;
//- (IBAction)timedTakePhoto:(id)sender;


//@property (weak, nonatomic) IBOutlet UIView *cameraOverlay;

//@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *takePictureButton;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *timedButton;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *startStopButton;

//timers, if using it
//@property (nonatomic, retain) NSTimer *tickTimer;
//@property (nonatomic, retain) NSTimer *cameraTimer;


//@property (nonatomic, retain) UIImagePickerController *imagePickerController;


@end
