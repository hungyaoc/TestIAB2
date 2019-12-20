//
//  RangeCell.h
//  TestIAB2
//
//  Created by Jeff Chen on 10/28/19.
//  Copyright © 2019 Jeff Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RangeCellDelegate <NSObject>

-(void)updateValueSingle:(int)index SingleID:(NSString*)venderId;
-(void)updateValueRange:(int)index startID:(NSString*)startId endID:(NSString*)endID;

@end
@interface RangeCell : UITableViewCell
@property (weak, nonatomic) id<RangeCellDelegate>delegate;
@property (nonatomic, assign) int index;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segType;
@property (weak, nonatomic) IBOutlet UILabel *lblSingle;
@property (weak, nonatomic) IBOutlet UILabel *lblStart;
@property (weak, nonatomic) IBOutlet UILabel *lblEnd;
@property (weak, nonatomic) IBOutlet UITextField *txtSingle;
@property (weak, nonatomic) IBOutlet UITextField *txtStart;
@property (weak, nonatomic) IBOutlet UITextField *txtEnd;
@end

NS_ASSUME_NONNULL_END
