//
//  LYDropDownSection.m
//  LYPopView
//
//  CREATED BY LUO YU ON 2018-07-30.
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

#import "LYDropDownSection.h"

@interface LYDropDownSection () <UITableViewDelegate, UITableViewDataSource> {
	
	__weak UITableView *tbMenu;
}
@end

@implementation LYDropDownSection

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// MARK: - INIT

- (instancetype)initWithFrame:(CGRect)frame {
	
	// LOCK WIDTH
	frame.size.width = [UIScreen mainScreen].bounds.size.width;
	
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	{
		// MENU VIEW
		UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		tableview.delegate = self;
		tableview.dataSource = self;
		[tableview registerClass:[LYDropDownSectionCell class] forCellReuseIdentifier:LYDropDownSectionCellIdentifier];
		[self addSubview:tableview];
		tbMenu = tableview;
	}
}

// MARK: - METHOD

// MARK: PRIVATE METHOD

// MARK: - DELEGATE

// MARK: UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)idp {
	[tableView deselectRowAtIndexPath:idp animated:YES];
}

// MARK: UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)idp {
	LYDropDownSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:LYDropDownSectionCellIdentifier forIndexPath:idp];
	return cell;
}

// MARK: - OVERRIDE

- (NSString *)description {
	return [NSString stringWithFormat:@"%@", NSStringFromClass([self class])];
}

@end

NSString *const LYDropDownSectionCellIdentifier = @"LYDropDownSectionCellIdentifier";

@interface LYDropDownSectionCell () {
	__weak UIView *vBar;
}
@end

@implementation LYDropDownSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		CGSize size = self.bounds.size;
		
		{
			UILabel *label = [[UILabel alloc] init];
			label.frame = (CGRect){0, 0, size.width, size.height};
			label.textAlignment = NSTextAlignmentCenter;
			label.numberOfLines = 0;
			label.font = [UIFont systemFontOfSize:14];
			label.clipsToBounds = YES;
			label.textColor = [UIColor blackColor];
			[self addSubview:label];
			_lblTitle = label;
		}
		
		{
			UIView *bar = [[UIView alloc] init];
			bar.frame = (CGRect){0, 0, 10, size.height};
			bar.userInteractionEnabled = NO;
			bar.clipsToBounds = YES;
			[self addSubview:bar];
		}
		
	}
	return self;
}

@end

NSString *const LYDropDownSectionItemCellIdentifier = @"LYDropDownSectionItemCellIdentifier";

@implementation LYDropDownSectionItemCell

@end
