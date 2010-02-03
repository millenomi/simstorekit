//
//  TestApp.m
//  SimStoreKit
//
//  Created by ∞ on 03/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TestApp.h"

@implementation TestApp

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
{
	[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
	[window makeKeyAndVisible];
	return YES;
}

- (IBAction) buy;
{
	SKProductsRequest* pr = [[SKProductsRequest alloc] initWithProductIdentifiers:
							 [NSSet setWithObject:@"TestItem"]
							 ];
	pr.delegate = self;
	[pr start];
}

- (void) productsRequest:(ILSimSKProductsRequest *)request didReceiveResponse:(ILSimSKProductsResponse *)response;
{
	if ([response.products count] == 0)
		return;
	
	SKProduct* p = [response.products objectAtIndex:0];
	SKPayment* pay = [SKPayment paymentWithProduct:p];
	[[SKPaymentQueue defaultQueue] addPayment:pay];
}

- (void) paymentQueue:(ILSimSKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
{
	NSLog(@"%@", transactions);
}

@end
