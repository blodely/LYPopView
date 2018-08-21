//
//  LYPickerList.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2018-08-21.
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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
	
	{
		selected = 0;
	}
	
	{
		UIPickerView *pickerview = [[UIPickerView alloc] init];
		pickerview.delegate = self;
		pickerview.dataSource = self;
		[vCont addSubview:pickerview];
		picker = pickerview;
		
		picker.frame = (CGRect){0, 44, vCont.bounds.size.width, vCont.bounds.size.height - 44};
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	if (_keyTitle == nil) {
		return @"";
	}
	
	return _datasource[row][_keyTitle];
}

@end
