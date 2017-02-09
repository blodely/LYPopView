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

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BOOL autoDismiss;

- (void)show;

- (void)dismiss;

- (NSDictionary *)configurations;

@end
