//
//  LYPopView.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 19/12/2016.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYPopView.h"

@interface LYPopView () {
	
	__weak UIControl *cBg;
}

@end

@implementation LYPopView

// MARK: - INIT

- (instancetype)initWithFrame:(CGRect)frame {
	frame.origin = CGPointZero;
	frame.size = [UIScreen mainScreen].bounds.size;
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	self.backgroundColor = [UIColor clearColor];
	
	CGSize screen = [UIScreen mainScreen].bounds.size;
	
	UIControl *ctrlBg = [[UIControl alloc] init];
	ctrlBg.frame = (CGRect){0, 0, screen.width, screen.height};
	ctrlBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
	[ctrlBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:ctrlBg];
	cBg = ctrlBg;
}

// MARK: - METHOD

- (void)show {
	
	self.hidden = NO;
	cBg.alpha = 0;
	
	if ([self superview] == nil) {
		// SUPER VIEW = WINDOW
		[[UIApplication sharedApplication].keyWindow addSubview:self];
	}
	
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		cBg.alpha = 1;
	} completion:^(BOOL finished) {
		
	}];
}

// MARK: | PRIVATE METHOD

- (void)dismiss {
	
	// ANIMATE OUT
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		
		cBg.alpha = 0;
		
	} completion:^(BOOL finished) {
		
		// REMOVE SELF
		[self removeFromSuperview];
	}];
}
	
// MARK: - OVERRIDE

/*
// ONLY OVERRIDE drawRect: IF YOU PERFORM CUSTOM DRAWING.
// AN EMPTY IMPLEMENTATION ADVERSELY AFFECTS PERFORMANCE DURING ANIMATION.
- (void)drawRect:(CGRect)rect {
	// DRAWING CODE
}
*/

- (void)setFrame:(CGRect)frame {
	frame = [UIScreen mainScreen].bounds;
	[super setFrame:frame];
}

// MARK: - DELEGATE

@end
