//
//  LYPopView.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 19/12/2016.
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

#import "LYPopView.h"
#import "PopView.h"
#import "NSBundle+PopView.h"
#import <LYCategory/LYCategory.h>
#import "FCFileManager.h"

NSString *const LIB_POPVIEW_BUNDLE_ID = @"org.cocoapods.LYPopView";
NSString *const NAME_CONF_POPVIEW = @"conf-pop-view-style";

@interface LYPopView () {
	
	__weak UIControl *cBg;
	
	__weak UIView *vTitle;
	__weak UILabel *lblTitle;
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
	self.clipsToBounds = YES;
	
	NSDictionary *conf = [self configurations];
	NSString *confValue = @"conf-value";
	
	CGSize screen = [UIScreen mainScreen].bounds.size;
	padding = [conf[@"popview-padding"][confValue] integerValue];
	cornerRadius = [conf[@"popview-corner-radius"][confValue] integerValue];
	
	{
		UIControl *ctrlBg = [[UIControl alloc] init];
		ctrlBg.frame = (CGRect){0, 0, screen.width, screen.height};
		ctrlBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
		[ctrlBg addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchDown];
		[self addSubview:ctrlBg];
		cBg = ctrlBg;
	}
	
	{
		UIView *viewCont = [[UIView alloc] init];
		viewCont.backgroundColor = [UIColor colorWithHex:conf[@"popview-window-bg-color"][confValue] andAlpha:1.0];
		viewCont.clipsToBounds = YES;
		CGFloat width = screen.width - padding * 2;
		maxHeight = width / 0.7;
		viewCont.frame = (CGRect){padding, (screen.height - maxHeight) / 2, width, maxHeight};
		viewCont.layer.masksToBounds = YES;
		viewCont.layer.cornerRadius = cornerRadius;
		[self addSubview:viewCont];
		vCont = viewCont;
	}
	
	{
		CGFloat width = vCont.bounds.size.width;
		
		UIView *viewTitle = [[UIView alloc] init];
		viewTitle.frame = (CGRect){0, 0, width, 44};
		viewTitle.backgroundColor = [UIColor colorWithHex:conf[@"popview-theme-color"][confValue] andAlpha:1.0];
		[vCont addSubview:viewTitle];
		vTitle = viewTitle;
		
		UILabel *labelTitle = [[UILabel alloc] init];
		labelTitle.frame = (CGRect){10, 0, width - 20, 44};
		labelTitle.textColor = [UIColor colorWithHex:conf[@"popview-title-color"][confValue] andAlpha:1.0];
		labelTitle.textAlignment = NSTextAlignmentCenter;
		labelTitle.font = [UIFont systemFontOfSize:16];
		[viewTitle addSubview:labelTitle];
		lblTitle = labelTitle;
		
		UIButton *buttonClose = [UIButton buttonWithType:UIButtonTypeCustom];
		buttonClose.frame = (CGRect){width - 44, 0, 44, 44};
		[buttonClose setBackgroundImage:[[UIImage imageNamed:@"cross-48-gs" inBundle:[NSBundle popResourceBundle] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
		[buttonClose setTintColor:[UIColor colorWithHex:conf[@"popview-title-color"][confValue] andAlpha:1.0]];
		[buttonClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
		[viewTitle addSubview:buttonClose];
	}
}

// MARK: - PROPERTY

- (void)setTitle:(NSString *)title {
	_title = title;
	
	lblTitle.text = _title;
}

// MARK: - METHOD

- (void)show {
	
	self.hidden = NO;
	cBg.alpha = 0;
	CGPoint center = vCont.center;
	center.y = vCont.bounds.size.height / 2 + [UIScreen mainScreen].bounds.size.height;
	vCont.center = center;
	
	if ([self superview] == nil) {
		// SUPER VIEW = WINDOW
		[[UIApplication sharedApplication].keyWindow addSubview:self];
	}
	
	center.y = self.bounds.size.height / 2;
	
	// CALL BOUND ADJUST METHOD
	[self resetBounds];
	
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self->cBg.alpha = 1;
		self->vCont.center = center;
	} completion:^(BOOL finished) {
		
	}];
}

- (NSDictionary *)configurations {
	
	NSString *confpath;
	
	confpath = [[NSBundle mainBundle] pathForResource:NAME_CONF_POPVIEW ofType:@"plist"];
	
	if (confpath == nil || [confpath isEqualToString:@""] == YES || [FCFileManager isFileItemAtPath:confpath] == NO) {
		NSLog(@"LYPopView WARNING\n\tAPP CONFIGURATION FILE WAS NOT FOUND.\n\t%@", confpath);
		
		// FALLBACK TO LIB DEFAULT
		confpath = [[NSBundle bundleWithIdentifier:LIB_POPVIEW_BUNDLE_ID] pathForResource:NAME_CONF_POPVIEW ofType:@"plist"];
	}
	
	NSDictionary *conf = [FCFileManager readFileAtPathAsDictionary:confpath];
	
	if (conf == nil) {
		NSLog(@"LYPopView ERROR\n\tCONFIGURATION FILE WAS NEVER FOUND.");
	}
	
	return conf;
}

// MARK: | PRIVATE METHOD

- (void)resetBounds {
}

- (void)dismiss {
	
	CGPoint center = vCont.center;
	center.y = - vCont.bounds.size.height / 2;
	
	// ANIMATE OUT
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		
		self->cBg.alpha = 0;
		self->vCont.center = center;
		
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
