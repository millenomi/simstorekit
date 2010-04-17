//
//  ILSimSKPaymentTransaction.m
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import "ILSimSKPaymentTransaction.h"
#import "ILSimSKPaymentTransaction_Private.h"


@implementation ILSimSKPaymentTransaction

@synthesize error;
@synthesize originalTransaction;
@synthesize payment;
@synthesize transactionDate;
@synthesize transactionIdentifier;
@synthesize transactionReceipt;
@synthesize transactionState;

- (void) dealloc
{
	[error release];
	[originalTransaction release];
	[payment release];
	[transactionDate release];
	[transactionIdentifier release];
	[transactionReceipt release];
	[super dealloc];
}

@end

#endif // #if kILSimAllowSimulatedStoreKit
