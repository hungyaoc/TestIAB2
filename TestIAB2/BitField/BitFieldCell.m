//
//  BitFieldCell.m
//  TestIAB2
//
//  Created by Jeff Chen on 10/28/19.
//  Copyright © 2019 Jeff Chen. All rights reserved.
//

#import "BitFieldCell.h"

@implementation BitFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)valueChange:(UISwitch *)sender
{
    [self.delegate toggleValue:self.index withValue:self.swActive.isOn];
}
@end
