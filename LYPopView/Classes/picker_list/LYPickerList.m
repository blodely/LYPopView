//
//  LYPickerList.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2018-08-21.
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

#import "LYPickerList.h"
#import <LYCategory/LYCategory.h>


typedef void(^donePickListBlock)(NSDictionary *item, NSUInteger index);

@interface LYPickerList () <UIPickerViewDelegate, UIPickerViewDataSource> {
	
	__weak UIPickerView *picker;
	
	NSUInteger selected;
	
	donePickListBlock donePickBlock;
}
@end

@implementation LYPickerList


// MARK: - ACTION

- (void)doneInBar:(id)sender {
	// OVERRIDE
	
	if (_datasource == nil || [_datasource count] == 0 || selected >= [_datasource count] || donePickBlock == nil) {
		[self dismiss];
		return;
	}
	
	donePickBlock(_datasource[selected], selected);
	[self dismiss];
}

// MARK: - INIT

- (void)initial {
	[super initial];
	
	{
		selected = 0;
		_font = [UIFont systemFontOfSize:14];
	}
	
	{
		UIPickerView *view = [[UIPickerView alloc] init];
		view.translatesAutoresizingMaskIntoConstraints = NO;
		view.delegate = self;
		view.dataSource = self;
		[vCont addSubview:view];
		picker = view;
		
		[view.topAnchor constraintEqualToAnchor:vCont.topAnchor constant:44].active = YES;
		[view.leftAnchor constraintEqualToAnchor:vCont.leftAnchor].active = YES;
		[view.rightAnchor constraintEqualToAnchor:vCont.rightAnchor].active = YES;
		[view.heightAnchor constraintEqualToConstant:(height - 44 - SAFE_BOTTOM)].active = YES;
	}
}

// MARK: - METHOD

- (void)setDonePickAction:(void (^)(NSDictionary *, NSUInteger))doneAction {
	donePickBlock = doneAction;
}

// MARK: - PROPERTY

- (void)setDatasource:(NSArray *)datasource {
	
	if (datasource == nil || [datasource isKindOfClass:[NSArray class]] == NO || [datasource count] == 0) {
		_datasource = nil;
		return;
	}
	
	_datasource = datasource;
	
	[picker reloadAllComponents];
	selected = 0;
	[picker selectRow:0 inComponent:0 animated:NO];
}

- (void)setKeyTitle:(NSString *)keyTitle {
	
	if (keyTitle == nil || [keyTitle isEqualToString:@""]) {
		_keyTitle = nil;
		return;
	}
	
	_keyTitle = keyTitle;
	
	[picker reloadAllComponents];
	selected = 0;
	[picker selectRow:0 inComponent:0 animated:NO];
}

- (void)setFont:(UIFont *)font {
	
	if (font == nil || [font isKindOfClass:[UIFont class]] == NO) {
		_font = [UIFont systemFontOfSize:14];
	} else {
		_font = font;
	}
	
	if (_datasource == nil || _keyTitle == nil || [_datasource count] == 0 || [_keyTitle isEqualToString:@""]) {
		return;
	}
	
	[picker reloadAllComponents];
	selected = 0;
	[picker selectRow:0 inComponent:0 animated:0];
}

// MARK: - DELEGATE

// MARK: UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	selected = row;
}

// MARK: UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [_datasource count];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	NSString *title;
	if (_keyTitle == nil) {
		title = @"";
	} else {
		title = _datasource[row][_keyTitle];
	}
	
	return [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:_font}];
}

@end
