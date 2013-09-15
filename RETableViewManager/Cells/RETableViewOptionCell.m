//
// RETableViewOptionCell.m
// RETableViewManager
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "RETableViewOptionCell.h"
#import "RETableViewManager.h"

@interface RETableViewOptionCell ()

@property (strong, readwrite, nonatomic) UILabel *valueLabel;

@end

@implementation RETableViewOptionCell

#pragma mark -
#pragma mark Lifecycle

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectNull];
    self.valueLabel.font = [UIFont systemFontOfSize:17];
    self.valueLabel.backgroundColor = [UIColor clearColor];
    self.valueLabel.textColor = self.detailTextLabel.textColor;
    self.valueLabel.highlightedTextColor = [UIColor whiteColor];
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.valueLabel];
}

- (void)cellWillAppear
{
    //[super cellWillAppear];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.text = self.item.title.length == 0 ? @" " : self.item.title;
    self.detailTextLabel.text = @"";
    self.valueLabel.text = self.item.detailLabelText;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutDetailView:self.valueLabel minimumWidth:[self.valueLabel.text sizeWithFont:self.valueLabel.font].width];
    if (REUIKitIsFlatMode()) {
        CGRect frame = self.valueLabel.frame;
        frame.size.width += 10.0;
        self.valueLabel.frame = frame;
    }
    
    if ([self.tableViewManager.delegate respondsToSelector:@selector(tableView:willLayoutCellSubviews:forRowAtIndexPath:)])
        [self.tableViewManager.delegate tableView:self.tableViewManager.tableView willLayoutCellSubviews:self forRowAtIndexPath:[(UITableView *)self.superview indexPathForCell:self]];
}

@end
