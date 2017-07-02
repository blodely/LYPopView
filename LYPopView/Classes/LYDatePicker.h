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

- (void)setSelection:(didSelectDate)actionBlock;

+ (void)showWithSelection:(didSelectDate)actionBlock;

@end
