//
//  ILSimSKProduct.m
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import "ILSimSKProduct.h"
#import "ILSimSKProduct_Private.h"

@implementation ILSimSKProduct

@synthesize localizedDescription, localizedTitle, price, priceLocale, productIdentifier, simulatedProductType;

- (void) dealloc
{
	[localizedDescription release];
	[localizedTitle release];
	[price release];
	[priceLocale release];
	[productIdentifier release];
	[super dealloc];
}

@end

#endif // #if kILSimAllowSimulatedStoreKit
