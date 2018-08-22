//
//  LYPopImage.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2018-06-18.
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

#import "LYPopImage.h"
#import "LYPopImageCell.h"
#import "LYPopView.h"
#import <LYCategory/LYCategory.h>
#import <AFNetworking/UIKit+AFNetworking.h>


@interface LYPopImage () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
	
	__weak UILabel *lblIdx;
	
	__weak UICollectionView *cvImage;
	
	NSMutableArray *dsImage;
}
@end

@implementation LYPopImage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


// MARK: - INIT

+ (instancetype)pop {
	static LYPopImage *popview;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		popview = [[LYPopImage alloc] initWithFrame:CGRectZero];
	});
	return popview;
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self initial];
	}
	return self;
}

- (void)initial {
	
	CGRect rect = [[UIScreen mainScreen] bounds];
	CGFloat padding = 10.0f;
	
	self.frame = rect;
	self.backgroundColor = [UIColor colorWithHex:@"#000000" andAlpha:0.85];
	
	{
		dsImage = [NSMutableArray arrayWithCapacity:1];
		_showIndex = NO;
	}
	
	{
		UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
		flowlayout.itemSize = rect.size;
		flowlayout.minimumLineSpacing = padding;
		flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, padding);
		flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		
		rect.size.width += padding;
		
		UICollectionView *collectionview = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowlayout];
		collectionview.delegate = self;
		collectionview.dataSource = self;
		collectionview.pagingEnabled = YES;
		collectionview.backgroundColor = [UIColor clearColor];
		[self addSubview:collectionview];
		cvImage = collectionview;
		
//		[cvImage registerNib:[UINib nibWithNibName:@"LYPopImageCell" bundle:[NSBundle bundleWithIdentifier:LIB_POPVIEW_BUNDLE_ID]] forCellWithReuseIdentifier:LYPopImageCellIdentifier];
		[cvImage registerClass:[LYPopImageCell class] forCellWithReuseIdentifier:LYPopImageCellIdentifier];
		
		// RESET
		rect = [[UIScreen mainScreen] bounds];
	}
	
	{
		UILabel *label = [[UILabel alloc] init];
		label.frame = (CGRect){padding, rect.size.height - 100, rect.size.width - (padding * 2), 30};
		label.font = [UIFont systemFontOfSize:15];
		label.textColor = [UIColor whiteColor];
		label.textAlignment = NSTextAlignmentRight;
		[self addSubview:label];
		lblIdx = label;
		
		lblIdx.hidden = !_showIndex;
	}
}

// MARK: - PROPERTY

- (void)setShowIndex:(BOOL)showIndex {
	_showIndex = showIndex;
	
	lblIdx.hidden = !_showIndex;
}

// MARK: - METHOD

- (void)showImageWithIndex:(NSInteger)idx inDataSource:(NSArray<NSString *> *)datasource fromRect:(CGRect)rect {
	
	if (datasource == nil || [datasource isKindOfClass:[NSArray class]] == NO || [datasource count] == 0) {
		return;
	}
	
	[dsImage removeAllObjects];
	[dsImage addObjectsFromArray:datasource];
	[cvImage reloadData];
	[cvImage scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
	
	lblIdx.text = [NSString stringWithFormat:@"%@ / %@", @(idx + 1), @([datasource count])];
	
	self.alpha = 0;
	[[UIApplication sharedApplication].keyWindow addSubview:self];
	
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.alpha = 1;
	} completion:^(BOOL finished) {
	}];
}

- (void)dismiss {
	
	[UIView animateWithDuration:ANIMATE delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.alpha = 0;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
		[self cleanup];
	}];
}

// MARK: PRIVATE METHOD

- (void)cleanup {
	[dsImage removeAllObjects];
	[cvImage reloadData];
	lblIdx.text = @"";
}

// MARK: - DELEGATE

// MARK: UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)idp {
	[collectionView deselectItemAtIndexPath:idp animated:NO];
	
	[self dismiss];
}

// MARK: UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [dsImage count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)idp {
	
	LYPopImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYPopImageCellIdentifier forIndexPath:idp];
	[cell.ivImage setImageWithURL:[NSURL URLWithString:dsImage[idp.item]]];
	return cell;
}

// MARK: UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)idp {
	return self.bounds.size;
}

// MARK: UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	NSInteger where = (NSInteger)(scrollView.contentOffset.x / self.bounds.size.width + 1);
	lblIdx.text = [NSString stringWithFormat:@"%@ / %@", @(where), @([dsImage count])];
}

@end
