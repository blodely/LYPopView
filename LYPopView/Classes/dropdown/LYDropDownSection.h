//
//  LYDropDownSection.h
//  LYPopView
//
//  CREATED BY LUO YU ON 2018-07-30.
//  COPYRIGHT © 2016-2018 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@interface LYDropDownItem : NSObject <NSCopying, NSCoding>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@end

@interface LYDropDownSectionItem : NSObject <NSCopying, NSCoding>
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSArray <LYDropDownItem *>*items;
@end

@interface LYDropDownSection : UIView

@end

FOUNDATION_EXPORT NSString *const LYDropDownSectionCellIdentifier;

@interface LYDropDownSectionCell : UITableViewCell

@property (nonatomic, weak) UILabel *lblTitle;

@end

FOUNDATION_EXPORT NSString *const LYDropDownSectionItemCellIdentifier;

@interface LYDropDownSectionItemCell : UICollectionViewCell

@end
