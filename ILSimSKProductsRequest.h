//
//  ILSimSKProductRequest.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import <Foundation/Foundation.h>

#import "ILSimSKRequest.h"

@protocol ILSimSKProductsRequestDelegate;

@interface ILSimSKProductsRequest : ILSimSKRequest {
	id <ILSimSKProductsRequestDelegate> delegate;
	BOOL cancelled;
	NSSet* ids;
}

- (id) initWithProductIdentifiers:(NSSet*) productIdentifiers;
@property(assign) id <ILSimSKProductsRequestDelegate> delegate;

+ (ILSimSKProduct*) simulatedProductForIdentifier:(NSString*) ident;

@end

@interface ILSimSKProductsResponse : NSObject {
	NSArray* invalidProductIdentifiers;
	NSArray* products;
}

@property(nonatomic, readonly) NSArray* invalidProductIdentifiers;
@property(nonatomic, readonly) NSArray* products;

@end




@protocol ILSimSKProductsRequestDelegate <ILSimSKRequestDelegate>

- (void) productsRequest:(ILSimSKProductsRequest*) request didReceiveResponse:(ILSimSKProductsResponse*) response;

@end

#endif // #if kILSimAllowSimulatedStoreKit
