//
//  LYPopActionView.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 03/03/2017.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <LYPopView/LYPopView.h>

@interface LYPopActionView : LYPopView {
	
	__weak UIView *vActionCont;
}

/**
 action pop view with one button at bottom

 @param title button title
 @param pressedAction button action block on event touch up inside
 */
- (void)setSingleButtonTitle:(NSString *)title andAction:(void (^)(void))pressedAction;

/**
 action pop view with two buttons at bottom

 @param titleZero button0's title
 @param btnZeroAction button0 action block on event touch up inside
 @param titleOne button1's title
 @param btnOneAction button1 action block on event touch up inside
 */
- (void)setDoubleButtonBtnZeroTitle:(NSString *)titleZero action:(void (^)(void))btnZeroAction andBtnOneTitle:(NSString *)titleOne action:(void (^)(void))btnOneAction;

@end
