//
//  ILSimSKProduct.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ILSimSKProduct : NSObject {
	NSString* localizedDescription, * localizedTitle;
	NSLocale* priceLocale;
	NSDecimalNumber* price;
	NSString* productIdentifier;
}

@property(nonatomic, readonly, copy) NSString* localizedDescription;
@property(nonatomic, readonly, copy) NSString* localizedTitle;

@property(nonatomic, readonly, retain) NSLocale* priceLocale;
@property(nonatomic, readonly, copy) NSDecimalNumber* price;

@property(nonatomic, readonly, copy) NSString* productIdentifier;

@end

