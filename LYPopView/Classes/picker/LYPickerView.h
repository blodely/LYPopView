//
//  LYPickerView.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2017-06-12.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

@interface LYPickerView : UIView {
	
	CGFloat height;
	
	__weak UIView *vCont;
}


/**
 initial method
 */
- (void)initial;

/**
 button action

 @param sender sender button
 */
- (void)doneInBar:(id)sender;

/**
 display picker view
 */
- (void)show;

/**
 dismiss picker view
 */
- (void)dismiss;

@end
