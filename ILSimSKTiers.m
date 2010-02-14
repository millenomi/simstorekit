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
NSString* const kILSimStorefront_JPY = @"JPY";

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
#define ILSimInt(x) \
	[NSDecimalNumber decimalNumberWithMantissa:(x) exponent:0 isNegative:NO]

NSDictionary* ILSimSKAllTierPricesByStorefront() {
	static NSDictionary* prices = nil; if (!prices)
		prices =
		[[NSDictionary alloc] initWithObjectsAndKeys:
		 [NSArray arrayWithObjects:
		  
		  // Tiers for Euro stores.
		  
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
		  ILSimDec(1699),
		  ILSimDec(1799),
		  ILSimDec(1849),
		  ILSimDec(1899),
		  ILSimDec(1999),
		  ILSimDec(2099),
		  ILSimDec(2149),
		  ILSimDec(2199),
		  ILSimDec(2299),
		  ILSimDec(2399),
		  ILSimDec(2499),
		  ILSimDec(2549),
		  ILSimDec(2599),
		  ILSimDec(2699),
		  ILSimDec(2799),
		  ILSimDec(2899),
		  ILSimDec(2949),
		  ILSimDec(2999),
		  ILSimDec(3099),
		  ILSimDec(3199),
		  ILSimDec(3299),
		  ILSimDec(3349),
		  ILSimDec(3399),
		  ILSimDec(3499),
		  ILSimDec(3599),
		  ILSimDec(3699),
		  ILSimDec(3749),
		  ILSimDec(3799),
		  ILSimDec(3899),
		  ILSimDec(3999),
		  ILSimDec(4299),
		  ILSimDec(4499),
		  ILSimDec(4999),
		  ILSimDec(5499),
		  ILSimDec(5999),
		  ILSimDec(6299),
		  ILSimDec(6499),
		  ILSimDec(6999),
		  ILSimDec(7499),
		  ILSimDec(7999),
		  ILSimDec(8499),
		  ILSimDec(8999),
		  ILSimDec(9499),
		  ILSimDec(9999),
		  ILSimDec(10999),
		  ILSimDec(11999),
		  ILSimDec(12499),
		  ILSimDec(12999),
		  ILSimDec(13999),
		  ILSimDec(14999),
		  ILSimDec(15999),
		  ILSimDec(16999),
		  ILSimDec(17999),
		  ILSimDec(18999),
		  ILSimDec(19999),
		  ILSimDec(23999),
		  ILSimDec(27999),
		  ILSimDec(31999),
		  ILSimDec(35999),
		  ILSimDec(39999),
		  ILSimDec(47999),
		  ILSimDec(55999),
		  ILSimDec(63999),
		  ILSimDec(71999),
		  ILSimDec(79999),
		  
		  nil], kILSimStorefront_EUR,
		 [NSArray arrayWithObjects:
		  
		  // Tiers for UK store.
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
		  ILSimDec(1249),
		  ILSimDec(1299),
		  ILSimDec(1399),
		  ILSimDec(1449),
		  ILSimDec(1499),
		  ILSimDec(1549),
		  ILSimDec(1599),
		  ILSimDec(1699),
		  ILSimDec(1749),
		  ILSimDec(1799),
		  ILSimDec(1849),
		  ILSimDec(1899),
		  ILSimDec(1999),
		  ILSimDec(2049),
		  ILSimDec(2099),
		  ILSimDec(2149),
		  ILSimDec(2199),
		  ILSimDec(2299),
		  ILSimDec(2349),
		  ILSimDec(2399),
		  ILSimDec(2449),
		  ILSimDec(2499),
		  ILSimDec(2599),
		  ILSimDec(2649),
		  ILSimDec(2699),
		  ILSimDec(2749),
		  ILSimDec(2799),
		  ILSimDec(2899),
		  ILSimDec(2949),
		  ILSimDec(2999),
		  ILSimDec(3299),
		  ILSimDec(3499),
		  ILSimDec(3799),
		  ILSimDec(3999),
		  ILSimDec(4299),
		  ILSimDec(4499),
		  ILSimDec(4999),
		  ILSimDec(5299),
		  ILSimDec(5499),
		  ILSimDec(5999),
		  ILSimDec(6499),
		  ILSimDec(6999),
		  ILSimDec(7499),
		  ILSimDec(7999),
		  ILSimDec(8499),
		  ILSimDec(8999),
		  ILSimDec(9499),
		  ILSimDec(9999),
		  ILSimDec(10999),
		  ILSimDec(11499),
		  ILSimDec(11999),
		  ILSimDec(12499),
		  ILSimDec(12999),
		  ILSimDec(13999),
		  ILSimDec(14999),
		  ILSimDec(17999),
		  ILSimDec(19999),
		  ILSimDec(23999),
		  ILSimDec(27999),
		  ILSimDec(29999),
		  ILSimDec(34999),
		  ILSimDec(39999),
		  ILSimDec(44999),
		  ILSimDec(49999),
		  ILSimDec(59999),		  
		  
		  nil], kILSimStorefront_GBP,
		 
		 // Tiers for Japan store
		 [NSArray arrayWithObjects:
		  [NSDecimalNumber zero],
		  ILSimInt(115),
		  ILSimInt(230),
		  ILSimInt(350),
		  ILSimInt(450),
		  ILSimInt(600),
		  ILSimInt(700),
		  ILSimInt(800),
		  ILSimInt(900),
		  ILSimInt(1000),
		  ILSimInt(1200),
		  ILSimInt(1300),
		  ILSimInt(1400),
		  ILSimInt(1500),
		  ILSimInt(1600),
		  ILSimInt(1700),
		  ILSimInt(1800),
		  ILSimInt(2000),
		  ILSimInt(2100),
		  ILSimInt(2200),
		  ILSimInt(2300),
		  ILSimInt(2400),
		  ILSimInt(2500),
		  ILSimInt(2600),
		  ILSimInt(2800),
		  ILSimInt(2900),
		  ILSimInt(3000),
		  ILSimInt(3100),
		  ILSimInt(3200),
		  ILSimInt(3300),
		  ILSimInt(3500),
		  ILSimInt(3600),
		  ILSimInt(3700),
		  ILSimInt(3800),
		  ILSimInt(3900),
		  ILSimInt(4000),
		  ILSimInt(4100),
		  ILSimInt(4300),
		  ILSimInt(4400),
		  ILSimInt(4500),
		  ILSimInt(4600),
		  ILSimInt(4700),
		  ILSimInt(4800),
		  ILSimInt(4900),
		  ILSimInt(5000),
		  ILSimInt(5200),
		  ILSimInt(5300),
		  ILSimInt(5400),
		  ILSimInt(5500),
		  ILSimInt(5600),
		  ILSimInt(5800),
		  ILSimInt(6000),
		  ILSimInt(7000),
		  ILSimInt(7500),
		  ILSimInt(8000),
		  ILSimInt(8500),
		  ILSimInt(9000),
		  ILSimInt(10000),
		  ILSimInt(10500),
		  ILSimInt(11000),
		  ILSimInt(11500),
		  ILSimInt(13000),
		  ILSimInt(14000),
		  ILSimInt(15000),
		  ILSimInt(16000),
		  ILSimInt(18000),
		  ILSimInt(19000),
		  ILSimInt(20000),
		  ILSimInt(21000),
		  ILSimInt(22000),
		  ILSimInt(23000),
		  ILSimInt(24000),
		  ILSimInt(25000),
		  ILSimInt(26000),
		  ILSimInt(27000),
		  ILSimInt(29000),
		  ILSimInt(35000),
		  ILSimInt(40000),
		  ILSimInt(45000),
		  ILSimInt(50000),
		  ILSimInt(58000),
		  ILSimInt(70000),
		  ILSimInt(80000),
		  ILSimInt(90000),
		  ILSimInt(100000),
		  ILSimInt(115000),
		  nil], kILSimStorefront_JPY,
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
	else if ([s isEqual:kILSimStorefront_JPY])
		l = @"ja_JP";
	
	NSCAssert(l, @"Unknown storefront");
	return [[[NSLocale alloc] initWithLocaleIdentifier:l] autorelease];
}
