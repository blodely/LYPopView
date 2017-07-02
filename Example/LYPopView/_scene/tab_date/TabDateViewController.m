//
//  TabDateViewController.m
//  LYPopView
//
//  Created by Luo Yu on 19/12/2016.
//  Copyright © 2016 LUO YU. All rights reserved.
//

#import "TabDateViewController.h"
#import <LYPopView/PopView.h>

@interface TabDateViewController () {
	
	__weak IBOutlet UILabel *lblOutput;
}

@end

@implementation TabDateViewController

// MARK: - ACTION

- (IBAction)showDatePicker:(UIButton *)sender {
	[LYPopDate showPopWithTitle:@"时间选择"
				 datePickerMode:UIDatePickerModeDate
				   stringFormat:@"yyyy-MM-dd"
					   timezone:@"Asia/Shanghai" andSelectionBlock:^(NSDate *date) {
		NSLog(@"did select date %@", date);
	}];
}

// MARK: - INIT

- (instancetype)init {
	if (self = [super initWithNibName:@"TabDateViewController" bundle:[NSBundle mainBundle]]) {
	}
	return self;
}

// MARK: | VIEW LIFE CYCLE

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW FROM ITS NIB.
	
	self.title = @"date pop view";
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
