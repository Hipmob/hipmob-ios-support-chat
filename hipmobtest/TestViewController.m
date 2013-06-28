//
//  TestViewController.m
//  hipmobtest
//
//  Created by Olufemi Omojola on 9/24/12.
//  Copyright (c) 2012 Orthogonal Labs, Inc. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    display=FALSE;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        livechat = [[HMChatViewController alloc] initWithAppID:@"2ea7d86854df4ca185af84e68ea72fe1" andUser:nil];
        livechat.body.title = @"Support Chat";
        livechat.chatView.maxInputLines = 4;
        
        /*
        ipadchat.service.username=@"The iPad";
        ipadchat.service.localWebView=FALSE;
         */
        //supportchat.service.delegate=self;
    }else{
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openChat:(id)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // iPhone
        livechat = [[HMChatViewController alloc] initWithAppID:@"2ea7d86854df4ca185af84e68ea72fe1" andUser:nil];
        livechat.navigationBar.tintColor = [UIColor colorWithRed:145.0/255.0 green:18.0/255.0 blue:0.0 alpha:1];
        livechat.body.title = @"Support Chat";
        livechat.chatView.maxInputLines = 4;
        livechat.chatView.placeholder = @"Start chatting";
        livechat.chatView.placeholderColor = [UIColor grayColor];

        /*
        iphonechat.localWebView = FALSE;
        //livechat.delegate = self;
         */
        [self presentModalViewController:livechat animated:YES];
    } else {
        // iPad
        //livechat.view.frame =
        //ipadchat.view.frame = CGRectMake(self.view.frame.size.height - 345, 50, 320, 240);
        //[self.view addSubview:ipadchat.view];
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
    if(livechat) [livechat release];
    [super dealloc];
}
@end
