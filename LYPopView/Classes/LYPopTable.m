//
//  LYPopTable.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
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
