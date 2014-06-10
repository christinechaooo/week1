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

@property (nonatomic,strong) UIView *commentView;
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;
- (void)hideKeyboard;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor colorWithRed:211.0/255.0 green:214.0/255.0 blue:219.0/255.0 alpha:1]];
    
    const CGFloat fontSize = 14;
    UIFont *boldFont = [UIFont boldSystemFontOfSize:fontSize];
    UIColor *lightGray = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    
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
    postBgView.layer.borderColor = lightGray.CGColor;
    [containerView addSubview:postBgView];
    
    UIImage *profilePic = [UIImage  imageNamed:@"her_profile_pic"];
    UIImageView *profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 12, 47, 47)];
    profileImageView.image = profilePic;
    
    self.commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 479, 320, 44)];
    self.commentView.layer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    self.commentView.layer.borderWidth = 1;
    self.commentView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 16, 100, 20)];
    titleLabel.text = @"Her";
    titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    
    UILabel *postDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 35, 200, 20)];
    postDateLabel.text = @"Feburary 1 at 11:00AM";
    postDateLabel.textColor = [UIColor grayColor];
    postDateLabel.font = [UIFont systemFontOfSize:12];
    
    TTTAttributedLabel *contentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(12, 52, 270, 100)];
    contentLabel.font = [UIFont systemFontOfSize:13];
    contentLabel.numberOfLines = 0;
    contentLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    
    NSString *postText = @"From collarless shirts to high-waisted pants, #Her's costume designer, Casey Storm, explains how he created his fashion looks for the future: http://bit.ly/1jV9zM8";
    [contentLabel setText:postText afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
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
    contentLabel.linkAttributes = linkAttributes;
    [contentLabel addLinkToURL:[NSURL URLWithString:@"http://bit.ly/1jV9zM8"] withRange:linkRange];
    
    UIImage *promoImage = [UIImage  imageNamed:@"her_promo_img"];
    UIImageView *promoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 155, 310, 175)];
    promoImageView.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    promoImageView.layer.shadowOpacity = 0.2;
    promoImageView.layer.shadowOffset = CGSizeMake(1, 1);
    promoImageView.layer.shadowRadius = 1;
    promoImageView.image = promoImage;
    
    UIImage *tabBar = [UIImage  imageNamed:@"tabbar"];
    UIImageView *tabBarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 522, 320, 45)];
    tabBarImageView.image = tabBar;
    
    UITextField *commentTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, 5, 240, 34)];
    commentTextField.borderStyle = UITextBorderStyleRoundedRect;
    commentTextField.font = [UIFont systemFontOfSize:fontSize];
    UIColor *gray = [UIColor grayColor];
    commentTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Write a comment..." attributes:@{NSForegroundColorAttributeName: gray}];
    
    UILabel *postLabel = [[UILabel alloc] initWithFrame:CGRectMake(267, 8, 50, 30)];
    postLabel.text = @"Post";
    postLabel.textColor = lightGray;
    postLabel.font = [UIFont boldSystemFontOfSize:16];
    
    UIView *actionBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 330, 296, 44)];
    actionBarView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1];
    actionBarView.layer.borderColor = [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1].CGColor;
    actionBarView.layer.borderWidth = 1;
    
    TTTAttributedLabel *likeLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(13, 370, 320, 44)];
    likeLabel.font = [UIFont systemFontOfSize:13];
    likeLabel.numberOfLines = 0;
    
    NSString *likeText = @"1,675 people like this.";
    [likeLabel setText:likeText afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange boldRange = [[mutableAttributedString string] rangeOfString:@"1,675 people" options:NSCaseInsensitiveSearch];
        
        // Core Text APIs use C functions without a direct bridge to UIFont. See Apple's "Core Text Programming Guide" to learn how to configure string attributes.
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldFont.fontName, boldFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    likeButton.frame = CGRectMake(8, 0, 60, 44);
    likeButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    likeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, likeButton.imageView.frame.size.width - 10);
    [likeButton setTitle:@"Like" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"like_btn"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"like_btn_selected"] forState:UIControlStateSelected];
    [likeButton setImage:[UIImage imageNamed:@"like_btn_selected"] forState:UIControlStateHighlighted];
    [likeButton setImage:[UIImage imageNamed:@"like_btn_selected"] forState:UIControlStateSelected | UIControlStateHighlighted];
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButton.frame = CGRectMake(95, 0, 100, 44);
    commentButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, likeButton.imageView.frame.size.width - 25);
    [commentButton setTitle:@"Comment" forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [commentButton setImage:[UIImage imageNamed:@"comment_btn"] forState:UIControlStateNormal];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(198, 0, 100, 44);
    shareButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, likeButton.imageView.frame.size.width - 28);
    [shareButton setTitle:@"Share" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"share_btn"] forState:UIControlStateNormal];
    
    [actionBarView addSubview:likeButton];
    [actionBarView addSubview:commentButton];
    [actionBarView addSubview:shareButton];
    [self.commentView addSubview:commentTextField];
    [self.commentView addSubview:postLabel];

    [containerView addSubview:promoImageView];
    [self.view addSubview:self.commentView];
    [self.view addSubview:tabBarImageView];
    
    [postBgView addSubview:profileImageView];
    [postBgView addSubview:titleLabel];
    [postBgView addSubview:postDateLabel];
    [postBgView addSubview:contentLabel];
    [postBgView addSubview:likeLabel];
    [postBgView addSubview:actionBarView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.02
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentView.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.commentView.frame.size.height, self.commentView.frame.size.width, self.commentView.frame.size.height);
                     }
                     completion:nil];
}

-(void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    NSLog(@"animation duration %f", animationDuration);
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:(animationCurve << 16)
                     animations:^{
                         self.commentView.frame = CGRectMake(0, 479, self.commentView.frame.size.width, self.commentView.frame.size.height);
                     }
                     completion:nil];
}


@end
