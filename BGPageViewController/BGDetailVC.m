//
//  BGDetailVC.m
//  BGPageViewController
//
//  Created by Bishal Ghimire on 2/19/14.
//  Copyright (c) 2014 Big B Soft. All rights reserved.
//

#import "BGDetailVC.h"

@interface BGDetailVC ()

@property (nonatomic, strong) UILabel *lbl;

@end

@implementation BGDetailVC

@synthesize array;
@synthesize index;
@synthesize lbl;

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
    self.view.backgroundColor = [UIColor grayColor];
    
    lbl = [[UILabel alloc] initWithFrame:CGRectMake(135, 100, 200, 20)];
    lbl.textColor = self.textColor;
    lbl.text = array[index];
    [self.view addSubview:lbl];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
