//
//  ILSimSKPayment.m
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import "ILSimSKPayment.h"
#import "ILSimSKProduct.h"

@interface ILSimSKPayment ()

- (id) initWithProductIdentifier:(NSString*) pid;

@property(nonatomic, copy, setter=private_setProductIdentifier:) NSString* productIdentifier;
@property(nonatomic, setter=private_setQuantity:) NSInteger quantity;
@property(nonatomic, copy, setter=private_setRequestData:) NSData* requestData;

- (id) copyWithZone:(NSZone *)zone class:(Class) c;

@end



@implementation ILSimSKPayment

- (id) initWithProductIdentifier:(NSString*) pid;
{
	if (self = [super init]) {
		productIdentifier = [pid copy];
		quantity = 1;
	}
	
	return self;
}

- (void) dealloc
{
	[productIdentifier release];
	[requestData release];
	[super dealloc];
}

- (id) copyWithZone:(NSZone *)zone class:(Class) c;
{
	ILSimSKPayment* p = [[c allocWithZone:zone] init];
	p.productIdentifier = productIdentifier;
	p.quantity = quantity;
	p.requestData = requestData;
	return p;
}

- (id) copyWithZone:(NSZone *)zone;
{
	return [self copyWithZone:zone class:[ILSimSKPayment class]];
}

- (id) mutableCopyWithZone:(NSZone *)zone;
{
	return [self copyWithZone:zone class:[ILSimSKMutablePayment class]];
}

+ paymentWithProduct:(ILSimSKProduct*) product;
{
	return [[[self alloc] initWithProductIdentifier:product.productIdentifier] autorelease];
}

+ paymentWithProductIdentifier:(NSString*) identifier;
{
	return [[[self alloc] initWithProductIdentifier:identifier] autorelease];	
}

@synthesize productIdentifier;
@synthesize quantity;
@synthesize requestData;

@end


@implementation ILSimSKMutablePayment

@dynamic quantity;
- (void) setQuantity:(NSInteger) q;
{
	[self private_setQuantity:q];
}

@dynamic productIdentifier;
- (void) setProductIdentifier:(NSString *) p;
{
	[self private_setProductIdentifier:p];
}

@dynamic requestData;
- (void) setRequestData:(NSData *) d;
{
	[self private_setRequestData:d];
}

@end

#endif // #if kILSimAllowSimulatedStoreKit
