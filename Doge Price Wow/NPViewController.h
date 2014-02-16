//
//  NPViewController.h
//  Doge Price Wow
//
//  Created by Nathan Pabrai on 2/15/14.
//  Copyright (c) 2014 NathanPabrai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPViewController : UIViewController <NSURLConnectionDelegate>
@property (nonatomic,strong)NSMutableData* returnData;
@property (nonatomic,strong)  NSURLConnection* currentConnection;
@end
