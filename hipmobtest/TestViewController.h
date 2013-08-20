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
#include <hipmob/HMHelpDeskArticleViewController.h>
#include <hipmob/HMHelpDeskArticleViewPopoverController.h>

#define STARTPAGE       @"http://web.mit.edu"
#define APPID           @"2ea7d86854df4ca185af84e68ea72fe1"
#define ARTICLEID       @"1169672"
//#define APPID         @"adb2a3dc1aeb470c9a805ce0213cfde4"
#define DEFAULTQUERY    @"iOS";
@interface TestViewController : UIViewController <UIWebViewDelegate, UIPopoverControllerDelegate, HMChatViewControllerDelegate, HMChatOperatorAvailabilityCheckDelegate, HMHelpDeskSearchViewControllerDelegate, HMHelpDeskArticleViewControllerDelegate, HMContentHelpDeskArticleViewControllerDelegate>
{
    HMChatViewController * livechat;
    HMContentChatViewController * livechat2;
    HMChatPopoverController * livechatpopover;
    
    HMHelpDeskSearchViewController * helpdesk;
    HMHelpDeskSearchPopoverController * helpdesk2;

    HMHelpDeskArticleViewController * helppage;
    HMHelpDeskArticleViewPopoverController * helppage2;
    
    BOOL display;
    BOOL display2;
    BOOL display3;
}

- (IBAction)openChat:(id)sender;

- (IBAction)openHelp:(id)sender;

- (IBAction)openInstantHelp:(id)sender;

@property (retain, nonatomic) IBOutlet UINavigationBar * navBar;

-(void)setToken:(NSData *)data;
-(void)setMessageWaitingIndicator:(NSObject *)indicator;

@end
