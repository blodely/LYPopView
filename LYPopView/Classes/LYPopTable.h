//
//  LYPopTable.h
//  LYPOPVIEW
//
//  CREATED BY LUO YU ON 2016-12-20.
//  COPYRIGHT © 2016 LUO YU. ALL RIGHTS RESERVED.
//

#import <LYPopView/LYPopView.h>

FOUNDATION_EXPORT NSString *const LYPopTableDataTitle;

@interface LYPopTable : LYPopView

@property (nonatomic, weak) UITableView *tbMenu;

@end

// MARK: - SAMPLE CELL

FOUNDATION_EXPORT NSString *const LYPopTableCellIdentifier;

/**
 STANDARD CELL
 */
@interface LYPopTableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *ivIcon;
@property (nonatomic, weak) IBOutlet UILabel *lblTitle;
@property (nonatomic, weak) IBOutlet UILabel *lblSubtitle;
@end
