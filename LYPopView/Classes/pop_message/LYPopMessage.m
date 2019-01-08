//
//  LYPopMessage.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016-2019 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
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

#import "LYPopMessage.h"
#import "NSBundle+PopView.h"
#import <LYCategory/UIColor+Speed.h>

@interface LYPopMessage () {
	
	__weak UILabel *lblMessage;
}

@end

@implementation LYPopMessage

// MARK: - INIT

- (void)initial {
	[super initial];
	
	NSDictionary *conf = [self configurations];
	NSString *confValue = @"conf-value";
	
	{
		UILabel *labelMessage = [[UILabel alloc] init];
		labelMessage.font = [UIFont systemFontOfSize:15];
		labelMessage.textColor = [UIColor colorWithHex:conf[@"popview-message-color"][confValue] andAlpha:1.0];
		labelMessage.textAlignment = NSTextAlignmentCenter;
		labelMessage.frame = (CGRect){padding, 44 + padding, vCont.bounds.size.width - padding * 2, 20};
		[vCont addSubview:labelMessage];
		lblMessage = labelMessage;
	}
}

+ (void)showPopWithTitle:(NSString *)aTitle andMessage:(NSString *)aMessage {
	LYPopMessage *msgpop = [[LYPopMessage alloc] init];
	msgpop.title = aTitle;
	msgpop.message = aMessage;
//	msgpop.autoDismiss = YES;
	[msgpop show];
}

// MARK: - PROPERTY

- (void)setMessage:(NSString *)message {
	
	if (message == nil) {
		_message = @" ";
		lblMessage.text = @" ";
		[self resetBounds];
		return;
	}
	
	// TYPE SAFE
	_message = [NSString stringWithFormat:@"%@", message];
	
	// SET MESSAGE
	lblMessage.text = _message;
	
	// RESET SIZE
	[self resetBounds];
}

// MARK: - METHOD

//- (void)show {
//	
//	[self resetBounds];
//	
//	[super show];
//}

// MARK: | PRIVATE METHOD

- (void)resetBounds {
	
	if (lblMessage == nil) {
		return;
	}
	
	CGFloat width = vCont.bounds.size.width - padding * 2;
	CGFloat height = ceil([[[NSAttributedString alloc] initWithString:_message attributes:@{NSFontAttributeName:lblMessage.font,}] boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height);
	
	CGRect rect = vCont.frame;
	rect.size.height = 44 + (padding * 2) + height + 44;
	vCont.frame = rect;
	
	rect = lblMessage.frame;
	rect.size.height = height;
	lblMessage.frame = rect;
	
}

// MARK: - OVERRIDE

/*
// ONLY OVERRIDE drawRect: IF YOU PERFORM CUSTOM DRAWING.
// AN EMPTY IMPLEMENTATION ADVERSELY AFFECTS PERFORMANCE DURING ANIMATION.
- (void)drawRect:(CGRect)rect {
	// DRAWING CODE
}
*/

// MARK: - DELEGATE

// MARK: |

@end
