//
//  TestViewController.m
//  hipmobtest
//
//  Created by Olufemi Omojola on 9/24/12.
//  Copyright (c) 2012 Orthogonal Labs, Inc. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
{
    UIWebView * mainWebView;
    UIActivityIndicatorView * activity;
    // tracks the current URL being displayed
    NSURLRequest * currenturl;
    NSData * token;
}
@end

@implementation TestViewController
-(void)setToken:(NSData *)data
{
    token = [data retain];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _navBar.topItem.title = @"Support Chat Demo";
	// Do any additional setup after loading the view, typically from a nib.
    display= NO;
    activity = (UIActivityIndicatorView *)[self.view viewWithTag:201];
    mainWebView = (UIWebView *)[self.view viewWithTag:200];
    mainWebView.delegate=self;
    currenturl = [[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://web.mit.edu"]] retain];
    [self gotoURL:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [HMChatView checkOperatorAvailabilityForApp:@"2ea7d86854df4ca185af84e68ea72fe1" andNotify:self];
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

- (IBAction)openChat:(id)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // iPhone
        
        ///*
        livechat = [[HMChatViewController alloc] initWithAppID:@"2ea7d86854df4ca185af84e68ea72fe1" andUser:nil];
        livechat.navigationBar.tintColor = [UIColor colorWithRed:145.0/255.0 green:18.0/255.0 blue:0.0 alpha:1];
        livechat.body.title = @"Support Chat";
        livechat.chatView.maxInputLines = 4;
        livechat.chatView.placeholder = @"Start chatting";
        livechat.chatView.placeholderColor = [UIColor grayColor];
        livechat.shouldUseSystemBrowser = FALSE;
        
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
        // */
        /*
        livechat2 = [[HMContentChatViewController alloc] initWithAppID:@"2ea7d86854df4ca185af84e68ea72fe1" andUser:nil];
        livechat2.title = @"Support Chat";
        livechat2.chatView.maxInputLines = 4;
        livechat2.chatView.placeholder = @"How can we help?";
        livechat2.chatView.placeholderColor = [UIColor grayColor];
        livechat2.shouldUseSystemBrowser = FALSE;
        [self presentModalViewController:livechat2 animated:YES];
        // */
    } else {
        if(!display){
            livechatpopover = [[HMChatPopoverController alloc] initWithView:(UIView *)sender andAppID:@"2ea7d86854df4ca185af84e68ea72fe1" andUser:nil];
            livechatpopover.content.navigationBar.tintColor = [UIColor colorWithRed:145.0/255.0 green:18.0/255.0 blue:0.0 alpha:1];
            livechatpopover.content.title = @"Support Chat";
            livechatpopover.content.chatView.maxInputLines = 4;
            livechatpopover.content.chatView.placeholder = @"Start chatting";
            livechatpopover.content.chatView.placeholderColor = [UIColor grayColor];
            livechatpopover.content.contentSizeForViewInPopover = CGSizeMake(320, 240);
            livechatpopover.passthroughViews = [[[NSArray alloc] initWithObjects:self.view, nil] autorelease];
            
            if(currenturl != nil){
                // set the context: this tells the operator what page we're looking at
                [livechatpopover.content.chatView updateContext:[[currenturl URL] absoluteString]];
            }

            /*
            [livechatpopover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
             */
            livechatpopover.content.chatDelegate = self;
            if(token){
                [livechatpopover.content.chatView setPushToken:token];
            }
            [livechatpopover presentPopoverFromBarButtonItem:(UIBarButtonItem *)sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            display = YES;
        }
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return NO;
    }else{
        return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
    }
}

- (void)dealloc {
    if (currenturl){
        [currenturl release];
        currenturl=nil;
    }
    if(livechat) [livechat release];
    if(livechat2) [livechat2 release];
    if(livechatpopover) [livechatpopover release];
    if(token) [token release];
    [_navBar release];
    [super dealloc];
}

-(void)stopAnimator{
    [activity stopAnimating];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [activity startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [activity stopAnimating];
    
    // check to see if we've navigated to a new page, and if we have report the new URL back to the
    // operator so they know what we're looking at.
    if(![[[currenturl URL] absoluteString] isEqualToString:[[webView.request URL] absoluteString]]){
        [currenturl release];
        currenturl = [[webView.request copy] retain];
        
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
    display = NO;
    if(livechatpopover){
        [livechatpopover release];
        livechatpopover = nil;
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
            [livechatpopover release];
            livechatpopover = nil;
        }
    }else if(livechat){
        if(livechat == chatViewController){
            [livechat release];
            livechat = nil;
        }
    }
}

-(BOOL)chatViewController:(id)chatViewController willHandleURL:(NSString*)url messageId:(NSString*)messageId
{
    [currenturl release];
    currenturl = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self gotoURL:nil];
    return YES;
}
- (void)viewDidUnload {
    [self setNavBar:nil];
    [super viewDidUnload];
}
@end
