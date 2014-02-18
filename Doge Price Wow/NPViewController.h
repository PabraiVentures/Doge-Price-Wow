//
//  NPViewController.h
//  Doge Price Wow
//
//  Created by Nathan Pabrai on 2/15/14.
//  Copyright (c) 2014 NathanPabrai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPViewController : UIViewController <NSURLConnectionDelegate>
{
  
  bool forward;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *BitDollSegControl;
@property (nonatomic,strong)NSMutableData* returnData;
@property (nonatomic,strong)  NSURLConnection* currentConnection;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextView *rateField;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
- (IBAction)convertAction:(id)sender;
- (IBAction)directionChangeAction:(id)sender;
- (IBAction)currChanged:(id)sender;

@end
