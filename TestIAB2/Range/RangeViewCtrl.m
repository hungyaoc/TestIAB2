//
//  RangeViewCtrl.m
//  TestIAB2
//
//  Created by Jeff Chen on 10/28/19.
//  Copyright © 2019 Jeff Chen. All rights reserved.
//

#import "RangeViewCtrl.h"
#import "RangeCell.h"

#define kSingle         @"kSingle"
#define kSingleID       @"kSingleID"
#define kRangeStartID   @"kRangeStartID"
#define kRangeEndID     @"kRangeEndID"

@interface RangeViewCtrl () <RangeCellDelegate>
@property(nonatomic, strong) NSMutableArray* dataArray;
@end

@implementation RangeViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)goAddEntry:(id)sender
{
    if(self.self.dataArray == nil)
    {
        self.dataArray = [[NSMutableArray alloc] init];
    }
    
    NSDictionary* dic = @{kSingle:@"yes", kSingleID:@"1"};
    [self.dataArray addObject:dic];
    
    [self.myTable reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];

  if (self.isMovingFromParentViewController)
  {
      NSString* consentStr = @"";
    
      // 12. DefaultConsent ... Default is "Consent" ... 1 bit (173) ... 0=No Consent 1=Consent
      if(self.defaultActive)
          consentStr = [consentStr stringByAppendingString:@"1"];
      else
          consentStr = [consentStr stringByAppendingString:@"0"];
      
      // 1. NumEntries
      int entries = (int)self.dataArray.count;
      NSString* NumEntries = [self intToBinary:entries withLength:12];
      consentStr = [consentStr stringByAppendingString:NumEntries];
    
      // 2.
      for(int i=0; i<entries; i++)
      {
          NSDictionary* dic = self.dataArray[i];
          NSString* isSingle = dic[kSingle];
          
          if([isSingle isEqualToString:@"yes"])
          {
              // 14. SingleOrRange[0] ... A single VendorId (which is "No Consent") ... 1 bit (186)
              consentStr = [consentStr stringByAppendingString:@"0"];
          
              // 15. SingleVendorId[0] ... VendorId=9 has No Consent (opposite of Default Consent) ... 16 bits
              NSString* singleID = dic[kSingleID];
              int tmp = [singleID intValue];
              NSString* singleVId = [self intToBinary:tmp withLength:16];
              consentStr = [consentStr stringByAppendingString:singleVId];
          }
          else
          {
              NSString* startID = dic[kRangeStartID];
              NSString* endID   = dic[kRangeEndID];
              
              // 14. SingleOrRange[0] ... range VendorID ... 1 bit (186)
              consentStr = [consentStr stringByAppendingString:@"1"];
              
              // 15. StartVendorId ... The start of an inclusive range of VendorIds ... 16 bits
              int tmp1 = [startID intValue];
              NSString* sVId = [self intToBinary:tmp1 withLength:16];
              consentStr = [consentStr stringByAppendingString:sVId];
              
              // 16. EndVendorId   ... The end of an inclusive range of VendorIds   ... 16 bits
              int tmp2 = [endID intValue];
              NSString* eVId = [self intToBinary:tmp2 withLength:16];
              consentStr = [consentStr stringByAppendingString:eVId];
          }
      }
      
      // send back
      [self.delegate receiveRangeString:consentStr];
  }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RangeCell *cell = (RangeCell*)[tableView dequeueReusableCellWithIdentifier:@"RangeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.delegate = self;
    cell.index = (int)indexPath.row;
    
    NSDictionary* dic = self.dataArray[indexPath.row];
    
    //===
    NSString* single = dic[kSingle];
    if([single isEqualToString:@"yes"])
    {
        // single
        [cell.segType setSelectedSegmentIndex:0];
        
        NSString* singleID = dic[kSingleID];
        cell.txtSingle.text = singleID;
        
    }
    else
    {
        [cell.segType setSelectedSegmentIndex:1];
        
        NSString* rangeStartID = dic[kRangeStartID];
        cell.txtStart.text = rangeStartID;
        
        NSString* rangeEndID = dic[kRangeEndID];
        cell.txtEnd.text = rangeEndID;
    }
    
    return cell;
}

// MARK: - delegate
-(void)updateValueSingle:(int)index SingleID:(NSString*)venderId
{
    [self.dataArray removeObjectAtIndex:index];
    
    NSDictionary* dic = @{kSingle:@"yes", kSingleID:venderId};
    [self.dataArray insertObject:dic atIndex:index];
    
    [self.myTable reloadData];
}
    
-(void)updateValueRange:(int)index startID:(NSString*)startId endID:(NSString*)endID
{
    [self.dataArray removeObjectAtIndex:index];
    
    NSDictionary* dic = @{kSingle:@"no", kRangeStartID:startId, kRangeEndID:endID};
    [self.dataArray insertObject:dic atIndex:index];
    
    [self.myTable reloadData];
}

// MARK: - help function
- (NSString *)intToBinary:(int)intValue withLength:(int)bitLen
{
    int totalBits = bitLen; // Total bits
    int binaryDigit = bitLen; // Which digit are we processing
 
    // C array - storage plus one for null
    char ndigit[totalBits + 1];
 
    while (binaryDigit-- > 0)
    {
        // Set digit in array based on rightmost bit
        ndigit[binaryDigit] = (intValue & 1) ? '1' : '0';
 
        // Shift incoming value one to right
        intValue >>= 1;
    }
 
    // Append null
    ndigit[totalBits] = 0;
 
    // Return the binary string
    return [NSString stringWithUTF8String:ndigit];
}
@end
