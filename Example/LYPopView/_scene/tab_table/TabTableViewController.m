//
//  TabTableViewController.m
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import "TabTableViewController.h"
#import <LYPopView/LYPopTable.h>

@interface TabTableViewController () <UITableViewDataSource, UITableViewDelegate> {
	
	NSArray *menu;
}

@end

@implementation TabTableViewController

// MARK: - ACTION

- (IBAction)showMenuTable:(UIButton *)sender {
	
	LYPopTable *tablepop = [[LYPopTable alloc] init];
	tablepop.title = @"Table Pop View";
	tablepop.tbMenu.dataSource = self;
	tablepop.tbMenu.delegate = self;
	[tablepop.tbMenu registerClass:[UITableViewCell class] forCellReuseIdentifier:@"menu_cell_identifier"];
	[tablepop show];
}

// MARK: - INIT

- (instancetype)init {
	if (self = [super initWithNibName:@"TabTableViewController" bundle:[NSBundle mainBundle]]) {
	}
	return self;
}

// MARK: | VIEW LIFE CYCLE

- (void)viewDidLoad {
	[super viewDidLoad];
	// DO ANY ADDITIONAL SETUP AFTER LOADING THE VIEW FROM ITS NIB.
	
	self.title = @"table pop view";
	
	menu = @[
			 @{LYPopTableDataTitle:@"menu item",},
			 @{LYPopTableDataTitle:@"menu item",},
			 @{LYPopTableDataTitle:@"menu item",},
			 @{LYPopTableDataTitle:@"menu item",},
			 @{LYPopTableDataTitle:@"menu item",},
			 ];
}

// MARK: | MEMORY MANAGEMENT

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// DISPOSE OF ANY RESOURCES THAT CAN BE RECREATED.
}

// MARK: - METHOD

// MARK: | PRIVATE METHOD

// MARK: - DELEGATE

// MARK: | UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)idp {
	
	[tableView deselectRowAtIndexPath:idp animated:YES];
}

// MARK: | UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)idp {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menu_cell_identifier" forIndexPath:idp];
	cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", menu[idp.row][LYPopTableDataTitle], @(idp.row)];
	return cell;
}

// MARK: - NOTIFICATION

@end
