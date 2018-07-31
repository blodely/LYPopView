//
//  TabBaseViewController.m
//  LYPopView
//
//  Created by Luo Yu on 19/12/2016.
//  Copyright © 2016 LUO YU. All rights reserved.
//

#import "TabBaseViewController.h"
#import <LYPopView/PopView.h>

@interface TabBaseViewController () {
	
	__weak LYDropDown *dropdownmenu;
	
	__weak LYDropDownSection *ddsection;
}

@end

@implementation TabBaseViewController

// MARK: - ACTION

- (IBAction)showNormalPopView:(UIButton *)sender {
	
	LYPopView *popview = [[LYPopView alloc] init];
	popview.title = @"Base Pop View";
	[popview show];
}

- (IBAction)showSingleActionPopView:(UIButton *)sender {
	LYPopActionView *popview = [[LYPopActionView alloc] init];
	popview.title = @"single button pop view";
	[popview setSingleButtonTitle:@"Yes" andAction:^{
		NSLog(@"Pressed\n%@", [NSDate date]);
	}];
	[popview show];
}

- (IBAction)showDoubleActionPopView:(UIButton *)sender {
	LYPopActionView *popview = [[LYPopActionView alloc] init];
	popview.title = @"double buttons pop view";
	[popview setDoubleButtonBtnZeroTitle:@"cancel" action:^{
		NSLog(@"button 0 pressed\n%@", [NSDate date]);
	} andBtnOneTitle:@"yes" action:^{
		NSLog(@"button 1 pressed\n%@", [NSDate date]);
	}];
	[popview show];
}

- (IBAction)dropdownButtonPressed:(UIButton *)sender {
	[dropdownmenu showFrom:sender.frame];
}

- (IBAction)dropdownSectionButtonPressed:(UIButton *)sender {
	[ddsection showFromYaxis:CGRectGetMaxY(sender.frame) withHeight:self.view.frame.size.height - CGRectGetMaxY(sender.frame)];
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
	
	self.navigationItem.title = @"basic pop view";
	
	{
		LYDropDown *ddm = [LYDropDown menu];
		[self.view addSubview:ddm];
		dropdownmenu = ddm;
		
		[dropdownmenu addItemTitle:@"first item" action:^(NSUInteger index, NSString *title) {
			NSLog(@"1st: tapped : %@ %@", @(index), title);
		}];
		[dropdownmenu addItemTitle:@"second item" action:^(NSUInteger index, NSString *title) {
			NSLog(@"2ed: tapped : %@ %@", @(index), title);
		}];
		
		[dropdownmenu selectItemAtIndex:0];
	}
	
	{
		LYDropDownSection *dds = [LYDropDownSection menu];
		[self.view addSubview:dds];
		ddsection = dds;
		
		NSMutableArray *ds = [NSMutableArray arrayWithCapacity:1];
		for (int i = 0; i < 5; i++) {
			LYDropDownSectionItem *secitem = [[LYDropDownSectionItem alloc] init];
			secitem.title = [NSString stringWithFormat:@"section item %@", @(i)];
			NSMutableArray *secarr = [NSMutableArray arrayWithCapacity:1];
			for (int j = 0; j < 15; j++) {
				LYDropDownItem *item = [[LYDropDownItem alloc] init];
				item.title = [NSString stringWithFormat:@"item %@ in sec %@", @(j), @(i)];
				[secarr addObject:item];
			}
			secitem.items = [NSArray arrayWithArray:secarr];
			[ds addObject:secitem];
		}
		
		dds.datasource = [NSArray arrayWithArray:ds];
		
		[ddsection selectSection:0];
		
		[ddsection setSelectAction:^(NSIndexPath *idp) {
			NSLog(@"DDSection %@", idp);
		}];
	}
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
