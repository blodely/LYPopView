//
//  LYPopMessage.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYPopMessage.h"
#import "UIColor+LYPopViewHex.h"

@interface LYPopMessage () {
	
	__weak UILabel *lblMessage;
}

@end

@implementation LYPopMessage

// MARK: - INIT

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	{
		UILabel *labelMessage = [[UILabel alloc] init];
		labelMessage.font = [UIFont systemFontOfSize:15];
		labelMessage.textColor = [UIColor blackColor];
		labelMessage.textAlignment = NSTextAlignmentCenter;
		[vCont addSubview:labelMessage];
		lblMessage = labelMessage;
	}
}

// MARK: - PROPERTY

- (void)setMessage:(NSString *)message {
	_message = message;
	
}

// MARK: - METHOD

// MARK: | PRIVATE METHOD

// MARK: - OVERRIDE

/*
// ONLY OVERRIDE drawRect: IF YOU PERFORM CUSTOM DRAWING.
// AN EMPTY IMPLEMENTATION ADVERSELY AFFECTS PERFORMANCE DURING ANIMATION.
- (void)drawRect:(CGRect)rect {
	// DRAWING CODE
}
*/

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
}

// MARK: - DELEGATE

// MARK: |

@end
