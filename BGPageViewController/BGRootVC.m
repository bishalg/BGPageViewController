//
//  BGRootVC.m
//  BGPageViewController
//
//  Created by Bishal Ghimire on 2/19/14.
//  Copyright (c) 2014 Big B Soft. All rights reserved.
//

#import "BGRootVC.h"
#import "BGDetailVC.h"

@interface BGRootVC ()

@property (nonatomic) CGFloat fontValue;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic) NSUInteger currentIndex;

@end

@implementation BGRootVC

@synthesize pageViewController, pageContent;
@synthesize fontValue;
@synthesize textColor;
@synthesize currentIndex;

#pragma mark - Page View Controller Data Source

- (BGDetailVC *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return the data view controller for the given index.
    if (([self.pageContent count] == 0) || (index >= [self.pageContent count])) {
        return nil;
    }
    BGDetailVC *dataViewController      = [[BGDetailVC alloc] init];
    dataViewController.fontValue        = fontValue;
    dataViewController.array            = pageContent;
    dataViewController.index            = index;
    dataViewController.dataObject       = [self.pageContent objectAtIndex:index];
    dataViewController.textColor        = textColor;
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(BGDetailVC *)viewController {
    return [self.pageContent indexOfObject:viewController.dataObject];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:(BGDetailVC *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    self.currentIndex = index;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:(BGDetailVC *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContent count]){
        return nil;
    }
    self.currentIndex = index;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (void)setUpPageViewController {
    pageContent = [[NSArray alloc] init];
    pageContent = @[@"One", @"Two", @"Three", @"Four", @"Five"];

    self.pageViewController                     = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                                                  navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                                                options:nil];
    self.pageViewController.delegate            = self;
    self.pageViewController.dataSource          = self;
    
    BGDetailVC *dataViewController      = [self viewControllerAtIndex:self.newsIndex storyboard:self.storyboard];
    NSArray *viewControllers                    = @[dataViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    dataViewController.fontValue                = fontValue;
    dataViewController.array            = pageContent;
    dataViewController.index            = 0;

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect newPageViewRect                      = self.view.bounds;
    newPageViewRect.origin.y                    = 70;
    CGRect pageViewRect                         = newPageViewRect;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect                            = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    self.pageViewController.view.frame          = pageViewRect;
    [self.pageViewController didMoveToParentViewController:self];
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers                = self.pageViewController.gestureRecognizers;
}

- (void)setupSegmentControl {
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"Red",@"Green",@"Blue",nil]];
    segmentControl.frame = CGRectMake(55, 45, 200, 20);
    segmentControl.selectedSegmentIndex = 0;
   [segmentControl setTintColor:[UIColor blackColor]];
    [segmentControl addTarget:self action:@selector(segmentViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentControl];
}

- (IBAction)segmentViewValueChanged:(UISegmentedControl *)sControl
{
    if (sControl.selectedSegmentIndex==0) {
        textColor = [UIColor redColor];
    }
    else if (sControl.selectedSegmentIndex==1) {
        textColor = [UIColor greenColor];
    }
    else if (sControl.selectedSegmentIndex==2) {
        textColor = [UIColor blueColor];
    }
    
    BGDetailVC *dataViewController      = [self viewControllerAtIndex:currentIndex-1 storyboard:self.storyboard];
    dataViewController.textColor = textColor;
    NSArray *viewControllers                    = @[dataViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
//    __block BGRootVC *blocksafeSelf = self;
//    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished){
//        if(finished)
//        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [blocksafeSelf.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];// bug fix for uipageview controller
//            });
//        }
//    }];
}

#pragma mark - View Life Cycle

- (id)initWithCoder:(NSCoder *)aDecoder {
    self  = [super initWithCoder:aDecoder];
    return self;
}

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
    [self setupSegmentControl];
	[self setUpPageViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
