//
//  MainViewController.m
//  week1
//
//  Created by Christine Chao on 6/6/14.
//  Copyright (c) 2014 Christine Chao. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor colorWithRed:211.0/255.0 green:214.0/255.0 blue:219.0/255.0 alpha:1]];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = @"Post";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share-white"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(12, 78, 296, 480)];
    containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containerView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
