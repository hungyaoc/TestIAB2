//
//  BitFieldTableViewCtrl.h
//  TestIAB2
//
//  Created by Jeff Chen on 10/28/19.
//  Copyright © 2019 Jeff Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BitFieldTableViewCtrlDelegate <NSObject>
-(void)receiveBitFieldString:(NSString*)str;
@end

@interface BitFieldTableViewCtrl : UIViewController
@property (weak, nonatomic) id<BitFieldTableViewCtrlDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, assign) int maxVendorId;
@property (nonatomic, assign) BOOL defaultActive;
@end

NS_ASSUME_NONNULL_END
