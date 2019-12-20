//
//  BitFieldTableViewCtrl.m
//  TestIAB2
//
//  Created by Jeff Chen on 10/28/19.
//  Copyright © 2019 Jeff Chen. All rights reserved.
//

#import "BitFieldTableViewCtrl.h"
#import "BitFieldCell.h"

@interface BitFieldTableViewCtrl () <BitFieldCellDelegate>
@property(nonatomic, strong) NSMutableArray* dataArray;
@end

@implementation BitFieldTableViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    for(int i=0; i<self.maxVendorId; i++)
    {
        [self.dataArray addObject:self.defaultActive ? @"1" : @"0"];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
  [super viewWillDisappear:animated];

  if (self.isMovingFromParentViewController)
  {
      NSString* consentStr = @"";
      
      for(int i=0; i<self.dataArray.count; i++)
      {
          consentStr = [consentStr stringByAppendingString:self.dataArray[i]];
      }
      
      [self.delegate receiveBitFieldString:consentStr];
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BitFieldCell *cell = (BitFieldCell*)[tableView dequeueReusableCellWithIdentifier:@"BitFieldCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.delegate = self;
    cell.index = (int)indexPath.row;
    cell.lblIndex.text = [NSString stringWithFormat:@"index %d", (int)indexPath.row];
    
    NSString* str = self.dataArray[indexPath.row];
    if([str isEqualToString:@"1"])
    {
        cell.swActive.on = YES;
        cell.lblConsent.text = @"Consent";
    }
    else
    {
        cell.swActive.on = NO;
        cell.lblConsent.text = @"No Consent";
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK: - delegate
-(void)toggleValue:(int)index withValue:(BOOL)isConsent
{
    [self.dataArray removeObjectAtIndex:index];
    
    [self.dataArray insertObject:isConsent ? @"1":@"0" atIndex:index];
    
    [self.myTable reloadData];
}

@end
