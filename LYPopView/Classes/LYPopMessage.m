//
//  LYPopMessage.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYPopMessage.h"
#import "NSBundle+PopView.h"
#import "UIColor+LYPopViewHex.h"

@interface LYPopMessage () {
	
	__weak UILabel *lblMessage;
}

@end

@implementation LYPopMessage

// MARK: - INIT

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		
		NSDictionary *conf = [self configurations];
		NSString *confValue = @"conf-value";
		
		{
			UILabel *labelMessage = [[UILabel alloc] init];
			labelMessage.font = [UIFont systemFontOfSize:15];
			labelMessage.textColor = [UIColor pv_hex:conf[@"popview-message-color"][confValue]];
			labelMessage.textAlignment = NSTextAlignmentCenter;
			labelMessage.frame = (CGRect){padding, 44 + padding, vCont.bounds.size.width - padding * 2, 20};
			[vCont addSubview:labelMessage];
			lblMessage = labelMessage;
		}
	}
	return self;
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
