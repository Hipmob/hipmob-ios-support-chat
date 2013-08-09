//
//  TestViewController.m
//  hipmobtest
//
//  Created by Olufemi Omojola on 9/24/12.
//  Copyright (c) 2012 Orthogonal Labs, Inc. All rights reserved.
//

#import "TestViewController.h"
#import <CoreFoundation/CoreFoundation.h>

#define APPID @"2ea7d86854df4ca185af84e68ea72fe1"
@interface TestViewController ()
{
    UIWebView * mainWebView;
    UIActivityIndicatorView * activity;
    // tracks the current URL being displayed
    NSURLRequest * currenturl;
    NSData * token;
    NSString * userid;
}
@end

@implementation TestViewController

-(void)setMessageWaitingIndicator:(NSObject *)indicator
{
    _navBar.topItem.rightBarButtonItem.title = [NSString stringWithFormat:@"Chat (%@)", indicator, nil];
}

-(void)setToken:(NSData *)data
{
#if !__has_feature(objc_arc)
    if(token) [token release];
    token = [data retain];
#else
    token = data;
#endif
}

- (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    NSString * uuid = [NSString stringWithString:(__bridge NSString *)uuidStringRef];
    CFRelease(uuidStringRef);
    return uuid;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _navBar.topItem.title = @"Support Chat Demo";
	// Do any additional setup after loading the view, typically from a nib.
    display= NO;
    display2 = NO;
    activity = (UIActivityIndicatorView *)[self.view viewWithTag:201];
    mainWebView = (UIWebView *)[self.view viewWithTag:200];
    mainWebView.delegate = self;
    activity.hidden = YES;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    userid = [defaults stringForKey:@"userid"];
    if(!userid){
        userid = [self uuid];
        [defaults setObject:userid forKey:@"userid"];
        [defaults synchronize];
    }
    currenturl = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://web.mit.edu"]];
#if !__has_feature(objc_arc)
    [currenturl retain];
    [userid retain];
#endif
    [self gotoURL:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(void)operatorOffline:(NSString *)app
{
    _navBar.topItem.rightBarButtonItem.tintColor = [UIColor orangeColor];
}

-(void)operatorAvailable:(NSString *)app
{
    _navBar.topItem.rightBarButtonItem.tintColor = [UIColor colorWithRed:0/255.0 green:153.0/255.0 blue:0/255.0 alpha:1];
}

// handles URL load requests
- (void)gotoURL:(id)sender {
    [mainWebView loadRequest:currenturl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openHelp:(id)sender
{
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
#if !__has_feature(objc_arc)
       if(helpdesk) [helpdesk release];
#endif
       helpdesk = [[HMHelpDeskSearchViewController alloc] initWithAppID:APPID andUser:userid andInfo:nil];
       helpdesk.searchDelegate = self;
       helpdesk.searchView.defaultQuery = @"iOS";
       helpdesk.shouldUseSystemBrowser = NO;
       [self presentModalViewController:helpdesk animated:YES];
   }else{
       if(!display2){
#if !__has_feature(objc_arc)
           if(helpdesk2) [helpdesk2 release];
#endif
           helpdesk2 = [[HMHelpDeskSearchPopoverController alloc] initWithView:(UIView *)sender andAppID:APPID andUser:userid andInfo:nil];

           helpdesk2.content.navigationBar.tintColor = [UIColor colorWithRed:145.0/255.0 green:18.0/255.0 blue:0.0 alpha:1];
           helpdesk2.content.title = @"Help";
           helpdesk2.content.searchView.defaultQuery = @"iOS";
           helpdesk2.content.contentSizeForViewInPopover = CGSizeMake(320, 240);
           helpdesk2.passthroughViews = [[NSArray alloc] initWithObjects:self.view, nil];
           
           helpdesk2.content.searchDelegate = self;
           [helpdesk2 presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
           display2 = YES;
       }
   }
}

#if __has_feature(objc_arc)
- (IBAction)openChat:(id)sender {
    _navBar.topItem.rightBarButtonItem.title = @"Chat";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // iPhone
        
        ///*
        livechat = [[HMChatViewController alloc] initWithAppID:APPID andUser:userid];
        livechat.navigationBar.tintColor = [UIColor colorWithRed:145.0/255.0 green:18.0/255.0 blue:0.0 alpha:1];
        livechat.body.title = @"Support Chat";
        livechat.chatView.maxInputLines = 4;
        livechat.chatView.placeholder = @"Start chatting";
        livechat.chatView.placeholderColor = [UIColor grayColor];
        livechat.shouldUseSystemBrowser = FALSE;
        
        livechat.chatView.sentMessageFont = [UIFont systemFontOfSize:10.0];
        livechat.chatView.sentTextColor = [UIColor redColor];
        livechat.chatView.receivedMessageFont = [UIFont systemFontOfSize:12.0];
        livechat.chatView.receivedTextColor = [UIColor purpleColor];
        
        if(currenturl != nil){
            // set the context: this tells the operator what page we're looking at
            [livechat.chatView updateContext:[[currenturl URL] absoluteString]];
        }
        if(token){
            [livechat.chatView setPushToken:token];
        }
        livechat.chatDelegate = self;
        display = YES;
        [self presentModalViewController:livechat animated:YES];
        
        // call back in 5 seconds
        //[self performSelector:@selector(delayedAction) withObject:nil afterDelay:5.0];
    } else {
        if(!display){
            livechatpopover = [[HMChatPopoverController alloc] initWithView:(UIView *)sender andAppID:APPID andUser:userid];
            livechatpopover.content.navigationBar.tintColor = [UIColor colorWithRed:145.0/255.0 green:18.0/255.0 blue:0.0 alpha:1];
            livechatpopover.content.title = @"Support Chat";
            livechatpopover.content.chatView.maxInputLines = 4;
            livechatpopover.content.chatView.placeholder = @"Start chatting";
            livechatpopover.content.chatView.placeholderColor = [UIColor grayColor];
            
            livechatpopover.content.chatView.sentMessageFont = [UIFont systemFontOfSize:10.0];
            livechatpopover.content.chatView.sentTextColor = [UIColor redColor];
            livechatpopover.content.chatView.receivedMessageFont = [UIFont systemFontOfSize:12.0];
            livechatpopover.content.chatView.receivedTextColor = [UIColor purpleColor];

            livechatpopover.content.contentSizeForViewInPopover = CGSizeMake(320, 240);
            livechatpopover.passthroughViews = [[NSArray alloc] initWithObjects:self.view, nil];            
            if(currenturl != nil){
                // set the context: this tells the operator what page we're looking at
                [livechatpopover.content.chatView updateContext:[[currenturl URL] absoluteString]];
            }

            livechatpopover.content.chatDelegate = self;
            if(token){
                [livechatpopover.content.chatView setPushToken:token];
            }
            [livechatpopover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            display = YES;
        }
    }
}
#else
- (IBAction)openChat:(id)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        // iPhone
        
        ///*
        livechat = [[HMChatViewController alloc] initWithAppID:APPID andUser:userid];
        livechat.navigationBar.tintColor = [UIColor colorWithRed:145.0/255.0 green:18.0/255.0 blue:0.0 alpha:1];
        livechat.body.title = @"Support Chat";
        livechat.chatView.maxInputLines = 4;
        livechat.chatView.placeholder = @"Start chatting";
        livechat.chatView.placeholderColor = [UIColor grayColor];
        livechat.shouldUseSystemBrowser = FALSE;
        
        livechat.chatView.sentMessageFont = [UIFont systemFontOfSize:10.0];
        livechat.chatView.sentTextColor = [UIColor redColor];
        livechat.chatView.receivedMessageFont = [UIFont systemFontOfSize:12.0];
        livechat.chatView.receivedTextColor = [UIColor purpleColor];

        if(currenturl != nil){
            // set the context: this tells the operator what page we're looking at
            [livechat.chatView updateContext:[[currenturl URL] absoluteString]];
        }
        if(token){
            [livechat.chatView setPushToken:token];
        }
        livechat.chatDelegate = self;
        display = YES;
        [self presentModalViewController:livechat animated:YES];
        
        // call back in 5 seconds
        //[self performSelector:@selector(delayedAction) withObject:nil afterDelay:5.0];
    } else {
        if(!display){
            livechatpopover = [[HMChatPopoverController alloc] initWithView:(UIView *)sender andAppID:APPID andUser:userid];
            livechatpopover.content.navigationBar.tintColor = [UIColor colorWithRed:145.0/255.0 green:18.0/255.0 blue:0.0 alpha:1];
            livechatpopover.content.title = @"Support Chat";
            livechatpopover.content.chatView.maxInputLines = 4;
            livechatpopover.content.chatView.placeholder = @"Start chatting";
            livechatpopover.content.chatView.placeholderColor = [UIColor grayColor];
            
            livechatpopover.content.chatView.sentMessageFont = [UIFont systemFontOfSize:10.0];
            livechatpopover.content.chatView.sentTextColor = [UIColor redColor];
            livechatpopover.content.chatView.receivedMessageFont = [UIFont systemFontOfSize:12.0];
            livechatpopover.content.chatView.receivedTextColor = [UIColor purpleColor];

            livechatpopover.content.contentSizeForViewInPopover = CGSizeMake(320, 240);
            livechatpopover.passthroughViews = [[[NSArray alloc] initWithObjects:self.view, nil] autorelease];
            
            if(currenturl != nil){
                // set the context: this tells the operator what page we're looking at
                [livechatpopover.content.chatView updateContext:[[currenturl URL] absoluteString]];
            }
            
            livechatpopover.content.chatDelegate = self;
            if(token){
                [livechatpopover.content.chatView setPushToken:token];
            }
            [livechatpopover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            display = YES;
        }
    }
}
#endif

-(void)delayedAction
{
    // send a message using the sendMessage interface
    [livechat.chatView sendMessage:@"This is an automated message"];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    }else{
        return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    }
}

#if !__has_feature(objc_arc)
- (void)dealloc {
    if (currenturl){
        [currenturl release];
        currenturl=nil;
    }
    if(livechat) [livechat release];
    if(livechat2) [livechat2 release];
    if(livechatpopover) [livechatpopover release];
    if(token) [token release];
    if(helpdesk) [helpdesk release];
    if(helpdesk2) [helpdesk2 release];
    if(userid) [userid release];
    [_navBar release];
    [super dealloc];
}
#endif

-(void)stopAnimator{
    [activity stopAnimating];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [activity startAnimating];
    activity.hidden = NO;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activity stopAnimating];
    activity.hidden = YES;
    
    // check to see if we've navigated to a new page, and if we have report the new URL back to the
    // operator so they know what we're looking at.
    if(![[[currenturl URL] absoluteString] isEqualToString:[[webView.request URL] absoluteString]]){
#if __has_feature(objc_arc)
        currenturl = [webView.request copy];
#else
        [currenturl release];
        currenturl = [[webView.request copy] retain];
#endif
        
        if(livechatpopover){
            [livechatpopover.content.chatView updateContext:[NSString stringWithFormat:@"viewing %@ (%@)",
                                                  [webView stringByEvaluatingJavaScriptFromString:@"document.title"],[[currenturl URL] absoluteString]]];
        }else if(livechat){
            [livechat.chatView updateContext:[NSString stringWithFormat:@"viewing %@ (%@)",
                                                             [webView stringByEvaluatingJavaScriptFromString:@"document.title"],[[currenturl URL] absoluteString]]];
        }
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    if(popoverController == livechatpopover){
        display = NO;
        if(livechatpopover){
#if !__has_feature(objc_arc)
            [livechatpopover release];
#endif
            livechatpopover = nil;
        }
    }else if(popoverController == helpdesk2){
        display2 = NO;
        if(helpdesk2){
#if !__has_feature(objc_arc)
            [helpdesk2 release];
#endif
            helpdesk2 = nil;
        }
    }
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return YES;
}

-(void)chatViewControllerWillDismiss:(id)chatViewController
{
    display = NO;
    if(livechatpopover){
        if(livechatpopover.content == chatViewController){
#if !__has_feature(objc_arc)
            [livechatpopover release];
#endif
            livechatpopover = nil;
        }
    }else if(livechat){
        if(livechat == chatViewController){
#if !__has_feature(objc_arc)
            [livechat release];
#endif
            livechat = nil;
        }
    }
}

-(BOOL)chatViewController:(id)chatViewController willHandleURL:(NSString*)url messageId:(NSString*)messageId
{
    // Check if ARC is enabled: if it is, don't bother with the release/retain bits
#if !__has_feature(objc_arc)
    [currenturl release];
#endif
    currenturl = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self gotoURL:nil];
    return YES;
}

- (void)viewDidUnload {
    [self setNavBar:nil];
    [super viewDidUnload];
}

-(BOOL)searchViewController:(id)searchViewController didSelectArticle:(NSString *)id withTitle:(NSString *)title andURL:(NSString *)url andBaseURL:(NSString *)baseURL andContent:(NSString *)content
{
    if(helpdesk) return NO;
    
    NSURL * URL = [NSURL URLWithString:baseURL];
    [mainWebView loadHTMLString:content baseURL:URL];
    return YES;
}

-(void)searchViewController:(id)searchViewController didErrorOccur:(NSString *)error
{
    
}

-(void)searchViewController:(id)searchViewController willOpenChat:(id)chatViewController
{
    HMContentChatViewController * thechat = (HMContentChatViewController *)chatViewController;
    thechat.title = @"Chat with Support";
}

-(void)searchViewControllerWillDismiss:(id)searchViewController
{
    display2 = NO;
    if(helpdesk2){
        if(helpdesk2.content == searchViewController){
#if !__has_feature(objc_arc)
            [helpdesk2 release];
#endif
            helpdesk2 = nil;
        }
    }else if(helpdesk){
        if(helpdesk == searchViewController){
#if !__has_feature(objc_arc)
            [helpdesk release];
#endif
            helpdesk = nil;
        }
    }
}
@end
