//
//  LYPopImageCell.m
//  LYPopView
//
//  CREATED BY LUO YU ON 2018-06-20.
//  COPYRIGHT © 2016-2019 LUO YU <indie.luo@gmail.com>. ALL RIGHTS RESERVED.
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

#import "LYPopImageCell.h"


NSString *const LYPopImageCellIdentifier = @"LYPopImageCellIdentifier";

@interface LYPopImageCell () {}
@end

@implementation LYPopImageCell

- (void)awakeFromNib {
	[super awakeFromNib];
	// INITIALIZATION CODE
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		
		{
			UIImageView *view = [[UIImageView alloc] init];
			view.translatesAutoresizingMaskIntoConstraints = NO;
			view.contentMode = UIViewContentModeScaleAspectFit;
			view.clipsToBounds = YES;
			[self addSubview:view];
			_ivImage = view;
			
			[view.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
			[view.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
			[view.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
			[view.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
		}
	}
	return self;
}

@end
