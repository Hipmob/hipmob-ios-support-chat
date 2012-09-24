//
//  TestAppDelegate.h
//  hipmobtest
//
//  Created by Olufemi Omojola on 9/24/12.
//  Copyright (c) 2012 Orthogonal Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestViewController;

@interface TestAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TestViewController *viewController;

@end
