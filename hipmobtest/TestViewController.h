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
#define APPID           @"7152ce24a16d42eb8d30b5fe4c01f911"
#define ARTICLEURL      @"https://hipmob.desk.com/customer/portal/articles/1078783-add-push-notifications-to-iphone-and-android-apps-using-apns-gcm-and-parse"
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
