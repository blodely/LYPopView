//
//  LYPickerView.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2017-06-12.
//  COPYRIGHT © 2016-2018 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import "LYPickerView.h"
#import <LYCategory/LYCategory.h>

@interface LYPickerView () {
	__weak UIControl *cBg;
}
@end

@implementation LYPickerView

// MARK: - ACTION

- (void)cancelInBar:(id)sender {
	[self dismiss];
}

- (void)doneInBar:(id)sender {
	
	[self dismiss];
}

// MARK: - INIT

- (instancetype)initWithFrame:(CGRect)frame {
	frame = (CGRect){0, 0, WIDTH, HEIGHT};
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	{
		height = 216 + 44;
		
		UIControl *ctlBg = [[UIControl alloc] initWithFrame:(CGRect){0, 0, WIDTH, HEIGHT}];
		ctlBg.backgroundColor = [UIColor colorWithHex:@"#000000" andAlpha:0.618];
		[self addSubview:ctlBg];
		cBg = ctlBg;
		
		UIView *viewCont = [[UIView alloc] initWithFrame:(CGRect){0, HEIGHT - height, WIDTH, height}];
		viewCont.backgroundColor = [UIColor whiteColor];
		[ctlBg addSubview:viewCont];
		vCont = viewCont;
		
		UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:(CGRect){8, 0, WIDTH - 16, 44}];
		[viewCont addSubview:toolbar];
		
		UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelInBar:)];
		UIBarButtonItem *itemFlex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
		UIBarButtonItem *itemConfirm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneInBar:)];
		
		[toolbar setItems:@[itemCancel, itemFlex, itemConfirm,]];
	}
}

/*
// ONLY OVERRIDE drawRect: IF YOU PERFORM CUSTOM DRAWING.
// AN EMPTY IMPLEMENTATION ADVERSELY AFFECTS PERFORMANCE DURING ANIMATION.
- (void)drawRect:(CGRect)rect {
	// DRAWING CODE
}
*/

// MARK: - METHOD

- (void)show {
	
	// MASK NEED TO BE SAME SIZE LIKE SCREEN
	self.frame = (CGRect){0, 0, WIDTH, HEIGHT};
	self.hidden = NO;
	self.alpha = 1;
	
	cBg.frame = (CGRect){0, 0, WIDTH, HEIGHT};
	cBg.alpha = 0;
	vCont.frame = (CGRect){0, HEIGHT, WIDTH, height};
	
	// ADD TO WINDOW
	if ([self superview] == nil) {
		[[UIApplication sharedApplication].keyWindow addSubview:self];
	}
	
	// ANIMATION OUT
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self->cBg.alpha = 1;
		self->vCont.frame = (CGRect){0, HEIGHT - self->height, WIDTH, self->height};
	} completion:^(BOOL finished) {
		
	}];
}

- (void)dismiss {
	[UIView animateWithDuration:0.25 delay:0	 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self->vCont.frame = (CGRect){0, HEIGHT, WIDTH, self->height};
		self->cBg.backgroundColor = [UIColor clearColor];
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
}

@end
