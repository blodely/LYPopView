//
//  LYPopDate.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <LYPopView/LYPopView.h>

typedef void (^ didSelectDate)(NSDate *date);

@interface LYPopDate : LYPopView

/**
 message label
 */
@property (nonatomic, weak) UILabel *message;

/**
 date picker
 */
@property (nonatomic, weak) UIDatePicker *picker;

/**
 formatter string
 */
@property (nonatomic, strong) NSString *formatter;

/**
 timezone string
 */
@property (nonatomic, strong) NSString *timezone;

/**
 instance creator

 @param title pop view title
 @param mode date picker mode
 @param formatter date to string formatter
 @param timezone timezone
 @param selectBlock selection block
 */
+ (void)showPopWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)mode stringFormat:(NSString *)formatter timezone:(NSString *)timezone andSelectionBlock:(didSelectDate)selectBlock;

/**
 set selected block

 @param selectBlock action block
 */
- (void)setSelectBlock:(didSelectDate)selectBlock;

@end
