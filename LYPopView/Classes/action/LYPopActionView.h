//
//  LYPopActionView.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 03/03/2017.
//  COPYRIGHT © 2016-2018 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
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

@interface LYPopActionView : LYPopView {
	
	__weak UIView *vActionCont;
}

- (void)initial;

/**
 action pop view with one button at bottom

 @param title button title
 @param pressedAction button action block on event touch up inside
 */
- (void)setSingleButtonTitle:(NSString *)title andAction:(void (^)(void))pressedAction;

/**
 action pop view with two buttons at bottom

 @param titleZero button0's title
 @param btnZeroAction button0 action block on event touch up inside
 @param titleOne button1's title
 @param btnOneAction button1 action block on event touch up inside
 */
- (void)setDoubleButtonBtnZeroTitle:(NSString *)titleZero action:(void (^)(void))btnZeroAction andBtnOneTitle:(NSString *)titleOne action:(void (^)(void))btnOneAction;

@end
