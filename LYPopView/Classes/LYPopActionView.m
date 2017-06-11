//
//  LYPopActionView.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 03/03/2017.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYPopActionView.h"
#import <LYCategory/LYCategory.h>

typedef void(^ buttonActionBlock)(void);

@interface LYPopActionView () {
	
	buttonActionBlock blockSingleIdxZero;
	buttonActionBlock blockDoubleIdxZero;
	buttonActionBlock blockDoubleIdxOne;
	
	__weak UIButton *btnSingleIdxZero;
	__weak UIButton *btnDoubleIdxZero;
	__weak UIButton *btnDoubleIdxOne;
}

@end

@implementation LYPopActionView

// MARK: - ACTION

- (void)buttonSingleIdxZeroAction:(UIButton *)button {
	blockSingleIdxZero();
	[self dismiss];
}

- (void)buttonDoubleIdxZeroAction:(UIButton *)button {
	blockDoubleIdxZero();
	[self dismiss];
}

- (void)buttonDoubleIdxOneAction:(UIButton *)button {
	blockDoubleIdxOne();
	[self dismiss];
}

// MARK: - INIT

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		
		[self initialPopAction];
	}
	return self;
}

- (void)initialPopAction {
	
	NSDictionary *conf = [self configurations];
	NSString *confValue = @"conf-value";
	
	{
		UIView *viewContent = [[UIView alloc] init];
		viewContent.frame = (CGRect){0, 44, vCont.bounds.size.width, vCont.bounds.size.height - 88};
		[vCont addSubview:viewContent];
		vActionCont = viewContent;
	}
	
	{
		// SINGLE BUTTON
		UIButton *buttonZero = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonZero.frame = (CGRect){0, vCont.bounds.size.height - 44, vCont.bounds.size.width, 44};
		buttonZero.hidden = YES;
		[buttonZero setBackgroundColor:[UIColor colorWithHex:conf[@"popview-theme-color"][confValue] andAlpha:1.0]];
		[buttonZero addTarget:self action:@selector(buttonSingleIdxZeroAction:) forControlEvents:UIControlEventTouchUpInside];
		[vCont addSubview:buttonZero];
		btnSingleIdxZero = buttonZero;
	}
	
	{
		// TWO BUTTONS
		UIButton *buttonZero = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonZero.frame = (CGRect){0, vCont.bounds.size.height - 44, vCont.bounds.size.width / 2 - (1/[UIScreen mainScreen].scale), 44};
		buttonZero.hidden = YES;
		[buttonZero setBackgroundColor:[UIColor colorWithHex:conf[@"popview-theme-color"][confValue] andAlpha:1.0]];
		[buttonZero addTarget:self action:@selector(buttonDoubleIdxZeroAction:) forControlEvents:UIControlEventTouchUpInside];
		[vCont addSubview:buttonZero];
		btnDoubleIdxZero = buttonZero;
		
		UIButton *buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonOne.frame = (CGRect){vCont.bounds.size.width / 2, vCont.bounds.size.height - 44, vCont.bounds.size.width / 2, 44};
		buttonOne.hidden = YES;
		[buttonOne setBackgroundColor:[UIColor colorWithHex:conf[@"popview-theme-color"][confValue] andAlpha:1.0]];
		[buttonOne addTarget:self action:@selector(buttonDoubleIdxOneAction:) forControlEvents:UIControlEventTouchUpInside];
		[vCont addSubview:buttonOne];
		btnDoubleIdxOne = buttonOne;
	}
}

/*
// ONLY OVERRIDE drawRect: IF YOU PERFORM CUSTOM DRAWING.
// AN EMPTY IMPLEMENTATION ADVERSELY AFFECTS PERFORMANCE DURING ANIMATION.
- (void)drawRect:(CGRect)rect {
	// DRAWING CODE
}
*/

// MARK: - PROPERTY

// MARK: - METHOD

- (void)setSingleButtonTitle:(NSString *)title andAction:(void (^)(void))pressedAction {
	
	// BUTTON VISIBILITY
	btnSingleIdxZero.hidden = NO;
	btnDoubleIdxZero.hidden = btnDoubleIdxOne.hidden = YES;
	
	// BUTTON TITLE
	[btnSingleIdxZero setTitle:title forState:UIControlStateNormal];
	
	// ACTION BLOCK
	blockSingleIdxZero = pressedAction;
}

- (void)setDoubleButtonBtnZeroTitle:(NSString *)titleZero action:(void (^)(void))btnZeroAction andBtnOneTitle:(NSString *)titleOne action:(void (^)(void))btnOneAction {
	
	// BUTTON VISIBILITY
	btnSingleIdxZero.hidden = YES;
	btnDoubleIdxZero.hidden = btnDoubleIdxOne.hidden = NO;
	
	// BUTTON TITLES
	[btnDoubleIdxZero setTitle:titleZero forState:UIControlStateNormal];
	[btnDoubleIdxOne setTitle:titleOne forState:UIControlStateNormal];
	
	// ACTION BLOCKS
	blockDoubleIdxZero = btnZeroAction;
	blockDoubleIdxOne = btnOneAction;
}

@end
