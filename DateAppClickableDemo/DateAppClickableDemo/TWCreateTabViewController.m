//
//  TWCreateTabViewController.m
//  DateAppClickableDemo
//
//  Created by Thomas Wrenn on 3/31/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWCreateTabViewController.h"
#import "GPUImage.h"
#import <CoreLocation/CoreLocation.h>


enum
{
	kOneShot,       // user wants to take a delayed single shot
	kRepeatingShot  // user wants to take repeating shots
};

@interface TWCreateTabViewController (){
    UIImage *originalImage;
    CLLocationManager *locationManager;
}

@end

@implementation TWCreateTabViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//return key makes the keyboard disappear
-(IBAction)ReturnKeyButton:(id)sender{
    [sender resignFirstResponder];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
        self.imagePickerController.cameraOverlayView = [[TWCreateTabViewController alloc ]initWithNibName:@"OverlayViewController" bundle:nil].view;

    
    }
    
    _chooseLocation.selectedSegmentIndex = 1;

    //disable imageview
    _imageView.hidden = YES;
    //enable add pic button
    _addPic.hidden = NO;
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
}


- (IBAction)addPicture:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    picker.showsCameraControls = NO;
    //picker.navigationBarHidden = YES;
    
    [[UINib nibWithNibName:@"overlay" bundle:nil] instantiateWithOwner:self options:nil];
    
    picker.cameraOverlayView = self.cameraOverlay;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    // enable imageview
    _imageView.hidden = NO;
    // disable add pic button
    _addPic.hidden = YES;
}

- (IBAction)submit:(UIButton *)sender {
    // on submission, save image
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (IBAction)retakePic:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)locationToggle:(UISegmentedControl *)sender {
    if (_chooseLocation.selectedSegmentIndex == 0) {
        _locations.enabled = FALSE;
        //get current location
        locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        [locationManager startUpdatingLocation];
        _locations.text = [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
    }
    else{
        _locations.enabled = TRUE;
        _locations.text = @"";
    }

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *alertTitle;
    NSString *alertMessage;
    
    if(!error)
    {
        alertTitle   = @"Image Saved";
        alertMessage = @"Image saved to photo album successfully.";
    }
    else
    {
        alertTitle   = @"Error";
        alertMessage = @"Unable to save to photo album.";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                    message:alertMessage
                                                   delegate:self
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)album:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    //enable imageview
    _imageView.hidden = NO;
    //disable add pic button
    _addPic.hidden = YES;
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //cropped picture
    originalImage = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.imageView setImage:originalImage];
    [picker dismissModalViewControllerAnimated:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    //disable imageview
    _imageView.hidden = YES;
    //enable add pic button
    _addPic.hidden = NO;

}

#pragma mark Camera Overlay Actions

- (IBAction)done:(id)sender
{
    // dismiss the camera but not if it's still taking timed pictures
    if (![self.cameraTimer isValid])
        [self finishAndUpdate];
}

- (IBAction)takePhoto:(id)sender
{
    // this will take a timed photo, to be taken 5 seconds from now
    [self.imagePickerController takePicture];
}

- (void)finishAndUpdate
{
    
    // restore the state of our overlay toolbar buttons
    self.cancelButton.enabled = YES;
    self.takePictureButton.enabled = YES;
    self.timedButton.enabled = YES;
    self.startStopButton.enabled = YES;
    self.startStopButton.title = @"Start";
}

@end


