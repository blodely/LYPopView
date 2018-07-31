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
#import "LYPopView.h"
#import <LYCategory/LYCategory.h>

// MARK: - LYDropDownItem

@implementation LYDropDownItem

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self) {
		self.title = [coder decodeObjectForKey:@"self.title"];
		self.subtitle = [coder decodeObjectForKey:@"self.subtitle"];
		self.section = [coder decodeInt64ForKey:@"self.section"];
		self.idx = [coder decodeInt64ForKey:@"self.idx"];
	}

	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.title forKey:@"self.title"];
	[coder encodeObject:self.subtitle forKey:@"self.subtitle"];
	[coder encodeInt64:self.section forKey:@"self.section"];
	[coder encodeInt64:self.idx forKey:@"self.idx"];
}


- (id)copyWithZone:(NSZone *)zone {
	LYDropDownItem *copy = (LYDropDownItem *)[[[self class] allocWithZone:zone] init];
	if (copy != nil) {
		copy.title = self.title;
		copy.subtitle = self.subtitle;
		copy.idx = self.idx;
		copy.section = self.section;
	}
	return copy;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"\nLYDropDownItem\n\tTitle\t%@\n\tsubtitle\t%@\n\tSection %@ Idx %@\n",
			_title, _subtitle, @(_section), @(_idx)];
}

@end

// MARK: - LYDropDownSectionItem

@implementation LYDropDownSectionItem

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super init];
	if (self) {
		self.title = [coder decodeObjectForKey:@"self.title"];
		self.subtitle = [coder decodeObjectForKey:@"self.subtitle"];
		self.items = [coder decodeObjectForKey:@"self.items"];
		self.section = [coder decodeInt64ForKey:@"self.section"];
	}

	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.title forKey:@"self.title"];
	[coder encodeObject:self.subtitle forKey:@"self.subtitle"];
	[coder encodeObject:self.items forKey:@"self.items"];
	[coder encodeInt64:self.section forKey:@"self.section"];
}

- (id)copyWithZone:(nullable NSZone *)zone {
	LYDropDownSectionItem *copy = (LYDropDownSectionItem *)[[[self class] allocWithZone:zone] init];

	if (copy != nil) {
		copy.title = self.title;
		copy.subtitle = self.subtitle;
		copy.items = self.items;
		copy.section = self.section;
	}

	return copy;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"\nLYDropDownSectionItem\n\tTitle\t%@\n\tSubtitle\t%@\n", _title, _subtitle];
}

@end

// MARK: - LYDropDownSection

typedef void(^LYDropDownSectionSelectAction)(NSIndexPath *idp);

@interface LYDropDownSection () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
	
	__weak UIControl *cBg;
	
	__weak UITableView *tbMenu;
	__weak UICollectionView *cvItem;
	
	NSUInteger selection;
	LYDropDownSectionSelectAction selectBlock;
	
	UIColor *themeColor;
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
		selection = 0;
		
		themeColor = [UIColor colorWithHex:[[[LYPopView alloc] init] configurations][@"popview-theme-color"][@"conf-value"] andAlpha:1.0];
		self.tintColor = themeColor;
		
		self.clipsToBounds = YES;
		self.hidden = YES;
	}
	
	{
		// BACKGROUND
		UIControl *control = [[UIControl alloc] init];
		control.backgroundColor = [UIColor colorWithHex:@"#000000" andAlpha:0.5f];
		[self addSubview:control];
		cBg = control;
	}
	
	{
		// MENU VIEW
		UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
		tableview.delegate = self;
		tableview.dataSource = self;
		tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
		[tableview registerClass:[LYDropDownSectionCell class] forCellReuseIdentifier:LYDropDownSectionCellIdentifier];
		[self addSubview:tableview];
		tbMenu = tableview;
	}
	
	{
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		layout.minimumLineSpacing = 8;
		layout.minimumInteritemSpacing = 8;
		layout.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8); // top left bottom right
		
		UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
		collectionview.delegate = self;
		collectionview.dataSource = self;
		collectionview.backgroundColor = [UIColor whiteColor];
		[collectionview registerClass:[LYDropDownSectionItemCell class] forCellWithReuseIdentifier:LYDropDownSectionItemCellIdentifier];
		[self addSubview:collectionview];
		cvItem = collectionview;
	}
}

+ (instancetype)menu {
	return [[LYDropDownSection alloc] initWithFrame:(CGRect){0, 0, 44, 44}];
}

- (void)setFrame:(CGRect)frame {
	frame.origin.x = 0;
	frame.size.width = WIDTH;
	[super setFrame:frame];
	
	CGFloat xpos = (CGFloat)(NSInteger)(0.25 * WIDTH);
	tbMenu.frame = (CGRect){0, 0, xpos, frame.size.height};
	cvItem.frame = (CGRect){xpos, 0, WIDTH - xpos, frame.size.height};
}

// MARK: - METHOD

- (void)showFromYaxis:(CGFloat)axisY withHeight:(CGFloat)height {
	
	if ([self superview] == nil) {
		return;
	}
	
	if (self.hidden == NO) {
		[self dismiss];
		return;
	}
	
	self.hidden = NO;
	cBg.alpha = 0;
	self.frame = (CGRect){0, axisY, WIDTH, height};
	
	CGFloat xpos = (CGFloat)(NSInteger)(0.25 * WIDTH);
	
	// ANIMATE BEGIN
	tbMenu.frame = (CGRect){0, 0, xpos, 0};
	cvItem.frame = (CGRect){xpos, 0, WIDTH - xpos, 0};
	
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self->cBg.alpha = 1;
		self->tbMenu.frame = (CGRect){0, 0, xpos, height};
		self->cvItem.frame = (CGRect){xpos, 0, WIDTH - xpos, height};
	} completion:^(BOOL finished) {
		
	}];
}

- (void)dismiss {
	
	CGFloat xpos = (CGFloat)(NSInteger)(0.25 * WIDTH);
	
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
		self->cBg.alpha = 0;
		// ANIMATE TABLE
		self->tbMenu.frame = (CGRect){0, 0, xpos, 0};
		self->cvItem.frame = (CGRect){xpos, 0, WIDTH - xpos, 0};
	} completion:^(BOOL finished) {
		self.hidden = YES;
	}];
}

- (void)selectSection:(NSUInteger)index {
	
	if (index < [_datasource count]) {
		[tbMenu selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
		selection = index;
	} else {
		NSLog(@"LYDropDownSection Error:\n\tIndex %@ .. [0~%@]", @(index), @([_datasource count]));
	}
}

- (void)setSelectAction:(void (^)(NSIndexPath *))selectAction {
	selectBlock = selectAction;
}

// MARK: PRIVATE METHOD

// MARK: - DELEGATE

// MARK: UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)idp {
//	[tableView deselectRowAtIndexPath:idp animated:YES];
	
	selection = idp.row;
	[cvItem reloadData];
}

// MARK: UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [_datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)idp {
	LYDropDownSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:LYDropDownSectionCellIdentifier forIndexPath:idp];
	cell.lblTitle.text = _datasource[idp.row].title;
	return cell;
}

// MARK: UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)idp {
	[collectionView deselectItemAtIndexPath:idp animated:YES];
	
	if (selectBlock != nil) {
		selectBlock([NSIndexPath indexPathForItem:idp.item inSection:selection]);
	} else {
		NSLog(@"LYDropDownSection Error : SelectAction Block NIL");
	}
}

// MARK: UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	if (_datasource == nil || [_datasource count] < 1) {
		return 0;
	}
	return [_datasource[selection].items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)idp {
	LYDropDownSectionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYDropDownSectionItemCellIdentifier forIndexPath:idp];
	cell.lblTitle.text = _datasource[selection].items[idp.item].title;
	return cell;
}

// MARK: UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)idp {
	CGSize size = CGSizeZero;
	size.width = ((NSUInteger)(self.bounds.size.width * 0.75f) - (8 * 3)) * 0.5f;
	size.height = 44;
	return size;
}

// MARK: - OVERRIDE

- (NSString *)description {
	return [NSString stringWithFormat:@"%@", NSStringFromClass([self class])];
}

@end

// MARK: - LYDropDownSectionCell

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
			vBar = bar;
		}
		
	}
	return self;
}

- (void)setFrame:(CGRect)frame {
	[super setFrame:frame];
	
	vBar.frame = (CGRect){0, 0, 10, frame.size.height};
	_lblTitle.frame = (CGRect){0, 0, frame.size.width, frame.size.height};
}

@end

// MARK: - LYDropDownSectionItemCell

NSString *const LYDropDownSectionItemCellIdentifier = @"LYDropDownSectionItemCellIdentifier";

@interface LYDropDownSectionItemCell () {}
@end

@implementation LYDropDownSectionItemCell

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	self.backgroundColor = [UIColor whiteColor];
	self.clipsToBounds = YES;
	CGSize size = self.frame.size;
	
	{
		UILabel *label = [[UILabel alloc] init];
		label.frame = (CGRect){0, 0, size.width, size.height};
		label.textAlignment = NSTextAlignmentCenter;
		label.textColor = [UIColor blackColor];
		label.font = [UIFont systemFontOfSize:14];
		label.numberOfLines = 0;
		[self addSubview:label];
		_lblTitle = label;
	}
}

@end
