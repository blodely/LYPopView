//
//  LYPopTable.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
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

#import "LYPopTable.h"
#import <LYCategory/UIColor+Speed.h>

NSString *const LYPopTableDataTitle = @"ly.pop.table.title";

@interface LYPopTable () {
	
}

@end

@implementation LYPopTable

- (instancetype)init {
	if (self = [super init]) {
		
		{
			UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
			table.frame = (CGRect){0, 44, vCont.bounds.size.width, vCont.bounds.size.height};
			table.separatorStyle = UITableViewCellSeparatorStyleNone;
			[vCont addSubview:table];
			_tbMenu = table;
		}
	}
	return self;
}

// MARK: - PROPERTY

// MARK: - METHOD

// MARK: | PRIVATE METHOD

// MARK: - OVERRIDE

/*
// ONLY OVERRIDE drawRect: IF YOU PERFORM CUSTOM DRAWING.
// AN EMPTY IMPLEMENTATION ADVERSELY AFFECTS PERFORMANCE DURING ANIMATION.
- (void)drawRect:(CGRect)rect {
	// DRAWING CODE
}
*/

- (void)show {
	
	[_tbMenu reloadData];
	
	[super show];
}

- (void)resetBounds {
	
	// TABLE VIEW ITEM COUNT
	NSInteger counts = 0;
	
	// GET SECTION COUNT
	NSInteger sections = 1;
	if ([_tbMenu.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
		sections = [_tbMenu.dataSource numberOfSectionsInTableView:_tbMenu];
	}
	
	for (int i = 0; i < sections; i++) {
		NSInteger rows = 0;
		if ([_tbMenu.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
			rows = [_tbMenu.dataSource tableView:_tbMenu numberOfRowsInSection:i];
		}
		counts = counts + rows;
	}
	
	CGFloat cellHeight = 44; // CONFIGURABLE
	
	CGRect rect = vCont.frame;
	rect.size.height = MIN(cellHeight * counts + 44, maxHeight);
	vCont.frame = rect;
}

// MARK: - DELEGATE

// MARK: | UITableViewDelegate

// MARK: | UITableViewDataSource

@end

// MARK: - CELL

NSString *const LYPopTableCellIdentifier = @"LYPopTableCellIdentifier";

@interface LYPopTableCell () {}
@end

@implementation LYPopTableCell

- (void)awakeFromNib {
	[super awakeFromNib];

	self.selectionStyle = UITableViewCellSelectionStyleNone;
	_ivIcon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
}

@end
