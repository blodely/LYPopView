//
//	LYActionPop.h
//	LYPOPVIEW
//
//	CREATED BY LUO YU ON 2019/07/09.
//	COPYRIGHT © 2016-2019 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
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

#import <UIKit/UIKit.h>


@interface LYActionPop : UIControl

@property (nonatomic, assign) BOOL backgroundDismiss;

/**
 initial method call
 */
- (void)initial;

/**
 instance getter

 @return object instance
 */
+ (instancetype)pop;

/**
 show pop.
 */
- (void)show;

/**
 dismiss pop.
 */
- (void)dismiss;

/**
 set cancel button title and action block

 @param cancelTitle title string
 @param action cancel callback action
 */
- (void)cancelTitle:(NSString *)cancelTitle action:(void (^)(void))action;

- (void)addButtonWithTitle:(NSString *)buttonTitle andAction:(void (^)(void))action;

@end
