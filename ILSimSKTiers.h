//
//  ILSimSKTiers.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import <Foundation/Foundation.h>

// The string values of these constants are the currency codes just after the _ (for example, @"USD" for kILSimStorefront_USD).
extern NSString* const kILSimStorefront_EUR;
extern NSString* const kILSimStorefront_NZD;
extern NSString* const kILSimStorefront_DKK;
extern NSString* const kILSimStorefront_AUD;
extern NSString* const kILSimStorefront_MXP;
extern NSString* const kILSimStorefront_CAD;
extern NSString* const kILSimStorefront_USD;
extern NSString* const kILSimStorefront_JPY;
extern NSString* const kILSimStorefront_GBP;
extern NSString* const kILSimStorefront_NOK;


extern NSString* ILSimSKCurrentStorefront();
extern void ILSimSKSetCurrentStorefront(NSString* s);

extern NSDictionary* ILSimSKAllTierPricesByStorefront();
extern NSDecimalNumber* ILSimSKPriceAtTierForCurrentStorefront(NSUInteger index);

extern NSLocale* ILSimSKLocaleForCurrentStorefront();

#endif // #if kILSimAllowSimulatedStoreKit
