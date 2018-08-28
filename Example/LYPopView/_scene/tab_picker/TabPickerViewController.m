//
//  TabPickerViewController.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2017-06-25.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "TabPickerViewController.h"
#import <LYPopView/LYPopView.h>

@interface TabPickerViewController ()

@end

@implementation TabPickerViewController

// MARK: - ACTIONS

- (IBAction)pickerButtonPressed:(UIButton *)sender {
	LYPickerView *picker = [[LYPickerView alloc] init];
	[picker show];
}

- (IBAction)datepickerButtonPressed:(id)sender {
	[LYDatePicker showWithSelection:^(NSDate *date) {
		NSLog(@"date picked %@", date);
	}];
}

- (IBAction)showDatePicker:(UIButton *)sender {
	[LYPopDate showPopWithTitle:@"时间选择"
				 datePickerMode:UIDatePickerModeDate
				   stringFormat:@"yyyy-MM-dd"
					   timezone:@"Asia/Shanghai" andSelectionBlock:^(NSDate *date) {
						   NSLog(@"did select date %@", date);
					   }];
}

- (IBAction)showListPicker:(UIButton *)sender {
	LYPickerList *picker = [LYPickerList picker];
	picker.datasource = @[
						  @{@"title":@"first item", @"avalue":@"1st",},
						  @{@"title":@"second item", @"avalue":@"2nd",},
						  @{@"title":@"third item", @"avalue":@"3rd",},
						  ];
	picker.keyTitle = @"title";
	[picker setDonePickAction:^(NSDictionary *item, NSUInteger idx) {
		NSLog(@"\n\nINDEX=%@ WITH ITEM=%@", @(idx), item);
	}];
	[picker show];
}

- (IBAction)showSectionListPicker:(UIButton *)sender {
	LYPickerSecList *picker = [LYPickerSecList picker];
	picker.datasource = @[
						  @{@"title":@"group 0", @"subarray":@[@{@"title":@"item name sec 0"},],},
						  @{@"title":@"group 1", @"subarray":@[@{@"title":@"item name s 1"},],},
						  @{@"title":@"group 2", @"subarray":@[@{@"title":@"item name s2"},],},
						  ];
	picker.keyTitle = @"title";
	picker.keyArray = @"subarray";
	[picker setDonePickAction:^(NSDictionary *item, NSIndexPath *idp) {
		NSLog(@"\n\nIDP=%@ WITH ITEM=%@", idp, item);
	}];
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
	
	self.navigationItem.title = @"picker view";
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
