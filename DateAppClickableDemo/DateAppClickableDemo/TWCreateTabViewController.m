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
#import <QuartzCore/QuartzCore.h>
#import "Filter.h"
#import "UIImage+Extensions.h"


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

@synthesize imageView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

-(void) setup
{
    [self setupAppearance];
    [self initializeFilterContext];
    [self loadFiltersForImage:[UIImage imageNamed:@"logo2.png"]];
}

-(void) initializeFilterContext
{
    context = [CIContext contextWithOptions:nil];
}

-(void) setupAppearance
{
    //filtersScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, self.view.bounds.size.width, 90)];
    filtersScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, self.view.bounds.size.width, 90)];
    
    [filtersScrollView setScrollEnabled:YES];
    [filtersScrollView setShowsVerticalScrollIndicator:NO];
    filtersScrollView.showsHorizontalScrollIndicator = NO;
    
    
    //UIBarButtonItem *cameraBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePicture:)];
    
    //[[self navigationItem] setRightBarButtonItem:cameraBarButtonItem];
    //[[[self navigationItem] rightBarButtonItem] setTarget:self];
    //[[[self navigationItem] rightBarButtonItem] setAction:@selector(takePicture:)];
   
    [self.view addSubview:filtersScrollView];
    
}

-(void) applyGesturesToFilterPreviewImageView:(UIView *) view
{
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(applyFilter:)];
    
    singleTapGestureRecognizer.numberOfTapsRequired = 1;
    
    [view addGestureRecognizer:singleTapGestureRecognizer];
}


<<<<<<< HEAD
-(void) applyFilter:(id) sender
{
    selectedFilterView.layer.shadowRadius = 0.0f;
    selectedFilterView.layer.shadowOpacity = 0.0f;
    
    selectedFilterView = [(UITapGestureRecognizer *) sender view];
=======
- (IBAction)addPicture:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
>>>>>>> FETCH_HEAD
    
    selectedFilterView.layer.shadowColor = [UIColor yellowColor].CGColor;
    selectedFilterView.layer.shadowRadius = 3.0f;
    selectedFilterView.layer.shadowOpacity = 0.9f;
    selectedFilterView.layer.shadowOffset = CGSizeZero;
    selectedFilterView.layer.masksToBounds = NO;
    
    int filterIndex = selectedFilterView.tag;
    Filter *filter = [filters objectAtIndex:filterIndex];
    
<<<<<<< HEAD
    CIImage *outputImage = [filter.filter outputImage];
    
    CGImageRef cgimg =
    [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    finalImage = [UIImage imageWithCGImage:cgimg];
    
    //finalImage = [finalImage imageRotatedByDegrees:90];
    
    [self.imageView setImage:finalImage];
    
    CGImageRelease(cgimg);
    
}

-(void) createPreviewViewsForFilters
{
    int offsetX = 10;
    
    for(int index = 0; index < [filters count]; index++)
    {
        UIView *filterView = [[UIView alloc] initWithFrame:CGRectMake(offsetX, 0, 60, 60)];
        
        
        filterView.tag = index;
        
        // create a label to display the name
        UILabel *filterNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, filterView.bounds.size.width, 8)];
        
        filterNameLabel.center = CGPointMake(filterView.bounds.size.width/2, filterView.bounds.size.height + filterNameLabel.bounds.size.height);
        
        Filter *filter = (Filter *) [filters objectAtIndex:index];
        
        filterNameLabel.text =  filter.name;
        filterNameLabel.backgroundColor = [UIColor clearColor];
        filterNameLabel.textColor = [UIColor whiteColor];
        filterNameLabel.font = [UIFont fontWithName:@"AppleColorEmoji" size:10];
        filterNameLabel.textAlignment = UITextAlignmentCenter;
        
        CIImage *outputImage = [filter.filter outputImage];
        
        CGImageRef cgimg =
        [context createCGImage:outputImage fromRect:[outputImage extent]];
        
        UIImage *smallImage =  [UIImage imageWithCGImage:cgimg];
        
        //if(smallImage.imageOrientation == UIImageOrientationUp)
        //{
        //    smallImage = [smallImage imageRotatedByDegrees:90];
        //}
        
        // create filter preview image views
        UIImageView *filterPreviewImageView = [[UIImageView alloc] initWithImage:smallImage];
        
        [filterView setUserInteractionEnabled:YES];
        
        filterPreviewImageView.layer.cornerRadius = 15;
        filterPreviewImageView.opaque = NO;
        filterPreviewImageView.backgroundColor = [UIColor clearColor];
        filterPreviewImageView.layer.masksToBounds = YES;
        filterPreviewImageView.frame = CGRectMake(0, 0, 60, 60);
        
        filterView.tag = index;
        
        [self applyGesturesToFilterPreviewImageView:filterView];
        
        [filterView addSubview:filterPreviewImageView];
        [filterView addSubview:filterNameLabel];
        
        [filtersScrollView addSubview:filterView];
        
        offsetX += filterView.bounds.size.width + 10;
        
    }
    
    [filtersScrollView setContentSize:CGSizeMake(400, 90)];
}

-(void) loadFiltersForImage:(UIImage *) image
{
    
    CIImage *filterPreviewImage = [[CIImage alloc] initWithImage:image];
    
    CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey,filterPreviewImage,
                             @"inputIntensity",[NSNumber numberWithFloat:0.8],nil];
    
    
    CIFilter *colorMonochrome = [CIFilter filterWithName:@"CIColorMonochrome" keysAndValues:kCIInputImageKey,filterPreviewImage,
                                 @"inputColor",[CIColor colorWithString:@"Red"],
                                 @"inputIntensity",[NSNumber numberWithFloat:0.8], nil];
    
    filters = [[NSMutableArray alloc] init];
    
    
    [filters addObjectsFromArray:[NSArray arrayWithObjects:
                                  [[Filter alloc] initWithNameAndFilter:@"Sepia" filter:sepiaFilter],
                                  [[Filter alloc] initWithNameAndFilter:@"Mono" filter:colorMonochrome]
                                  , nil]];
    
    
    [self createPreviewViewsForFilters];
=======
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
>>>>>>> FETCH_HEAD
}
/*
(void) takePicture:(id) sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    
    [imagePicker setDelegate:self];
    
    [self presentModalViewController:imagePicker animated:YES];
}*/

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //finalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    finalImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
<<<<<<< HEAD
    [self.imageView setImage:finalImage];
    
    // UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    [self dismissModalViewControllerAnimated:YES];
    
    // load the filters again
=======
    //cropped picture
    originalImage = [info valueForKey:UIImagePickerControllerEditedImage];
    [self.imageView setImage:originalImage];
    [picker dismissModalViewControllerAnimated:YES];
>>>>>>> FETCH_HEAD
    
    [self loadFiltersForImage:finalImage];
}

<<<<<<< HEAD
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
=======
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    //disable imageview
    _imageView.hidden = YES;
    //enable add pic button
    _addPic.hidden = NO;

}

#pragma mark Camera Overlay Actions
>>>>>>> FETCH_HEAD

- (void)viewWillDisappear:(BOOL)animated
{
<<<<<<< HEAD
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)camera:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setDelegate:self];
    imagePicker.allowsEditing = YES;
    
    [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)photoalbum:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    imagePicker.allowsEditing = YES;
    [imagePicker setDelegate:self];
    [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)submit:(UIButton *)sender {
    // on submission, save image
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
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

=======
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

>>>>>>> FETCH_HEAD
@end


