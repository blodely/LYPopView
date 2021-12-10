//
//  LYDatePicker.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2017-07-03.
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

#import "LYDatePicker.h"
#import <LYCategory/LYCategory.h>


@interface LYDatePicker () {
	
	didSelectDate actionSel;
	
//	UIDatePicker *datepicker;
}

@end

@implementation LYDatePicker

// MARK: - INIT

- (void)initial {
	[super initial];
	
	{
		UIDatePicker *view = [[UIDatePicker alloc] init];
		view.translatesAutoresizingMaskIntoConstraints = NO;
		view.datePickerMode = UIDatePickerModeDate;
		if (@available(iOS 13.4, *)) {
			view.preferredDatePickerStyle = UIDatePickerStyleWheels;
		}
		[vCont addSubview:view];
		_datepicker = view;
		
		[view.leftAnchor constraintEqualToAnchor:vCont.leftAnchor].active = YES;
		[view.rightAnchor constraintEqualToAnchor:vCont.rightAnchor].active = YES;
		[view.topAnchor constraintEqualToAnchor:vCont.topAnchor constant:44].active = YES;
		[view.heightAnchor constraintEqualToConstant:(height - 44 - SAFE_BOTTOM)].active = YES;
	}
}

+ (void)showWithSelection:(didSelectDate)actionBlock {
	
	LYDatePicker *picker = [[LYDatePicker alloc] initWithFrame:CGRectZero];
	[picker setSelection:actionBlock];
	[picker show];
}

// MARK: - METHOD

- (void)setSelection:(didSelectDate)actionBlock {
	actionSel = actionBlock;
}

// MARK: - OVERRIDE

- (void)doneInBar:(id)sender {
	
	if (actionSel != nil) {
		actionSel(_datepicker.date);
	}
	
	[super doneInBar:sender];
}

@end
