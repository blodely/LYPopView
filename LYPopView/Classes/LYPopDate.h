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
@property (nonatomic, weak) UIDatePicker *picker;

@property (nonatomic, strong) NSString *formatter;
@property (nonatomic, strong) NSString *timezone;

+ (void)showPopWithTitle:(NSString *)title datePickerMode:(UIDatePickerMode)mode stringFormat:(NSString *)formatter timezone:(NSString *)timezone andSelectionBlock:(didSelectDate)selectBlock;

- (void)setSelectBlock:(didSelectDate)selectBlock;

@end
