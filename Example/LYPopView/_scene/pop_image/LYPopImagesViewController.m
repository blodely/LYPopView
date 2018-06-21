//
//  LYPopImagesViewController.m
//  LYPopView_Example
//
//  Created by Luo Yu on 2018/6/20.
//  Copyright © 2018 LUO YU (indie.luo@gmail.com). All rights reserved.
//

#import "LYPopImagesViewController.h"
#import <LYPopView/PopView.h>
//#import <l>

@interface LYPopImagesViewController () <UICollectionViewDataSource, UICollectionViewDelegate> {
	
	__weak IBOutlet UICollectionView *cvPop;
	
	NSString *PopImageCellIdentifier;
}
@end

@implementation LYPopImagesViewController

// MARK: - ACTION

// MARK: - INIT

- (instancetype)init {
	if (self = [super initWithNibName:@"LYPopImagesViewController" bundle:[NSBundle mainBundle]]) {
		self.hidesBottomBarWhenPushed = YES;
		
		PopImageCellIdentifier = @"popimagecollectcellidentifier";
	}
	return self;
}

// MARK: VIEW LIFE CYCLE

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW FROM ITS NIB.
	
	self.navigationItem.title = @"pop image view";
	
	[cvPop registerNib:[UINib nibWithNibName:@"LYPopImagesCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:PopImageCellIdentifier];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// DISPOSE OF ANY RESOURCES THAT CAN BE RECREATED.
}

// MARK: - METHOD

// MARK: - DELELGATE

// MARK: UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)idp {
	LYPopImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PopImageCellIdentifier forIndexPath:idp];
//	[cell.icon setimage];
	return cell;
}

// MARK: UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)idp {
	[collectionView deselectItemAtIndexPath:idp animated:YES];
}

@end

// MARK: -

@implementation LYPopImagesCell

- (void)awakeFromNib {
	[super awakeFromNib];
	// INITIALIZATION CODE
}

@end
