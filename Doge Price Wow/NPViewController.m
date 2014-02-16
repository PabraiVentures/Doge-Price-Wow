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
  NSString *restCallString = [NSString stringWithFormat:@"https://www.dogeapi.com/wow/?a=get_current_price" ];
  NSURL *restUrl=[NSURL URLWithString:restCallString];
  NSURLRequest *restRequest=[NSURLRequest requestWithURL:restUrl];
  
  
  /* if( currentConnection)
   {
   [currentConnection cancel];
   currentConnection = nil;
   //  self.apiReturnXMLData = nil;
   }*/
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end