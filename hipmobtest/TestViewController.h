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

@interface TestViewController : UIViewController <UIWebViewDelegate, UIPopoverControllerDelegate, HMChatViewControllerDelegate, HMChatViewAvailabilityCheckDelegate>
{
    HMChatViewController * livechat;
    HMContentChatViewController * livechat2;
    HMChatPopoverController * livechatpopover;
    BOOL display;
}
- (IBAction)openChat:(id)sender;

@property (retain, nonatomic) IBOutlet UINavigationBar *navBar;

-(void)setToken:(NSData *)data;
-(void)setMessageWaitingIndicator:(NSObject *)indicator;

@end
