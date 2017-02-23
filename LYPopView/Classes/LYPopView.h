//
//  LYPopView.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 19/12/2016.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <UIKit/UIKit.h>

@interface LYPopView : UIView {
	
	CGFloat padding;
	CGFloat cornerRadius;
	CGFloat maxHeight;
	
	__weak UIView *vCont;
}

/**
 Pop view title string
 */
@property (nonatomic, strong) NSString *title;

/**
 Pop view auto dismiss
 */
@property (nonatomic, assign) BOOL autoDismiss;

/**
 show pop view instance
 */
- (void)show;

/**
 dismiss pop view instance
 */
- (void)dismiss;

/**
 get configuration data

 @return dictionary data
 */
- (NSDictionary *)configurations;

@end
