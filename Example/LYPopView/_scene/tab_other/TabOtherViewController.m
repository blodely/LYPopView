//
//  TabOtherViewController.m
//  LYPopView_Example
//
//  Created by Luo Yu on 2018/6/20.
//  Copyright © 2018 LUO YU (indie.luo@gmail.com). All rights reserved.
//

#import "TabOtherViewController.h"
#import <LYPopView/PopView.h>

#import "LYPopImagesViewController.h"


@interface TabOtherViewController ()

@end

@implementation TabOtherViewController

// MARK: - ACTION

- (IBAction)popimageButtonPressed:(UIButton *)sender {
	[self.navigationController pushViewController:[[LYPopImagesViewController alloc] init] animated:YES];
}

- (IBAction)navToWebView:(UIButton *)sender {
	[self.navigationController pushViewController:[[LYWebViewController alloc] initWithTitle:@"啊哈哈啊哈哈" andURL:@"https://www.baidu.com"] animated:YES];
}

// MARK: - INIT

- (instancetype)init {
	if (self = [super initWithNibName:@"TabOtherViewController" bundle:[NSBundle mainBundle]]) {
		
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	self.navigationItem.title = @"other pop view";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
