//
//  ViewController.m
//  TestIAB2
//
//  Created by Jeff Chen on 10/21/19.
//  Copyright © 2019 Jeff Chen. All rights reserved.
//

#import "ViewController.h"
#import "BitFieldTableViewCtrl.h"
#import "RangeViewCtrl.h"
#include <bitset>
#include <iostream>
#include <string>

using namespace std;

@interface ViewController () <BitFieldTableViewCtrlDelegate, RangeViewCtrlDelegate>
@property (nonatomic, strong) NSString* bitFieldString;
@property (nonatomic, strong) NSString* rangeString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"IAB String Generator";
    
    int cx = self.view.frame.size.width;
    int cy = self.view.frame.size.height;
    
    self.myScroll.contentSize = CGSizeMake(cx, cy * 1.3);
    
    // default
    _bitFieldString = @"";
    _rangeString = @"";
}

-(unsigned char)string2Binary:(NSString*)str
{
    unsigned char retrievedByte = 0;

    for (int i=0; i<8; i++)
    {
        char ch = [str characterAtIndex:i];
        int bit = ch - '0';
        
        retrievedByte = retrievedByte << 1;
        
        retrievedByte += bit;
    }
    
    return retrievedByte;
}

- (IBAction)goTest1:(id)sender
{
    char ch = 0x04;
    cout << std::bitset<8>(ch);
    //printf("%0x", ch);
    
    //===
    /*string st = "00000100";
    char tmp = stoi(st, 0, 2);
    cout << tmp << endl;
    
    //===
    NSString* st2 = @"11100001";
    char tmp2 = [self string2Binary:st2];*/
    
    //===
    NSArray* array = @[@"00000100", @"11100001", @"00000101", @"00010000", @"00001100", @"10001110",
                       @"00010000", @"01010001", @"00000000", @"11001000", @"00000001", @"11000000",
                       @"00000100", @"00110001", @"00001101", @"00000000", @"10001110", @"00000000",
                       @"00000000", @"00000000", @"01111101", @"10111100", @"00000000", @"01000000",
                       @"00000001", @"00100000", @"00000000"];
    
    NSMutableData* data = [[NSMutableData alloc] init];
    
    for(NSString* str in array)
    {
        char ch = [self string2Binary:str];
        
        [data appendBytes:&ch length:1];
    }
    
    NSString *base64String  = [data base64EncodedStringWithOptions:0];
    NSLog(@"%@", base64String); // Zm9v
    
    /*string stArray[] = {"00000100", "11100001", "00000101", "00010000", "00001100", "10001110",
                        "00010000", "01010001", "00000000", "11001000", "00000001", "11000000",
                        "00000100", "00110001", "00001101", "00000000", "10001110", "00000000",
                        "00000000", "00000000", "01111101", "10111100", "00000000", "01000000",
                        "00000001", "00100000", "00000000"};
    string output = "";
    
    
    int count = sizeof(stArray) / sizeof(stArray[0]);
    
    for(int i=0; i < count; i++)
    {
        char ch1 = stoi(stArray[i], 0, 2);
        
        printf("%c", ch1);
        
        //output += ch1;
    }
    
    cout << output << endl;*/
}


- (IBAction)goTest2:(id)sender
{
    NSString* str1 = @"BOEFEAyOEFEAyAHABDENAI4AAAB9vABAASAA";
    
    NSString *plainString = @"foo";
    
    //NSString* decode = [self base64Decode:str1];
    //NSLog(@"%@", decode);
    
    // encoding
    NSData *plainData       = [plainString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String  = [plainData base64EncodedStringWithOptions:0];
    NSLog(@"%@", base64String); // Zm9v
    
    // decoding
    NSData *decodedData     = [[NSData alloc] initWithBase64EncodedString:str1 options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", decodedString); // foo
}


- (IBAction)goTest3:(id)sender
{
    NSString* iab = @"000001001110000100000101000100000000110010001110"
                    "000100000101000100000000110010000000000111000000"
                    "000001000011000100001101000000001000111000000000"
                    "000000000000000001111101101111000000000001000000"
                    "000000010010000000000000";
    
    NSString* output = [self convertIABString:iab];
    NSLog(@"%@", output);
}

// MARK: - encode/decode
-(NSString*)base64Encode:(NSString*)input
{
    NSData *plainData = [input dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    NSLog(@"%@", base64String); // Zm9v
    
    return base64String;
}

-(NSString*)base64Decode:(NSString*)input
{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:input options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", decodedString); // foo
    
    return decodedString;
}

-(NSString*)convertIABString:(NSString*)iab
{
    NSMutableData* data = [[NSMutableData alloc] init];
    
    NSInteger length = iab.length;
    
    // checking
    int loc = 0;
    int len = 8;
    
    while(length > 0)
    {
        NSRange range = NSMakeRange(loc, len);
        
        NSString* str = [iab substringWithRange:range];
        
        //===
        char ch = [self string2Binary:str];
        [data appendBytes:&ch length:1];
        
        // remove substring
        iab = [iab substringFromIndex:len];
        length = iab.length;
    }
    
    NSString *base64String  = [data base64EncodedStringWithOptions:0];
    NSLog(@"%@", base64String);
    
    return base64String;
}

-(NSString*)int2BinaryString:(int)ch
{
    NSString* ret = nil;
    
    switch (ch)
    {
        case 0: ret = @"0000"; break;
        case 1: ret = @"0001"; break;
        case 2: ret = @"0010"; break;
        case 3: ret = @"0011"; break;
        case 4: ret = @"0100"; break;
        case 5: ret = @"0101"; break;
        case 6: ret = @"0110"; break;
        case 7: ret = @"0111"; break;
        case 8: ret = @"1000"; break;
        case 9: ret = @"1001"; break;
        case 10: ret = @"1010"; break;
        case 11: ret = @"1011"; break;
        case 12: ret = @"1100"; break;
        case 13: ret = @"1101"; break;
        case 14: ret = @"1110"; break;
        case 15: ret = @"1111"; break;
    }
    
    return ret;
}

- (IBAction)toggleEncodeType:(UISegmentedControl*)sender
{
    if(sender.selectedSegmentIndex == 0)
    {
        self.btnBitField.hidden = NO;
        self.btnRange.hidden    = YES;
    }
    else
    {
        self.btnBitField.hidden = YES;
        self.btnRange.hidden    = NO;
    }
}

- (IBAction)goCeateString:(id)sender
{
    // 1. version
    NSString* consent = @"000001";
    
    // 2. Created
    NSDate* now = [NSDate date];
    double time = ceil([now timeIntervalSince1970] * 10);
    
    NSMutableArray* arrayTime = [[NSMutableArray alloc] init];
    
    while(time > 0)
    {
        double tmp1 = floor(time / 16) * 16;
        double tmp2 = time - tmp1;
    
        NSString* bitStr = [self int2BinaryString:(int)tmp2];
        [arrayTime insertObject:bitStr atIndex:0];
        
        time = floor(time / 16);
    }
    
    NSString* timeStr = [arrayTime componentsJoinedByString:@""];
    consent = [consent stringByAppendingString:timeStr];
    
    // 3. LastUpdated
    consent = [consent stringByAppendingString:timeStr];
    
    // 4. CmpId ... The ID assigned to the CMP
    int tmp = [self.txtCmpID.text intValue];
    NSString* CmpId = [self intToBinary:tmp withLength:12];         // 78-89
    consent = [consent stringByAppendingString:CmpId];              //@"000000000111"];
    
    // 5. CmpVersion ... Consent Manager Provider version for logging
    tmp = [self.txtCmpVersion.text intValue];
    NSString* CmpVersion = [self intToBinary:tmp withLength:12];    // 90-101
    consent = [consent stringByAppendingString:CmpVersion];         //@"000000000001"];
    
    // 6. ConsentScreen ... Screen number in the CMP where consent was given
    tmp = [self.txtConsentScreen.text intValue];
    NSString* ConsentScreen = [self intToBinary:tmp withLength:6];  // 102-107
    consent = [consent stringByAppendingString:ConsentScreen];      //@"000011"];
    
    // 7. ConsentLanguage ... Two-letter ISO639-1 language code that CMP asked for consent in
    NSString* ConsentLanguage = [self languageCodeToBinary:self.txtConsentLanguage.text];//108-119
    consent = [consent stringByAppendingString:ConsentLanguage];     //@"000100001101"]; // EN
    
    // 8. VendorListVersion ... The vendor list version at the time this consent string value was set
    tmp = [self.txtVendorListVersion.text intValue];
    NSString* VendorListVersion = [self intToBinary:tmp withLength:12];
    consent = [consent stringByAppendingString:VendorListVersion]; //@"000000001000"];
    
    // 9. PurposesAllowed ... // 132-155 ...24 bits
    NSString* PurposesAllowed = @"";
    
    PurposesAllowed = [PurposesAllowed stringByAppendingString: self.purpose1.on ? @"1" : @"0"];
    PurposesAllowed = [PurposesAllowed stringByAppendingString: self.purpose2.on ? @"1" : @"0"];
    PurposesAllowed = [PurposesAllowed stringByAppendingString: self.purpose3.on ? @"1" : @"0"];
    PurposesAllowed = [PurposesAllowed stringByAppendingString: self.purpose4.on ? @"1" : @"0"];
    PurposesAllowed = [PurposesAllowed stringByAppendingString: self.purpose5.on ? @"1" : @"0"];
    
    for(int i=0; i<24-5; i++)
    {
        PurposesAllowed = [PurposesAllowed stringByAppendingString: @"0"];
    }
    consent = [consent stringByAppendingString:PurposesAllowed];
    
    // 10. MaxVendorId ... Number of VendorIds in that vendor list ... 16 bits (156-171)
    int maxVendorId = [self.txtMaxVenderID.text intValue];
    NSString* strMaxVendorId = [self intToBinary:maxVendorId withLength:16];
    consent = [consent stringByAppendingString:strMaxVendorId];//@"0000011111011011"]; // 2011
    
    // ======
    if(self.segEncodingType.selectedSegmentIndex == 0)
    {
        // 11. EncodingType ... 1 bit (172) ...0=BitField
        consent = [consent stringByAppendingString:@"0"];
        
        consent = [consent stringByAppendingString:_bitFieldString]; // from delegate
    }
    else
    {
        // 11. EncodingType ... 1 bit (172) ... 1=Range
        consent = [consent stringByAppendingString:@"1"];

        consent = [consent stringByAppendingString:_rangeString]; // from delegate
    }
    
    // 16. fillbits ... The binary bits should be padded at the end with zeroes to the nearest multiple of 8 bits
    float len = (float)consent.length;
    float max = ceil(len / 8) * 8;
    int padding = max - len;
    
    for(int i=0; i<padding; i++)
    {
        consent = [consent stringByAppendingString:@"0"];
    }
    
    // debug
    NSString* output = [self convertIABString:consent];
    NSLog(@"%@", output);
    
    self.lblOutput.text = output;
}

- (IBAction)goAddBitField:(id)sender
{
    UIStoryboard* story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    BitFieldTableViewCtrl* ctrl = [story instantiateViewControllerWithIdentifier:@"BitFieldTableViewCtrl"];
    
    ctrl.maxVendorId    = [self.txtMaxVenderID.text intValue];
    ctrl.defaultActive  = self.swDefaultContent.on;
    ctrl.delegate       = self;
    
    [self.navigationController pushViewController:ctrl animated:YES];
}

- (IBAction)goAddRange:(id)sender
{
    UIStoryboard* story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RangeViewCtrl* ctrl = [story instantiateViewControllerWithIdentifier:@"RangeViewCtrl"];
    
    ctrl.maxVendorId    = [self.txtMaxVenderID.text intValue];
    ctrl.defaultActive  = self.swDefaultContent.on;
    ctrl.delegate       = self;
    
    [self.navigationController pushViewController:ctrl animated:YES];
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

// ISO639-1 language code ...A=0, B=1 ... Z= 25
-(NSString*)languageCodeToBinary:(NSString*)code
{
    if(code.length != 2)
        return nil;
    
    char ch1 = [code characterAtIndex:0];
    char ch2 = [code characterAtIndex:1];
    
    int n1 = ch1 - 'A';
    int n2 = ch2 - 'A';
    
    NSString * str1 = [self intToBinary:n1 withLength:6];
    NSString * str2 = [self intToBinary:n2 withLength:6];
    
    str1 = [str1 stringByAppendingString:str2];

    return str1;
}

// MARK: - delegate
-(void)receiveBitFieldString:(NSString*)str
{
    _bitFieldString = str;
}

-(void)receiveRangeString:(NSString*)str
{
    _rangeString = str;
}
@end
