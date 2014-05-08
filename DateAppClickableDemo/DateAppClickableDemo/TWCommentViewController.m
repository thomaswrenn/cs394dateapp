//
//  TWCommentViewController.m
//  DateAppClickableDemo
//
//  Created by Jessica Wu on 5/5/14.
//  Copyright (c) 2014 Thomas Wrenn. All rights reserved.
//

#import "TWCommentViewController.h"
#import "TWUtility.h"
#import "TWCommentTableViewCell.h"
#import "DAKeyboardControl.h"

@interface TWCommentViewController ()
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UITextField *commentField;

@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation TWCommentViewController
@synthesize comments,toolbar,commentField,tableview;

CGRect keyboardFrame;
CGRect tvFrameBefore;//keyboard
CGRect tvFrameAfter;//keyboard

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view removeKeyboardControl];
}



-(void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    
    if( comments.count > 0 ){
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[comments count]-1 inSection:0];
        [tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tvFrameBefore = tableview.frame;
    tvFrameAfter = tableview.frame;

    //keyboard
    self.view.keyboardTriggerOffset = toolbar.bounds.size.height;
    __weak typeof(UIToolbar) *weakToolbar = toolbar;
    __weak typeof(UITableView) *weakTableview = tableview;
    [self.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView) {
        
        keyboardFrame = keyboardFrameInView;
        
        CGRect toolBarFrame = weakToolbar.frame;
        toolBarFrame.origin.y = keyboardFrameInView.origin.y - toolBarFrame.size.height;
        weakToolbar.frame = toolBarFrame;
        
        CGRect tableViewFrame = weakTableview.frame;
        
        tableViewFrame.size.height = toolBarFrame.origin.y;
        tvFrameAfter.size.height = toolBarFrame.origin.y;
        weakTableview.frame = tableViewFrame;
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)keyboardDidShow: (NSNotification *) notif{
    // Do something here
    tableview.frame = tvFrameAfter;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[comments count]-1 inSection:0];
    [tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    // Do something here
    tableview.frame = tvFrameBefore;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addComments:(id)sender {
    if( [commentField.text isEqualToString:@""] ){
        return;
    }
    
    NSString* text = commentField.text;
    
    NSString* myName = @"Jessica";
    
    NSArray *keys = [NSArray arrayWithObjects:@"user", @"text",@"\n", nil];
    NSArray *objects = [NSArray arrayWithObjects:myName, text,@"\n", nil];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:objects
                                                            forKeys:keys];
    [commentField setText:@""];
    [comments addObject:dic];
    
    [tableview reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[comments count]-1 inSection:0];
    [tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];

    


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate


-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        NSLog(@"size: %f",keyboardFrame.origin.y);
        if( keyboardFrame.origin.y == 0 || keyboardFrame.origin.y > self.tableview.frame.size.height){
            return;
        }
        self.view.keyboardTriggerOffset = toolbar.bounds.size.height;
        CGRect toolBarFrame = toolbar.frame;
        toolBarFrame.origin.y = keyboardFrame.origin.y - toolBarFrame.size.height;
        toolbar.frame = toolBarFrame;
        
        tableview.frame = tvFrameAfter;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[comments count]-1 inSection:0];
        [tableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];

    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [comments count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"commentCell";
    
    TWCommentTableViewCell *cell = (TWCommentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];

    NSDictionary* cDic = comments[indexPath.row];
    NSString* commentStr = [TWUtility commentFromCommentNSDict: cDic];
    [cell.commentLabel setText:commentStr];
    
    return cell;
}


@end
