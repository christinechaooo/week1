//
//  MainViewController.m
//  week1
//
//  Created by Christine Chao on 6/6/14.
//  Copyright (c) 2014 Christine Chao. All rights reserved.
//

#import "MainViewController.h"
#import "TTTAttributedLabel.h"

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
    
    const CGFloat fontSize = 14;
    UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationItem.title = @"Post";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share-white"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, 500)];
    containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:containerView];
    
    UIView *postBgView = [[UIView alloc] initWithFrame:CGRectMake(12, 12, 296, 480)];
    postBgView.backgroundColor = [UIColor whiteColor];
    postBgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    postBgView.layer.shadowOpacity = 0.2;
    postBgView.layer.shadowOffset = CGSizeMake(2, 2);
    postBgView.layer.shadowRadius = 1;
    postBgView.layer.cornerRadius = 2;
    postBgView.layer.borderWidth = 1;
    postBgView.layer.borderColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1].CGColor;
    [containerView addSubview:postBgView];
    
    UIImage *profilePic = [UIImage  imageNamed:@"her_profile_pic"];
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 47, 47)];
    profileImageView.image = profilePic;
    
    UIView *commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 415, 320, 44)];
    commentView.layer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    commentView.layer.borderWidth = 1;
    commentView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 16, 100, 20)];
    titleLabel.text = @"Her";
    titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    
    UILabel *postDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 35, 200, 20)];
    postDateLabel.text = @"Feburary 1 at 11:00AM";
    postDateLabel.textColor = [UIColor grayColor];
    postDateLabel.font = [UIFont systemFontOfSize:12];
    
    TTTAttributedLabel *postLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(12, 52, 270, 100)];
    postLabel.font = [UIFont systemFontOfSize:13];
    postLabel.numberOfLines = 0;
    postLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    
    NSString *postText = @"From collarless shirts to high-waisted pants, #Her's costume designer, Casey Storm, explains how he created his fashion looks for the future: http://bit.ly/1jV9zM8";
    [postLabel setText:postText afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"Her" options:NSCaseInsensitiveSearch];
        
        // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldFont.fontName, boldFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];
    
    NSRange linkRange = [postText rangeOfString:@"http://bit.ly/1jV9zM8"];
    NSArray *keys = [[NSArray alloc] initWithObjects:(id)kCTForegroundColorAttributeName,(id)kCTUnderlineStyleAttributeName
                     , nil];
    NSArray *objects = [[NSArray alloc] initWithObjects:[UIColor colorWithRed:68.0/255.0 green:98.0/255.0 blue:161.0/255.0 alpha:1],[NSNumber numberWithInt:kCTUnderlineStyleNone], nil];
    NSDictionary *linkAttributes = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    postLabel.linkAttributes = linkAttributes;
    [postLabel addLinkToURL:[NSURL URLWithString:@"http://bit.ly/1jV9zM8"] withRange:linkRange];
    
    UIImage *promoImage = [UIImage  imageNamed:@"her_promo_img"];
    UIImageView *promoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 155, 310, 175)];
    promoImageView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    promoImageView.layer.shadowOpacity = 0.2;
    promoImageView.layer.shadowOffset = CGSizeMake(1, 1);
    promoImageView.layer.shadowRadius = 1;
    promoImageView.image = promoImage;
    
    UIImage *tabBar = [UIImage  imageNamed:@"tabbar"];
    UIImageView *tabBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 458, 320, 45)];
    tabBarImageView.image = tabBar;
    
    UITextField *commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, 240, 34)];
    commentTextField.borderStyle = UITextBorderStyleRoundedRect;
    commentTextField.font = [UIFont systemFontOfSize:fontSize];
    UIColor *gray = [UIColor grayColor];
    commentTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Write a comment..." attributes:@{NSForegroundColorAttributeName: gray}];
    
    [commentView addSubview:commentTextField];

    [containerView addSubview:promoImageView];
    [containerView addSubview:commentView];
    [containerView addSubview:tabBarImageView];
    
    [postBgView addSubview:profileImageView];
    [postBgView addSubview:titleLabel];
    [postBgView addSubview:postDateLabel];
    [postBgView addSubview:postLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
