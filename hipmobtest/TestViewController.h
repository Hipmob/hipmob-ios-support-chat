//
//  TestViewController.h
//  hipmobtest
//
//  Created by Olufemi Omojola on 9/24/12.
//  Copyright (c) 2012 Orthogonal Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <hipmob/HMChatViewController.h>

@interface TestViewController : UIViewController
{
    HMChatViewController * livechat;
    BOOL display;
}
- (IBAction)openChat:(id)sender;

@end
