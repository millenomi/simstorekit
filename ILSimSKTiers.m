//
//  ILSimSKTiers.m
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimSKTiers.h"
#import "ILSimSKPaymentQueue.h"

NSString* const kILSimStorefront_USD = @"USD";
NSString* const kILSimStorefront_EUR = @"EUR";
NSString* const kILSimStorefront_CAD = @"CAD";
NSString* const kILSimStorefront_GBP = @"GBP";

static NSString* storefront = nil;

static BOOL ILSimSKIsKnownStorefront(NSString* sf) {
	return [sf isEqual:kILSimStorefront_USD] || [sf isEqual:kILSimStorefront_CAD] ||
		[ILSimSKAllTierPricesByStorefront() objectForKey:sf] != nil;
}

NSString* ILSimSKCurrentStorefront() {
	if (!storefront) {
		NSString* e = [[[NSProcessInfo processInfo] environment] objectForKey:kILSimSKStorefrontCodeEnvironmentVariable];
		if (!e || !ILSimSKIsKnownStorefront(e))
			e = kILSimStorefront_USD;
		ILSimSKSetCurrentStorefront(e);
	}
	
	return storefront;
}
	
void ILSimSKSetCurrentStorefront(NSString* s) {
	if (storefront != s) {
		[storefront release];
		storefront = [s copy];
	}
}

#define ILSimDec(x) \
	[NSDecimalNumber decimalNumberWithMantissa:(x) exponent:-2 isNegative:NO]

NSDictionary* ILSimSKAllTierPricesByStorefront() {
	static NSDictionary* prices = nil; if (!prices)
		prices =
		[[NSDictionary alloc] initWithObjectsAndKeys:
		 [NSArray arrayWithObjects:
		  
		  [NSDecimalNumber zero],
		  ILSimDec(79),
		  ILSimDec(159),
		  ILSimDec(239),
		  ILSimDec(299),
		  ILSimDec(399),
		  ILSimDec(499),
		  ILSimDec(549),
		  ILSimDec(599),
		  ILSimDec(699),
		  ILSimDec(799),
		  ILSimDec(899),
		  ILSimDec(999),
		  ILSimDec(1049),
		  ILSimDec(1099),
		  ILSimDec(1199),
		  ILSimDec(1299),
		  ILSimDec(1399),
		  ILSimDec(1449),
		  ILSimDec(1499),
		  ILSimDec(1599),
		  
		  nil], kILSimStorefront_EUR,
		 [NSArray arrayWithObjects:
		  
		  [NSDecimalNumber zero],
		  ILSimDec(59),
		  ILSimDec(119),
		  ILSimDec(179),
		  ILSimDec(239),
		  ILSimDec(299),
		  ILSimDec(349),
		  ILSimDec(399),
		  ILSimDec(499),
		  ILSimDec(549),
		  ILSimDec(599),
		  ILSimDec(649),
		  ILSimDec(699),
		  ILSimDec(749),
		  ILSimDec(799),
		  ILSimDec(899),
		  ILSimDec(949),
		  ILSimDec(999),
		  ILSimDec(1099),
		  ILSimDec(1149),
		  ILSimDec(1199),
		  
		  nil], kILSimStorefront_GBP,
		 nil];
	
	return prices;
}

NSDecimalNumber* ILSimSKPriceAtTierForCurrentStorefront(NSUInteger index) {
	
	NSString* s = ILSimSKCurrentStorefront();
	
	if (index == 0)
		return [NSDecimalNumber zero];
	
	if ([s isEqual:kILSimStorefront_USD] || [s isEqual:kILSimStorefront_CAD])
		return ILSimDec(index * 100 - 1);
	else
		return [[ILSimSKAllTierPricesByStorefront() objectForKey:s] objectAtIndex:index];
}

NSLocale* ILSimSKLocaleForCurrentStorefront() {
	NSString* l = nil, * s = ILSimSKCurrentStorefront();
	
	if ([s isEqual:kILSimStorefront_USD])
		l = @"en_US";
	else if ([s isEqual:kILSimStorefront_CAD])
		l = @"en_CA";
	else if ([s isEqual:kILSimStorefront_EUR])
		l = @"it_IT";
	else if ([s isEqual:kILSimStorefront_GBP])
		l = @"en_GB";
	
	NSCAssert(l, @"Unknown storefront");
	return [[[NSLocale alloc] initWithLocaleIdentifier:l] autorelease];
}
