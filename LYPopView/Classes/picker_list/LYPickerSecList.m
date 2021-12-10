//
//  LYPickerSecList.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2018-08-24.
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

#import "LYPickerSecList.h"
#import <LYCategory/LYCategory.h>


typedef void(^donePickSecListBlock)(NSDictionary *item, NSIndexPath *idp);

@interface LYPickerSecList () <UIPickerViewDelegate, UIPickerViewDataSource> {
	
	__weak UIPickerView *picker;
	
	NSUInteger selSec;
	NSUInteger selRow;
	
	donePickSecListBlock donePickBlock;
}
@end

@implementation LYPickerSecList

// MARK: - ACTION

- (void)doneInBar:(id)sender {
	// OVERRIDE
	
	if (_datasource == nil || [_datasource count] == 0 ||
		_keyArray == nil || [_keyArray isEqualToString:@""] ||
		selSec >= [_datasource count] || selRow >= [_datasource[selSec][_keyArray] count] ||
		donePickBlock == nil) {
		[self dismiss];
		return;
	}
	
	donePickBlock(_datasource[selSec][_keyArray][selRow], [NSIndexPath indexPathForRow:selRow inSection:selSec]);
	[self dismiss];
}

// MARK: - INIT

- (void)initial {
	[super initial];
	
	{
		// MARK: INITIAL VALUES
		selSec = 0;
		selRow = 0;
	}
	
	{
		UIPickerView *view = [[UIPickerView alloc] init];
		view.translatesAutoresizingMaskIntoConstraints = NO;
		[vCont addSubview:view];
		picker = view;
		
		[view.topAnchor constraintEqualToAnchor:vCont.topAnchor constant:44].active = YES;
		[view.leftAnchor constraintEqualToAnchor:vCont.leftAnchor].active = YES;
		[view.rightAnchor constraintEqualToAnchor:vCont.rightAnchor].active = YES;
		[view.heightAnchor constraintEqualToConstant:(height - 44 - SAFE_BOTTOM)].active = YES;
		
		picker.delegate = self;
		picker.dataSource = self;
	}
}

// MARK: - METHOD

- (void)setDonePickAction:(void (^)(NSDictionary *, NSIndexPath *))doneAction {
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
	selSec = 0;
	selRow = 0;
	[picker selectRow:0 inComponent:0 animated:NO];
}

- (void)setKeyTitle:(NSString *)keyTitle {
	if (keyTitle == nil || [keyTitle isEqualToString:@""]) {
		_keyTitle = nil;
		return;
	}
	
	_keyTitle = keyTitle;
	[picker reloadAllComponents];
}

- (void)setKeyArray:(NSString *)keyArray {
	if (keyArray == nil || [keyArray isEqualToString:@""]) {
		_keyArray = nil;
		return;
	}
	
	_keyArray = keyArray;
	[picker reloadAllComponents];
}

// MARK: - DELEGATE

// MARK: UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if (_keyTitle == nil || _keyArray == nil) {
		return @"";
	}
	
	NSString *title = @"";
	if (component == 0) {
		title = _datasource[row][_keyTitle];
	} else if (component == 1) {
		title = _datasource[selSec][_keyArray][row][_keyTitle];
	}
	return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	if (component == 0) {
		selSec = row;
		[pickerView reloadComponent:1];
	} else if (component == 1) {
		selRow = row;
	}
	
}

// MARK: UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSInteger rows = 0;
	if (component == 0) {
		rows = [_datasource count];
	} else if (component == 1) {
		rows = [_datasource[selSec][_keyArray] count];
	}
	return rows;
}

@end
