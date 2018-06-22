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

@interface LYPopImage () <UICollectionViewDelegate, UICollectionViewDataSource> {
	
	__weak UICollectionView *cvImage;
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
		[self addSubview:collectionview];
		cvImage = collectionview;
		
		[cvImage registerNib:[UINib nibWithNibName:@"LYPopImageCell" bundle:[NSBundle bundleWithIdentifier:LIB_POPVIEW_BUNDLE_ID]] forCellWithReuseIdentifier:LYPopImageCellIdentifier];
	}
}

// MARK: - DELEGATE

// MARK: UICollectionViewDelegate

// MARK: UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)idp {
	
	LYPopImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LYPopImageCellIdentifier forIndexPath:idp];
	
	return cell;
}


@end
