//
//  RangeCell.m
//  TestIAB2
//
//  Created by Jeff Chen on 10/28/19.
//  Copyright © 2019 Jeff Chen. All rights reserved.
//

#import "RangeCell.h"

@implementation RangeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)toggleValue:(UISegmentedControl*)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        self.lblSingle.hidden   = false;
        self.txtSingle.hidden   = false;
        
        self.lblStart.hidden    = true;
        self.lblEnd.hidden      = true;
        self.txtStart.hidden    = true;
        self.txtEnd.hidden      = true;
    }
    else
    {
        self.lblSingle.hidden   = true;
        self.txtSingle.hidden   = true;
        
        self.lblStart.hidden    = false;
        self.lblEnd.hidden      = false;
        self.txtStart.hidden    = false;
        self.txtEnd.hidden      = false;
    }
}
- (IBAction)goSave:(id)sender
{
    if(self.segType.selectedSegmentIndex == 0)
    {
        if(self.delegate)
        {
            [self.delegate updateValueSingle:self.index SingleID:self.txtSingle.text];
        }
    }
    else
    {
        if(self.delegate)
        {
            [self.delegate updateValueRange:self.index startID:self.txtStart.text endID:self.txtEnd.text];
        }
    }
}

@end
