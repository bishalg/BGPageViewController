//
//  BGDetailVC.h
//  BGPageViewController
//
//  Created by Bishal Ghimire on 2/19/14.
//  Copyright (c) 2014 Big B Soft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGDetailVC : UIViewController

@property (nonatomic) CGFloat fontValue;

@property (strong, nonatomic) id          dataObject;
@property (nonatomic, strong) NSArray     *array;
@property (nonatomic)         NSUInteger  index;

@end
