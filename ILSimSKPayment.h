//
//  ILSimSKPayment.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import <Foundation/Foundation.h>

@class ILSimSKProduct;

@interface ILSimSKPayment : NSObject <NSCopying, NSMutableCopying> {
	NSString* productIdentifier;
	NSInteger quantity;
	NSData* requestData;
}

+ paymentWithProduct:(ILSimSKProduct*) product;
+ paymentWithProductIdentifier:(NSString*) identifier;

@property(nonatomic, copy, readonly) NSString* productIdentifier;
@property(nonatomic, readonly) NSInteger quantity;
@property(nonatomic, copy, readonly) NSData* requestData;

@end

@interface ILSimSKMutablePayment : ILSimSKPayment {}

@property(nonatomic, copy) NSString* productIdentifier;
@property(nonatomic) NSInteger quantity;
@property(nonatomic, copy) NSData* requestData;

@end

#endif // #if kILSimAllowSimulatedStoreKit
