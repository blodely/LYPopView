//
//  TabBaseViewController.m
//  LYPopView
//
//  Created by Luo Yu on 19/12/2016.
//  Copyright © 2016 LUO YU. All rights reserved.
//

#import "TabBaseViewController.h"
#import <LYPopView/LYPopView.h>

@interface TabBaseViewController ()

@end

@implementation TabBaseViewController

// MARK: - ACTION

- (IBAction)showNormalPopView:(UIButton *)sender {
	
	LYPopView *popview = [[LYPopView alloc] init];
	[popview show];
}

// MARK: - INIT

- (instancetype)init {
	if (self = [super initWithNibName:@"TabBaseViewController" bundle:[NSBundle mainBundle]]) {
	}
	return self;
}

// MARK: | VIEW LIFE CYCLE

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW FROM ITS NIB.
}

// MARK: | MEMORY MANAGEMENT

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// DISPOSE OF ANY RESOURCES THAT CAN BE RECREATED.
}

// MARK: - METHOD

// MARK: | PRIVATE METHOD

// MARK: - DELEGATE

// MARK: |

// MARK: - NOTIFICATION

@end
