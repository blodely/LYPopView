//
//  LYDropDownCell.m
//  LYPopView
//
//  CREATED BY LUO YU ON 2018-06-27.
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

#import "LYDropDownCell.h"
#import "LYPopView.h"
#import "NSBundle+PopView.h"
#import <LYCategory/LYCategory.h>


NSString *const LYDropDownCellIdentifier = @"LYDropDownCellIdentifier";

@interface LYDropDownCell () {}
@end

@implementation LYDropDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
	// INITIALIZATION CODE
	
	_ivStatus.tintColor = self.tintColor;
	self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setTintColor:(UIColor *)tintColor {
	[super setTintColor:tintColor];
	
	_ivStatus.tintColor = tintColor;
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	
	[self setStyle:selected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

	// CONFIGURE THE VIEW FOR THE SELECTED STATE
	
	[self setStyle:selected];
}

- (void)setStyle:(BOOL)selected {
	
	if (selected) {
		_ivStatus.image = [[UIImage imageNamed:@"selected-white" inBundle:[NSBundle popResourceBundle] compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		_lblTitle.textColor = self.tintColor;
	} else {
		_ivStatus.image = nil;
		_lblTitle.textColor = [UIColor blackColor];
	}
}

@end
