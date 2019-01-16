//
//  LYPopView.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 19/12/2016.
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

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const LIB_POPVIEW_BUNDLE_ID;

// MARK: - LYPopBaseView
@interface LYPopBaseView : UIView {
	CGFloat padding;
	CGFloat cornerRadius;
	CGFloat maxHeight;
	
	__weak UIView *vCont;
	__weak UIControl *cBg;
}

/**
 Pop view auto dismiss
 */
@property (nonatomic, assign) BOOL autoDismiss;

/**
 get instance

 @return instance
 */
+ (instancetype)pop;

/**
 default initial method to build view structure.
 */
- (void)initial;

/**
 show pop view instance
 */
- (void)show;

/**
 dismiss pop view instance
 */
- (void)dismiss;

/**
 get configuration data
 
 @return dictionary data
 */
- (NSDictionary *)configurations;

@end

// MARK: - LYPopView
@interface LYPopView : LYPopBaseView {
	__weak UIView *vTitle;
	__weak UILabel *lblTitle;
	__weak UIButton *btnClose;
}

/**
 Pop view title string
 */
@property (nonatomic, strong) NSString *title;

@end

#import <LYPopView/LYPopMessage.h>
#import <LYPopView/LYPopTable.h>
#import <LYPopView/LYPopDate.h>
#import <LYPopView/LYPopActionView.h>
#import <LYPopView/LYPopImagePickerAction.h>

#import <LYPopView/LYPickerView.h>
#import <LYPopView/LYDatePicker.h>
#import <LYPopView/LYPickerList.h>
#import <LYPopView/LYPickerSecList.h>

#import <LYPopView/LYPopImage.h>

#import <LYPopView/LYHover.h>
#import <LYPopView/LYPrivacyPop.h>

#import <LYPopView/LYDropDown.h>
#import <LYPopView/LYDropDownCell.h>
#import <LYPopView/LYDropDownSection.h>
