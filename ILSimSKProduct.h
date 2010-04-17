//
//  ILSimSKProduct.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import <Foundation/Foundation.h>

typedef NSInteger ILSimSKSimulatedProductType;

@interface ILSimSKProduct : NSObject {
	NSString* localizedDescription, * localizedTitle;
	NSLocale* priceLocale;
	NSDecimalNumber* price;
	NSString* productIdentifier;
	ILSimSKSimulatedProductType simulatedProductType;
}

@property(nonatomic, readonly, copy) NSString* localizedDescription;
@property(nonatomic, readonly, copy) NSString* localizedTitle;

@property(nonatomic, readonly, retain) NSLocale* priceLocale;
@property(nonatomic, readonly, copy) NSDecimalNumber* price;

@property(nonatomic, readonly, copy) NSString* productIdentifier;

@end

#endif // #if kILSimAllowSimulatedStoreKit
