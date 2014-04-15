//
//  TWCreateTabViewController.h
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TWCreateTabViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIButton *addPic;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseLocation;
@property (weak, nonatomic) IBOutlet UITextField *locations;

- (IBAction)album:(UIButton *)sender;
- (IBAction)addPicture:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;
- (IBAction)retakePic:(UIButton *)sender;
- (IBAction)locationToggle:(UISegmentedControl *)sender;
-(IBAction)ReturnKeyButton:(id)sender;


@end
