//
//  ViewController.h
//  TestIAB2
//
//  Created by Jeff Chen on 10/21/19.
//  Copyright © 2019 Jeff Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblOutput;
@property (weak, nonatomic) IBOutlet UITextField *txtCmpID;
@property (weak, nonatomic) IBOutlet UITextField *txtCmpVersion;
@property (weak, nonatomic) IBOutlet UITextField *txtConsentScreen;
@property (weak, nonatomic) IBOutlet UITextField *txtConsentLanguage;
@property (weak, nonatomic) IBOutlet UITextField *txtVendorListVersion;
@property (weak, nonatomic) IBOutlet UISwitch *purpose1;
@property (weak, nonatomic) IBOutlet UISwitch *purpose2;
@property (weak, nonatomic) IBOutlet UISwitch *purpose3;
@property (weak, nonatomic) IBOutlet UISwitch *purpose4;
@property (weak, nonatomic) IBOutlet UISwitch *purpose5;
@property (weak, nonatomic) IBOutlet UITextField *txtMaxVenderID;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segEncodingType;
@property (weak, nonatomic) IBOutlet UISwitch *swDefaultContent;

// below range only
@property (weak, nonatomic) IBOutlet UILabel *lblNumEntries;
@property (weak, nonatomic) IBOutlet UITextField *txtNumEntries;

@property (weak, nonatomic) IBOutlet UILabel *lblRangeEntry;
@property (weak, nonatomic) IBOutlet UITextField *txtRangeEntry;

@property (weak, nonatomic) IBOutlet UIButton *btnBitField;
@property (weak, nonatomic) IBOutlet UIButton *btnRange;

@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;

@end

