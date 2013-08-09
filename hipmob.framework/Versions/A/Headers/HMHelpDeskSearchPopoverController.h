//
//  HMHelpDeskSearchPopoverController.h
//  hipmob
//
//  Created by Olufemi Omojola on 08/06/2013.
//  Copyright (c) 2012 - 2013 Orthogonal Labs, Inc.
//
#ifndef _hipmob_hmhelpdesksearchpopovercontroller_h_
#define _hipmob_hmhelpdesksearchpopovercontroller_h_

#import <UIKit/UIKit.h>
#import "HMHelpDeskSearchViewController.h"

/**
 * Default popover frame for landscape orientation.
 */
#define HMHDSDefaultPopoverFrameLandscape  CGRectMake(830, 20, 20, 20)

/**
 * Default popover frame for portrait orientation.
 */
#define HMHDSDefaultPopoverFramePortrait   CGRectMake(590, 20, 20, 20)

/**
 * Default popover size.
 */
#define HMHDSDefaultPopoverSize            CGSizeMake(260, 280)

/**
 * Provides a popover controller for use in tablet displays.
 */
@interface HMHelpDeskSearchPopoverController : UIPopoverController
{
    HMHelpDeskSearchViewController * content;
}
/**
 * Returns the HMHelpDeskSearchViewController instance that provides the content controller for this popover.
 */
@property (readonly, nonatomic, retain) HMHelpDeskSearchViewController * content;

/**
 * Sets/returns whether or not to display this popover in portrait mode.
 */
@property (nonatomic, assign) BOOL portrait;

/**
 * Sets/returns whether or not to display this popover in landscape mode.
 */
@property (nonatomic, assign) BOOL landscape;

///------------------------------------------------------------------------------------------
/// @name Initialization
///------------------------------------------------------------------------------------------
/** Initializes the HMHelpDeskSearchPopoverController object to connect with a specific Hipmob app identifier. This
 * will control which help desk the search runs through.
 *
 * The application identifier can be obtained from https://manage.hipmob.com/#apps and will
 * let the Hipmob network identify the specific help desk you wish to searches to be run against.
 * Typically there will be one application identifier for each app.
 *
 * @param view The view to attach the popover to.
 * @param app The Hipmob application identifier for this app.
 */
-(id) initWithView:(UIView *)view andAppID:(NSString *)app;

/** Initializes the HMHelpDeskSearchPopoverController object to connect with a specific Hipmob app identifier. This
 * will control which help desk the search runs through.
 *
 * The application identifier can be obtained from https://manage.hipmob.com/#apps and will
 * let the Hipmob network identify the specific help desk you wish to searches to be run against.
 * Typically there will be one application identifier for each app. If this method is used then a check
 * will be made to see if any operators are online for the specified Hipmob app: if there are operators
 * available then a chat button will also be shown.
 *
 * @param view The view to attach the popover to.
 * @param app The Hipmob application identifier for this app.
 * @param user The user identifier for this user. Can be set to nil to use an internally generated id.
 * @param info Additional connection information to be provided to the connection. Acceptable keys are {name},
 * {email}, {context} and {pushtoken}.
 */
-(id) initWithView:(UIView *)view andAppID:(NSString *)app andUser:(NSString *)user andInfo:(NSDictionary *)userInfo;

///------------------------------------------------------------------------------------------
/// @name Position and Size
///------------------------------------------------------------------------------------------
/** Sets the position of the popover when displayed in portrait mode. Use this if the popover is not being displayed by a UIButtonBarItem.
 *
 * @param newPortrait The new position for the popover in portrait mode.
 */
-(void) setPortraitPosition:(CGRect)newPortrait;

/** Sets the position of the popover when displayed in landscape mode. Use this if the popover is not being displayed by a UIButtonBarItem.
 *
 * @param newLandscape The new position for the popover in landscape mode.
 */
-(void) setLandscapePosition:(CGRect)newLandscape;

///------------------------------------------------------------------------------------------
/// @name Display Control
///------------------------------------------------------------------------------------------
/**
 * Shows the popover.
 */
-(void) show;

/**
 * Hides the popover. The parent controller should release the HMHelpDeskSearchPopoverController instance: it can not be shown again.
 */
-(void) dismiss;
@end
#endif
