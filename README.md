hipmob-ios-support-chat
=======================

iOS Support Chat Demonstration


**Quick Start**:

1. Download the Hipmob iOS Framework. This includes all the dependencies required (see the Framework Options section for more details).
2. Expand the downloaded archive, and then copy the Hipmob framework folder into your project by dragging the hipmob.framework directory into your Xcode project. Make sure you select the "Copy items into destination group's folder (if needed)" option. Once you have done this, open your build phases (under your project's Build Settings screen) and add the resources from inside the framework into the Copy Bundle Resources section: click the Add Other option at the bottom, then add all the Hipmob image resources (from inside the hipmob.framework folder).
3. Include the HMChatViewController.h header file wherever you'll be launching a chat.

        #include <hipmob/HMChatViewController.h>

4. then create the controller and present it. You'll need to use your Hipmob application ID [Get it by signing up here](https://manage.hipmob.com/register). For example, if the application ID was "3e059479fc6e4437a4e955d56081bc73" (which you can use without signing up - it's a live demo):

        // initialize it with the appropriate app identifier, taken from the Hipmob console at https://manage.hipmob.com/#apps  
        HMChatViewController * livechat = [[HMChatViewController alloc] initWithAppID:@"3e059479fc6e4437a4e955d56081bc73" andUser:nil];  
 
        // the HMChatViewController is a UINavigationController, so we have access to all the navigation controller fields  
        // adjust the navigation bar's tint color to match the applications color  
        livechat.navigationBar.tintColor = [UIColor colorWithRed:145.0/255.0 green:18.0/255.0 blue:0.0 alpha:1];  
 
        // set the title of the chat window  
        livechat.body.title = @"Support Chat";  
 
        // make sure the input text field doesn't expand more than 4 lines  
        livechat.chatView.maxInputLines = 4;  
 
        // set the placeholder text shown in the input text field and the color to use  
        livechat.chatView.placeholder = @"Start chatting";  
        livechat.chatView.placeholderColor = [UIColor grayColor];  
 
        // make sure any URLs pushed open up in a   
        livechat.shouldUseSystemBrowser = FALSE;  
 
        // set the context: this tells the operator who the user is and what action the user was taking  
        [livechat.chatView updateName:@"User's Name"];  
        [livechat.chatView updateEmail:@"user@example.com"];  
        [livechat.chatView updateContext:@"Trying to reserve a hotel in Chicago"];  
 
        // set a push token (if you have one saved: this allows Hipmob to send chat messages from the operator even when   
        // the user is offline)  
        if(token){  
        [livechat.chatView setPushToken:token];  
        }  
        livechat.chatDelegate = self;  
 
        // and present  
        [self presentModalViewController:livechat animated:YES];


7. You're complete. Build your app.

[See the full documentation here](http://hipmob.com/documentation/ios.html)
