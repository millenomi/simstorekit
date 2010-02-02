//
//  ILSimSKProductRequest.m
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimSKProductsRequest.h"
#import "ILSimSKProduct_Private.h"
#import "ILSimSKTiers.h"

@interface ILSimSKProductsRequest ()

@end

@interface ILSimSKProductsResponse ()
- (id) initWithProducts:(NSArray*) p invalidProductIdentifiers:(NSArray*) i;
@end


@implementation ILSimSKProductsRequest

+ (id) allocWithZone:(NSZone*) z;
{
	return [[self class] allocWithZone:z];
}

// Default behavior: none found.

- (id) initWithProductIdentifiers:(NSSet*) productIdentifiers;
{
	if (self = [super init]) {
		ids = [productIdentifiers copy];
	}
	
	return self;
}

@synthesize delegate;

- (void) dealloc
{
	[ids release];
	[super dealloc];
}


- (void) start;
{
	NSMutableArray* prods = [NSMutableArray array], * badIDs = [NSMutableArray array];
	
	for (NSString* ident in ids) {
		ILSimSKProduct* p = [[self class] simulatedProductForIdentifier:ident];
		if (p)
			[prods addObject:p];
		else
			[badIDs addObject:ident];
	}
	
	ILSimSKProductsResponse* r = [[[ILSimSKProductsResponse alloc] initWithProducts:prods invalidProductIdentifiers:badIDs] autorelease];
	
	[self.delegate productsRequest:self didReceiveResponse:r];
	if (!cancelled)
		[self.delegate requestDidFinish:self];
}

- (void) cancel;
{
	cancelled = YES;
}

+ (ILSimSKProduct*) simulatedProductForIdentifier:(NSString*) ident;
{
	NSString* productsFile = [[[NSProcessInfo processInfo] environment] objectForKey:@"ILSimSKProductsPlist"];
	NSDictionary* d = [NSDictionary dictionaryWithContentsOfFile:productsFile];
	
	NSDictionary* productData = [d objectForKey:ident];
	if (!productData)
		return nil;
	
	ILSimSKProduct* p = [[ILSimSKProduct new] autorelease];
	p.productIdentifier = ident;
	p.localizedTitle = [productData objectForKey:@"Title"];
	p.localizedDescription = [productData objectForKey:@"Description"];

	NSInteger i = [[productData objectForKey:@"Tier"] unsignedIntegerValue];
	p.price = ILSimSKPriceAtTierForCurrentStorefront(i);
	p.priceLocale = ILSimSKLocaleForCurrentStorefront();
	return p;
}

@end

@implementation ILSimSKProductsResponse

- (id) initWithProducts:(NSArray*) p invalidProductIdentifiers:(NSArray*) i;
{
	if (self = [super init]) {
		products = [p copy];
		invalidProductIdentifiers = [i copy];
	}
	
	return self;
}

@synthesize products, invalidProductIdentifiers;

- (void) dealloc
{
	[products release];
	[invalidProductIdentifiers release];
	[super dealloc];
}

@end
