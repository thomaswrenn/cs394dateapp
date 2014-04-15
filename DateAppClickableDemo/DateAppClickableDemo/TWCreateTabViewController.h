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

- (IBAction)album:(UIButton *)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)addFilter:(UIButton *)sender;
- (IBAction)saveImage:(UIButton *)sender;
- (IBAction)addPicture:(UIButton *)sender;
- (IBAction)submit:(UIButton *)sender;


@end
