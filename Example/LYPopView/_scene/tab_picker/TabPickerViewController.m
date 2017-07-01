//
//  TabPickerViewController.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2017-06-25.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "TabPickerViewController.h"
#import <LYPopView/PopView.h>

@interface TabPickerViewController ()

@end

@implementation TabPickerViewController

// MARK: - ACTIONS

- (IBAction)pickerButtonPressed:(UIButton *)sender {
	LYPickerView *picker = [[LYPickerView alloc] init];
	[picker show];
}

// MARK: - INIT

- (instancetype)init {
	if (self = [super initWithNibName:@"TabPickerViewController" bundle:[NSBundle mainBundle]]) {
	}
	return self;
}

- (void)loadView {
	[super loadView];
	
	self.title = @"picker view";
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW FROM ITS NIB.
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// DISPOSE OF ANY RESOURCES THAT CAN BE RECREATED.
}


@end
