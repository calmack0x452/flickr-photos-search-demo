//
//  ViewController.m
//  Flickr PS
//
//  Created by Mack Liu on 2020/2/28.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchConditionModel.h"
#import "SearchResultViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *keyword;
@property (weak, nonatomic) IBOutlet UITextField *perPage;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self disableSearchButton:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - NSNotificationCenter Methods

- (void)textFieldDidChange:(NSNotification *)notification {
    
    if (_keyword.text.length > 0 &&
        _perPage.text.length > 0) {
        [self disableSearchButton:NO];
    }
    else {
        [self disableSearchButton:YES];
    }
}

#pragma mark - Button Events

- (void)disableSearchButton:(BOOL)disable {
    
    if (disable) {
        _searchButton.userInteractionEnabled = NO;
        _searchButton.backgroundColor = [UIColor lightGrayColor];
    }
    else {
        _searchButton.userInteractionEnabled = YES;
        _searchButton.backgroundColor = [UIColor colorWithRed:0.0f green:(122.0f/255.0f) blue:1.0f alpha:1.0f];
    }
}

- (IBAction)searchButtonTaped:(UIButton *)sender {
    
    SearchConditionModel *searchCondition = [SearchConditionModel sharedInstance];
    searchCondition.keyword = _keyword.text;
    searchCondition.photosPerPage = _perPage.text;
    
    [self performSegueWithIdentifier:@"tabBarConnector" sender:searchCondition];
}

@end
