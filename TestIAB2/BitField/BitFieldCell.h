//
//  BitFieldCell.h
//  TestIAB2
//
//  Created by Jeff Chen on 10/28/19.
//  Copyright © 2019 Jeff Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BitFieldCellDelegate <NSObject>
-(void)toggleValue:(int)index withValue:(BOOL)isConsent;
@end

@interface BitFieldCell : UITableViewCell
@property (weak, nonatomic) id<BitFieldCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *lblIndex;
@property (weak, nonatomic) IBOutlet UILabel *lblConsent;
@property (weak, nonatomic) IBOutlet UISwitch *swActive;
@property (nonatomic, assign) int index;

@end

NS_ASSUME_NONNULL_END
