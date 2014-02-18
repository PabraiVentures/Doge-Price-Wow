//
//  NPViewController.m
//  Doge Price Wow
//
//  Created by Nathan Pabrai on 2/15/14.
//  Copyright (c) 2014 NathanPabrai. All rights reserved.
//

#import "NPViewController.h"


@implementation NPViewController


-(void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                 initWithTarget:self
                                 action:@selector(dismissKeyboard)];
  
  [self.view addGestureRecognizer:tap];
  
  NSString *restCallString;
  self->forward=true;
  if (self.BitDollSegControl.selectedSegmentIndex == 0){
    restCallString = [NSString stringWithFormat:@"https://www.dogeapi.com/wow/?a=get_current_price" ];
  }
  
  else{
    
    restCallString = [NSString stringWithFormat:@"https://www.dogeapi.com/wow/?a=get_current_price&convert_to=BTC" ];

  }
  
  NSURL *restUrl=[NSURL URLWithString:restCallString];
  NSURLRequest *restRequest=[NSURLRequest requestWithURL:restUrl];
  
  
  if(self.currentConnection)
   {
     [self.currentConnection cancel];
     self.currentConnection = nil;
     self.returnData=nil;   }
  self.currentConnection= [[NSURLConnection alloc]initWithRequest:restRequest delegate:self];
  self.returnData=[NSMutableData data];
  
  
}



-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response{
  [self.returnData setLength:0];
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data{
  [self.returnData appendData:data];
}

-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
  NSLog(@"REST request failed: %@",error);
  self.currentConnection=nil;
}
-(void)connectionDidFinishLoading:(NSURLConnection*)connection{
  self.currentConnection=nil;
  
  NSString *returnString = [[NSString alloc] initWithData:self.returnData encoding:NSUTF8StringEncoding];
  NSLog(@"Results: %@" ,returnString);
  
  //DOLLAR MODE
  if (self.BitDollSegControl.selectedSegmentIndex == 0){
    if (self->forward){
      
    [  self.rateField setText:[NSString stringWithFormat:@"$%.2f is worth:\n%f dogecoin", self.amountField.text.floatValue, self.amountField.text.floatValue/returnString.floatValue]];
      
    }
    else{
      [  self.rateField setText:[NSString stringWithFormat:@"%.f dogecoin is worth:\n$%.2f ",self.amountField.text.floatValue, self.amountField.text.floatValue*returnString.floatValue]];
      
    }
    
  }
  //BITCOIN MODE
  else{
    if (self->forward){
      
      [  self.rateField setText:[NSString stringWithFormat:@"%.6fBTC is worth:\n%f dogecoin", self.amountField.text.floatValue, self.amountField.text.floatValue/returnString.floatValue]];
      
    }
    else{
      [  self.rateField setText:[NSString stringWithFormat:@"%.f dogecoin is worth:\n%.6fBTC ",self.amountField.text.floatValue, self.amountField.text.floatValue*returnString.floatValue]];
      
    }
    
  }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)convertAction:(id)sender {
  
  if (self->forward){
    
    if(self.BitDollSegControl.selectedSegmentIndex==0){
      self.typeLabel.text=@"US Dollars";
      
    }
    else self.typeLabel.text=@"Bitcoin";
  }else self.typeLabel.text=@"Dogecoin";
  if(self.amountField.text.floatValue==0)return;
  [self.amountField resignFirstResponder];

  NSString *restCallString;
  
  if (self.BitDollSegControl.selectedSegmentIndex == 0){
    restCallString = [NSString stringWithFormat:@"https://www.dogeapi.com/wow/?a=get_current_price" ];
  }
  
  else{
    
    restCallString = [NSString stringWithFormat:@"https://www.dogeapi.com/wow/?a=get_current_price&convert_to=BTC" ];
    
  }
  
  NSURL *restUrl=[NSURL URLWithString:restCallString];
  NSURLRequest *restRequest=[NSURLRequest requestWithURL:restUrl];
  
  
  if(self.currentConnection)
  {
    [self.currentConnection cancel];
    self.currentConnection = nil;
    self.returnData=nil;   }
  self.currentConnection= [[NSURLConnection alloc]initWithRequest:restRequest delegate:self];
  self.returnData=[NSMutableData data];
  
  
}
- (IBAction)directionChangeAction:(id)sender {
  
  
  self->forward=(!self->forward);
  if (self->forward){
    
    if(self.BitDollSegControl.selectedSegmentIndex==0){
      self.typeLabel.text=@"US Dollars";
      
    }
    else self.typeLabel.text=@"Bitcoin";
  }else self.typeLabel.text=@"Dogecoin";


  UIImage* bimage;
  if(self->forward){
    bimage=[UIImage imageNamed:@"forward.png"];
  }
  else{
    bimage=[UIImage imageNamed:@"back.png"];
  }
  [((UIButton*)sender) setImage:bimage forState:UIControlStateNormal];
  
}

- (IBAction)currChanged:(id)sender {
  if (self->forward){
    
    if(self.BitDollSegControl.selectedSegmentIndex==0){
      self.typeLabel.text=@"US Dollars";
      
    }
    else self.typeLabel.text=@"Bitcoin";
  }else self.typeLabel.text=@"Dogecoin";
}
-(void)dismissKeyboard{
  
  [self.amountField resignFirstResponder];
}
@end