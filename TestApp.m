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
	setenv("ILSimSKProductsPlist", [[[NSBundle mainBundle] pathForResource:@"Products" ofType:@"plist"] fileSystemRepresentation], 1);
	
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

- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response;
{
	if ([response.products count] == 0)
		return;
	
	SKProduct* p = [response.products objectAtIndex:0];
	SKPayment* pay = [SKPayment paymentWithProduct:p];
	[[SKPaymentQueue defaultQueue] addPayment:pay];
}

- (void) paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
{
	NSLog(@"%@", transactions);
	
	for (SKPaymentTransaction* t in transactions) {
		if (t.transactionState == SKPaymentTransactionStatePurchased || t.transactionState == SKPaymentTransactionStateFailed) {
			NSLog(@"%@ -> state %d", t, t.transactionState);
			[queue finishTransaction:t];
		}
	}
}

@end
