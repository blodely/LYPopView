//
//  LYPopDate.m
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

#import "LYPopDate.h"
#import <LYCategory/LYCategory.h>
#import "NSBundle+PopView.h"

@interface LYPopDate () {
	__weak UIButton *btnCancel;
	__weak UIButton *btnConfirm;
	didSelectDate selectionBlock;
	NSTimer *repeat;
}

@end

@implementation LYPopDate

// MARK: - ACTION

- (void)cancelBtnPressed:(UIButton *)button {
	[repeat invalidate];
	repeat = nil;
	[self dismiss];
}

- (void)confirmBtnPressed:(UIButton *)button {
	// DONE: SELECTION
	[repeat invalidate];
	repeat = nil;
	selectionBlock(_picker.date);
	[self dismiss];
}

// MARK: - INIT

+ (void)showPopWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)mode stringFormat:(NSString *)formatter timezone:(NSString *)timezone andSelectionBlock:(didSelectDate)selectBlock {
	LYPopDate *datepop = [[LYPopDate alloc] init];//[[LYPopDate alloc] initWithTitle:aTitle datePickerMode:aMode andSelectionBlock:selectBlock];
	datepop.title = title;
	datepop.picker.datePickerMode = mode;
	datepop.formatter = formatter;
	datepop.timezone = timezone;
	[datepop setSelectBlock:selectBlock];
	[datepop show];
}

- (void)initial {
	[super initial];
	
	NSDictionary *conf = [self configurations];
	NSString *confValue = @"conf-value";
	CGRect frame = self.frame;
	
	{
		UILabel *labelDate = [[UILabel alloc] init];
		labelDate.frame = (CGRect){10, 0, frame.size.width - 10, 44};
		labelDate.font = [UIFont systemFontOfSize:15];
		labelDate.textColor = [UIColor blackColor];
		labelDate.textAlignment = NSTextAlignmentLeft;
		[vCont addSubview:labelDate];
		_message = labelDate;
	}
	
	{
		UIDatePicker *datepicker = [[UIDatePicker alloc] init];
		datepicker.frame = (CGRect){0, 44, frame.size.width, 216};
		[vCont addSubview:datepicker];
		_picker = datepicker;
		_message.text = [datepicker.date stringWithFormat:_formatter andTimezone:_timezone];
	}
	
	{
		UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
		[buttonCancel setBackgroundColor:[UIColor colorWithHex:conf[@"popview-theme-color"][confValue] andAlpha:1.0]];
		[buttonCancel addTarget:self action:@selector(cancelBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
		[buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
		[vCont addSubview:buttonCancel];
		btnCancel = buttonCancel;
	}
	
	{
		UIButton *buttonConfirm = [UIButton buttonWithType:UIButtonTypeCustom];
		[buttonConfirm setBackgroundColor:[UIColor colorWithHex:conf[@"popview-theme-color"][confValue] andAlpha:1.0]];
		[buttonConfirm addTarget:self action:@selector(confirmBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
		[buttonConfirm setTitle:@"确认" forState:UIControlStateNormal];
		[vCont addSubview:buttonConfirm];
		btnConfirm = buttonConfirm;
	}
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// MARK: - METHOD

- (void)setSelectBlock:(didSelectDate)selectBlock {
	selectionBlock = selectBlock;
}

// MARK: | PRIVATE METHOD

- (void)setupLabel {
	
	if ([_formatter isKindOfClass:[NSString class]] && _formatter.length > 0 && [_timezone isKindOfClass:[NSString class]] && _timezone.length > 0 && [[NSTimeZone knownTimeZoneNames] containsObject:_timezone]) {
		_message.text = [_picker.date stringWithFormat:_formatter andTimezone:_timezone];
	}
	
}

// MARK: - PROPERTY

- (void)setTimezone:(NSString *)timezone {
	_timezone = timezone;
	
	// SET TIMEZONE IF IT'S VALID
	if (_timezone != nil && [_timezone isKindOfClass:[NSString class]] && [[NSTimeZone knownTimeZoneNames] containsObject:_timezone]) {
		_picker.timeZone = [NSTimeZone timeZoneWithName:_timezone];
	} else {
		// SET DEFAULT
		_picker.timeZone = [NSTimeZone systemTimeZone];
	}
	
}

// MARK: - OVERRIDE

- (void)resetBounds {
	
	CGFloat verticalOffset = 44;
	
	CGRect rect = vCont.bounds;
	
	_message.frame = (CGRect){padding, verticalOffset, rect.size.width - padding, 44};
	
	_picker.frame = (CGRect){0, verticalOffset + _message.bounds.size.height, rect.size.width, 216};
	
	btnCancel.frame = (CGRect){0, verticalOffset + _message.bounds.size.height + _picker.bounds.size.height, rect.size.width / 2, 44};
	btnConfirm.frame = (CGRect){rect.size.width / 2, verticalOffset + _message.bounds.size.height + _picker.bounds.size.height, rect.size.width / 2, 44};
	
	rect = vCont.frame;
	rect.size.height = 44 + _message.bounds.size.height + _picker.bounds.size.height + btnConfirm.bounds.size.height;
	vCont.frame = rect;
	
	if (repeat == nil || [repeat isValid] == NO) {
//		repeat = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//			[self setupLabel];
//		}];
		repeat = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setupLabel) userInfo:nil repeats:YES];
	}
}

@end
