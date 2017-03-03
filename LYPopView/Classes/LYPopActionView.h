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

//@property (nonatomic, strong) NSArray *buttons;

- (void)setSingleButtonTitle:(NSString *)title andAction:(void (^)(void))pressedAction;

- (void)setDoubleButtonBtnZeroTitle:(NSString *)titleZero action:(void (^)(void))btnZeroAction andBtnOneTitle:(NSString *)titleOne action:(void (^)(void))btnOneAction;

@end
