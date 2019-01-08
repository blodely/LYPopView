//
//  LYPopDate.h
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
+ (void)showPopWithTitle:(NSString *)title
		  datePickerMode:(UIDatePickerMode)mode
			stringFormat:(NSString *)formatter
				timezone:(NSString *)timezone
	   andSelectionBlock:(didSelectDate)selectBlock;

/**
 set selected block

 @param selectBlock action block
 */
- (void)setSelectBlock:(didSelectDate)selectBlock;

@end
