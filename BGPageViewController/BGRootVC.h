//
//  BGRootVC.h
//  BGPageViewController
//
//  Created by Bishal Ghimire on 2/19/14.
//  Copyright (c) 2014 Big B Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGRootVC : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController       * pageViewController;
@property (strong, nonatomic) NSArray                    * pageContent;
@property (nonatomic)         NSUInteger                   newsIndex;

@end
