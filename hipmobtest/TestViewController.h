//
//  TestViewController.h
//  hipmobtest
//
//  Created by Olufemi Omojola on 9/24/12.
//  Copyright (c) 2012 Orthogonal Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <hipmob/hipmob.h>

@interface TestViewController : UIViewController
{
    hipmob * iphonechat;
    hipmobView * ipadchat;
    BOOL display;
}
- (IBAction)openChat:(id)sender;

@end
