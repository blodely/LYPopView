//
//  LYDatePicker.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2017-07-03.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <LYPopView/LYPickerView.h>

typedef void (^ didSelectDate)(NSDate *date);

@interface LYDatePicker : LYPickerView

/**
 datepicker instance
 */
@property (nonatomic, weak) UIDatePicker *datepicker;

/**
 set selection action block

 @param actionBlock action block
 */
- (void)setSelection:(didSelectDate)actionBlock;

/**
 show an instance date picker view with action block setter

 @param actionBlock action block
 */
+ (void)showWithSelection:(didSelectDate)actionBlock;

@end
