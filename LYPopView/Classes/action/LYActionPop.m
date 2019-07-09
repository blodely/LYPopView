//
//	LYActionPop.m
//	LYPOPVIEW
//
//	CREATED BY LUO YU ON 2019/07/09.
//	COPYRIGHT © 2016-2019 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
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

#import "LYActionPop.h"
#import <LYCategory/LYCategory.h>
#import <Masonry/Masonry.h>
#import <LYPopView/LYPopViewBlockButton.h>


@interface LYActionPop () {
	__weak UIView *vPaddingBottom;
	__weak UIButton *btnCancel;
	__weak UIView *vCont;
	
	CGFloat padding;
	CGFloat heightItem;
	
	LYCCompletion blockCancel;
}
@end

@implementation LYActionPop

// MARK: - ACTION

- (void)cancelButtonPressed:(id)sender {
	if (blockCancel != nil) {
		blockCancel();
	}
	
	[self dismiss];
}

// MARK: - INIT

- (instancetype)init {
	if (self = [super init]) {
		[self initial];
	}
	return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
	frame.origin = CGPointZero;
	frame.size.width = WIDTH;
	frame.size.height = HEIGHT;
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	{
		self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
		padding = 10;
		heightItem = 55;
	}
	
	{
		// MARK: BOTTOM PADDING
		UIView *view = [[UIView alloc] init];
		view.userInteractionEnabled = NO;
		view.backgroundColor = [UIColor clearColor];
		[self addSubview:view];
		vPaddingBottom = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.equalTo(self);
			make.bottom.equalTo(self);
			if (@available(iOS 11.0, *)) {
				make.top.equalTo(self.mas_safeAreaLayoutGuideBottom).offset(-self->padding * 2);
			} else {
				make.top.equalTo(self.mas_bottom).offset(-self->padding * 2);
			}
		}];
	}
	
	{
		// MARK: CANCEL BUTTON
		UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
		[view roundedCornerRadius:padding];
		view.backgroundColor = [UIColor whiteColor];
		[view setTitleColor:self.tintColor forState:UIControlStateNormal];
		view.titleLabel.font = [UIFont systemFontOfSize:20];
		[view setTitle:@"Cancel" forState:UIControlStateNormal];
		[self addSubview:view];
		btnCancel = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.equalTo(self).offset(self->padding);
			make.right.equalTo(self).offset(-self->padding);
			make.bottom.equalTo(self->vPaddingBottom.mas_top);
			make.height.mas_equalTo(self->heightItem);
		}];
		
		[btnCancel addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	{
		// MARK: BUTTONS CONTAINER
		UIView *view = [[UIView alloc] init];
		view.backgroundColor = [UIColor whiteColor];
		[view roundedCornerRadius:padding];
		[self addSubview:view];
		vCont = view;
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.equalTo(self->btnCancel.mas_top).offset(-self->padding);
			make.leading.trailing.equalTo(self->btnCancel);
			make.height.mas_equalTo(self->heightItem);
		}];
	}
}

+ (instancetype)pop {
	return [[[self class] alloc] initWithFrame:CGRectZero];
}

// MARK: - METHOD

- (void)show {
	self.hidden = YES;
	self.alpha = 0;
	
	if ([self superview] == nil) {
		[[UIApplication sharedApplication].keyWindow addSubview:self];
	}
	
	[[self superview] bringSubviewToFront:self];
	self.hidden = NO;
	
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.alpha = 1;
	} completion:^(BOOL finished) {
	}];
}

- (void)dismiss {
	self.alpha = 1;
	
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
		self.alpha = 0;
	} completion:^(BOOL finished) {
		self.hidden = YES;
		[self removeFromSuperview];
	}];
}

// MARK: BUTTONS

- (void)cancelTitle:(NSString *)cancelTitle action:(void (^)(void))action {
	blockCancel = action;
	
	if (cancelTitle == nil || [cancelTitle isKindOfClass:[NSString class]] == NO || [cancelTitle isEqualToString:@""]) {
		// BY DEFAULT
		[btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
	} else {
		[btnCancel setTitle:cancelTitle forState:UIControlStateNormal];
	}
}

- (void)addButtonWithTitle:(NSString *)buttonTitle andAction:(void (^)(void))action {
	
	NSInteger previous = [[vCont subviews] count];
	
	{
		// MARK: ADD BUTTON
		LYPopViewBlockButton *view = [LYPopViewBlockButton buttonWithType:UIButtonTypeCustom];
		[view setTitleColor:self.tintColor forState:UIControlStateNormal];
		view.titleLabel.font = [UIFont systemFontOfSize:20];
		[view setTitle:buttonTitle forState:UIControlStateNormal];
		[vCont addSubview:view];
		
		[view mas_makeConstraints:^(MASConstraintMaker *make) {
			make.left.right.equalTo(self->vCont);
			make.height.mas_equalTo(self->heightItem);
			make.bottom.equalTo(self->vCont.mas_bottom).offset(-previous * self->heightItem);
		}];
		
		[view handleEvent:UIControlEventTouchUpInside withAction:^{
			if (action != nil) {
				action();
			}
			
			[self dismiss];
		}];
		
		{
			if (previous > 0) {
				UIView *line = [[UIView alloc] init];
				line.backgroundColor = [UIColor groupTableViewBackgroundColor];
				line.userInteractionEnabled = NO;
				[vCont addSubview:line];
				[line mas_makeConstraints:^(MASConstraintMaker *make) {
					make.left.right.equalTo(self->vCont);
					make.bottom.equalTo(view);
					make.height.mas_equalTo(1 / SCALE);
				}];
			}
		}
	}
	
	[vCont mas_updateConstraints:^(MASConstraintMaker *make) {
		make.height.mas_equalTo((previous + 1) * self->heightItem);
	}];
}

@end
