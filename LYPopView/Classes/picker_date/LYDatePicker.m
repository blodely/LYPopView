//
//  LYDatePicker.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2017-07-03.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "LYDatePicker.h"
#import <LYCategory/LYCategory.h>

@interface LYDatePicker () {
	
	didSelectDate actionSel;
	
//	UIDatePicker *datepicker;
}

@end

@implementation LYDatePicker

/*
// ONLY OVERRIDE drawRect: IF YOU PERFORM CUSTOM DRAWING.
// AN EMPTY IMPLEMENTATION ADVERSELY AFFECTS PERFORMANCE DURING ANIMATION.
- (void)drawRect:(CGRect)rect {
	// DRAWING CODE
}
*/

// MARK: - INIT

- (void)initial {
	[super initial];
	
	UIDatePicker *datepic = [[UIDatePicker alloc] initWithFrame:(CGRect){0, 44, WIDTH, height - 44}];
	[vCont addSubview:datepic];
	_datepicker = datepic;
	datepic.datePickerMode = UIDatePickerModeDate;
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
