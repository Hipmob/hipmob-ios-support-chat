//
//  TestViewController.h
//  hipmobtest
//
//  Created by Olufemi Omojola on 9/24/12.
//  Copyright (c) 2012 Orthogonal Labs, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <hipmob/HMChatViewController.h>
#include <hipmob/HMContentChatViewController.h>
#include <hipmob/HMChatPopoverController.h>
#include <hipmob/HMHelpDeskSearchViewController.h>
#include <hipmob/HMContentHelpDeskSearchViewController.h>
#include <hipmob/HMHelpDeskSearchPopoverController.h>

@interface TestViewController : UIViewController <UIWebViewDelegate, UIPopoverControllerDelegate, HMChatViewControllerDelegate, HMChatOperatorAvailabilityCheckDelegate, HMHelpDeskSearchViewControllerDelegate>
{
    HMChatViewController * livechat;
    HMContentChatViewController * livechat2;
    HMChatPopoverController * livechatpopover;
    
    HMHelpDeskSearchViewController * helpdesk;
    HMHelpDeskSearchPopoverController * helpdesk2;

    BOOL display;
    BOOL display2;
}

- (IBAction)openChat:(id)sender;

- (IBAction)openHelp:(id)sender;

@property (retain, nonatomic) IBOutlet UINavigationBar * navBar;

-(void)setToken:(NSData *)data;
-(void)setMessageWaitingIndicator:(NSObject *)indicator;

@end
