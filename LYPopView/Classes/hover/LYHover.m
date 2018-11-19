//
//  LYHover.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2018-11-19.
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

#import "LYHover.h"
#import <LYCategory/LYCategory.h>
#import <Masonry/Masonry.h>



@implementation LYHover

// MARK: - ACTION

- (void)backgroundTapped:(id)sender {
	[self endEditing:YES];
	
	[self dismiss];
}

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
	
	// MARK: SELF
	self.backgroundColor = [UIColor clearColor];
	[self addTarget:self action:@selector(backgroundTapped:) forControlEvents:UIControlEventTouchDown];
	
	{
		// MARK: CONTAINER VIEW
		UIView *view = [[UIView alloc] init];
		[self addSubview:view];
		vCont = view;
		
		view.backgroundColor = [UIColor whiteColor];
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.equalTo(self);
			if (@available(iOS 11.0, *)) {
				make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom);
			} else {
				make.bottom.equalTo(self);
			}
			make.height.mas_greaterThanOrEqualTo(216);
		}];
	}
	
	if (@available(iOS 11.0, *)){
		// MARK: FOOTER
		UIView *view = [[UIView alloc] init];
		[self addSubview:view];
		view.backgroundColor = vCont.backgroundColor;
		view.userInteractionEnabled = NO;
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self->vCont.mas_bottom);
			make.leading.trailing.equalTo(self->vCont);
			make.bottom.equalTo(self);
		}];
	}
}

+ (instancetype)view {
	return [[[self class] alloc] initWithFrame:CGRectZero];
}

- (void)setFrame:(CGRect)frame {
	frame.origin = CGPointZero;
	frame.size = [UIScreen mainScreen].bounds.size;
	[super setFrame:frame];
}

// MARK: - METHOD

- (void)show {
	
	self.alpha = 0;
	CGPoint ct = vCont.center;
	ct.y = HEIGHT + vCont.bounds.size.height * 0.5;
	vCont.center = (CGPoint){ct.x, HEIGHT + vCont.bounds.size.height * 0.5};
	
	if ([self superview] == nil) {
		[[UIApplication sharedApplication].keyWindow addSubview:self];
	}
	
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self.alpha = 1;
		self->vCont.center = ct;
	} completion:^(BOOL finished) {
		
	}];
}

- (void)dismiss {
	CGPoint ct = vCont.center;
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self.alpha = 0;
		self->vCont.center = (CGPoint){ct.x, HEIGHT + self->vCont.bounds.size.height * 0.5};
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
}

// MARK: PROPERTIES

- (void)setBackground:(BOOL)background {
	_background = background;
	
	self.backgroundColor = _background ? [UIColor colorWithWhite:0 alpha:0.618] : [UIColor clearColor];
}

@end
