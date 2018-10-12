//
//  LYDropDown.m
//  LYPopView
//
//  CREATED BY LUO YU ON 2018-05-02.
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

#import "LYDropDown.h"
#import "LYDropDownCell.h"
#import "LYPopView.h"
#import <LYCategory/LYCategory.h>

typedef void(^ dropdownActionBlock)(NSUInteger index, NSString *title);

@interface LYDropDown () <UITableViewDelegate, UITableViewDataSource> {
	
	__weak UIControl *cBg;
	
	__weak UITableView *tbMenu;
	
	UIColor *themeColor;
	
	NSMutableArray *menuBlocks;
	NSMutableArray *menu;
}
@end

@implementation LYDropDown

#pragma mark - ACTION

- (void)backgroundTapped:(id)sender {
//	NSLog(@"CANCEL SELECTION");
	[self dismiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - INIT

+ (LYDropDown *)menu {
	return [[LYDropDown alloc] initWithFrame:(CGRect){0, 0, 44, 44}]; // WITH MINIMAL SIZE
}

- (instancetype)initWithFrame:(CGRect)frame {
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
		menu = [NSMutableArray arrayWithCapacity:1];
		menuBlocks = [NSMutableArray arrayWithCapacity:1];
		
		themeColor = [UIColor colorWithHex:[[[LYPopView alloc] init] configurations][@"popview-menu-sel-color"][@"conf-value"] andAlpha:1.0];
		self.tintColor = themeColor;
		
		self.clipsToBounds = YES;
		self.hidden = YES;
	}
	
	{
		UIControl *ctlBg = [[UIControl alloc] init];
		ctlBg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
		ctlBg.alpha = 0;
		[self addSubview:ctlBg];
		cBg = ctlBg;
		[cBg addTarget:self action:@selector(backgroundTapped:) forControlEvents:UIControlEventTouchDown];
		[cBg addTarget:self action:@selector(backgroundTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	{
		UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		table.frame = (CGRect){0, 0, self.bounds.size.width, 0};
		table.delegate = self;
		table.dataSource = self;
		table.separatorStyle = UITableViewCellSeparatorStyleNone;
		[self addSubview:table];
		tbMenu = table;
		
		[tbMenu registerClass:[LYDropDownCell class] forCellReuseIdentifier:LYDropDownCellIdentifier];
//		[tbMenu registerNib:[UINib nibWithNibName:@"LYDropDownCell" bundle:[NSBundle bundleWithIdentifier:LIB_POPVIEW_BUNDLE_ID]] forCellReuseIdentifier:LYDropDownCellIdentifier];
	}
	
	
}

- (void)setFrame:(CGRect)frame {
	frame.size.width = [UIScreen mainScreen].bounds.size.width;
	[super setFrame:frame];
	
	cBg.frame = (CGRect){CGPointZero, frame.size};
	tbMenu.frame = (CGRect){0, 0, WIDTH, 0};
}

#pragma mark - METHOD

- (void)showFrom:(CGRect)rect {
	
	if ([self superview] == nil) {
		NSLog(@"❎ERROR: NOT ADDED TO ANY VIEW");
		return;
	}
	
	if (self.hidden == NO) {
		[self dismiss];
		return;
	}
	
	
	
	self.hidden = NO;
	cBg.alpha = 0;
	self.frame = (CGRect){0, CGRectGetMaxY(rect), WIDTH, HEIGHT - CGRectGetMaxY(rect)};
	tbMenu.frame = (CGRect){0, 0, WIDTH, 0};
	
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self->cBg.alpha = 1;
		self->tbMenu.frame = (CGRect){0, 0, WIDTH, MIN([self->menu count] * 44, HEIGHT - CGRectGetMaxY(rect))};
	} completion:^(BOOL finished) {
		
	}];
}

- (void)addItemTitle:(NSString *)title action:(void (^)(NSUInteger, NSString *))itemAction {
	if (title == nil || itemAction == nil) {
		NSLog(@"❎ERROR: CANNOT ADD NIL OBJECT");
		return;
	}
	
	[menu addObject:title];
	[menuBlocks addObject:itemAction];
	
	[tbMenu reloadData];
}

- (void)dismiss {
	[UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self->cBg.alpha = 0;
		self->tbMenu.frame = (CGRect){0, 0, WIDTH, 0};
	} completion:^(BOOL finished) {
		self.hidden = YES;
	}];
}

- (void)selectItemAtIndex:(NSUInteger)index {
	
	if (index < [menu count]) {
		[tbMenu selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
	} else {
		NSLog(@"LYDropDown Error:\n\tIndex %@ .. [0~%@]", @(index), @([menu count]));
	}
}

#pragma mark PRIVATE METHOD

#pragma mark - DELEGATE

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)idp {
	
	// KEEP SELECTION
	
	dropdownActionBlock actionBlock = menuBlocks[idp.row];
	actionBlock(idp.row, menu[idp.row]);
	
	[self dismiss];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)idp {
	
	LYDropDownCell *cell = [tableView dequeueReusableCellWithIdentifier:LYDropDownCellIdentifier forIndexPath:idp];
	cell.tintColor = themeColor;
	cell.lblTitle.text = menu[idp.row];
	return cell;
}

@end
