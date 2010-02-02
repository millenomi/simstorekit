//
//  ILSimSKTiers.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const kILSimStorefront_USD;
extern NSString* const kILSimStorefront_EUR;
extern NSString* const kILSimStorefront_CAD;
extern NSString* const kILSimStorefront_GBP;


extern NSString* ILSimSKCurrentStorefront();
extern void ILSimSKSetCurrentStorefront(NSString* s);

extern NSDictionary* ILSimSKAllTierPricesByStorefront();
extern NSDecimalNumber* ILSimSKPriceAtTierForCurrentStorefront(NSUInteger index);

extern NSLocale* ILSimSKLocaleForCurrentStorefront();

