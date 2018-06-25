//
//  LYPopImagesViewController.m
//  LYPopView_Example
//
//  Created by Luo Yu on 2018/6/20.
//  Copyright © 2018 LUO YU (indie.luo@gmail.com). All rights reserved.
//

#import "LYPopImagesViewController.h"
#import <LYPopView/PopView.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIKit+AFNetworking.h>
#import <LYCategory/LYCategory.h>


@interface LYPopImagesViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout> {
	
	__weak IBOutlet UICollectionView *cvPop;
	
	NSString *PopImageCellIdentifier;
	
	NSArray *dsPop;
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

- (void)loadView {
	[super loadView];
	
	self.navigationItem.title = @"pop image view";
	
	[cvPop registerNib:[UINib nibWithNibName:@"LYPopImagesCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:PopImageCellIdentifier];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW FROM ITS NIB.
	
	{
		dsPop = @[
				  @"https://b-ssl.duitang.com/uploads/item/201502/17/20150217010924_YZ8Ka.jpeg",
				  @"https://b-ssl.duitang.com/uploads/item/201507/07/20150707231007_Ytv4z.jpeg",
				  @"https://b-ssl.duitang.com/uploads/blog/201403/26/20140326140216_xednQ.thumb.700_0.jpeg",
				  @"https://b-ssl.duitang.com/uploads/blog/201403/26/20140326140222_VXZGk.thumb.700_0.jpeg",
				  @"https://b-ssl.duitang.com/uploads/blog/201403/26/20140326141029_ZY3Nn.thumb.700_0.jpeg",
				  ];
	}
	
	[cvPop reloadData];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// DISPOSE OF ANY RESOURCES THAT CAN BE RECREATED.
}

// MARK: - METHOD

// MARK: - DELELGATE

// MARK: UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [dsPop count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)idp {
	LYPopImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PopImageCellIdentifier forIndexPath:idp];
	[cell.icon setImageWithURL:[NSURL URLWithFormat:@"%@", dsPop[idp.item]]];
	return cell;
}

// MARK: UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)idp {
	[collectionView deselectItemAtIndexPath:idp animated:YES];
	
	// MARK: - POP IMAGE HERE
	[[LYPopImage pop] showImageWithIndex:idp.item inDataSource:dsPop fromRect:[collectionView cellForItemAtIndexPath:idp].frame];
}

// MARK: UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)idp {
	
	CGFloat side = (CGFloat)((NSInteger)(WIDTH / 3));
	return (CGSize){side, side};
}

@end

// MARK: -

@implementation LYPopImagesCell

- (void)awakeFromNib {
	[super awakeFromNib];
	// INITIALIZATION CODE
}

@end
