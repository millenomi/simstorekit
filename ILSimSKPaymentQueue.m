//
//  ILSimSKPaymentQueue.m
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ILSimSKPaymentQueue.h"
#import "ILSimSKPaymentTransaction_Private.h"
#import "ILSimSKProductsRequest.h"
#import "ILSimSKProduct_Private.h"

#define kILSimSKErrorDomain @"net.infinite-labs.SimulatedStoreKit"
enum {
	kILSimSimulatedFailure,
	kILSimNoSuchProduct,
	kILSimCannotMakeReceipt,
};

@interface ILSimSKPaymentQueue () <UIAlertViewDelegate>

@property(nonatomic, retain) ILSimSKPaymentTransaction* currentTransaction;

- (void) ask;
- (void) succeed;
- (void) fail:(NSError *)e;

@end


@implementation ILSimSKPaymentQueue

+ (BOOL) canMakePayments;
{
	return [[[[NSProcessInfo processInfo] environment] objectForKey:@"ILSimSKCanMakePayments"] boolValue];
}

- (id) init
{
	self = [super init];
	if (self != nil) {
		observers = [NSMutableSet new];
		transactions = [NSMutableArray new];
	}
	return self;
}

@synthesize currentTransaction;

- (void) dealloc
{
	[observers release];
	[transactions release];
	[currentTransaction release];
	[super dealloc];
}

+ (ILSimSKPaymentQueue*) defaultQueue;
{
	static id me = nil; if (!me)
		me = [self new];
	
	return me;
}


- (void) addPayment:(ILSimSKPayment*) p;
{
	ILSimSKPaymentTransaction* t = [[ILSimSKPaymentTransaction new] autorelease];
	t.transactionState = kILSimSKPaymentTransactionStatePurchasing;
	t.payment = p;
	t.transactionDate = [NSDate date];
	
	[transactions addObject:t];
	
	if ([observers count] > 0)
		[self performSelector:@selector(processNextTransaction) withObject:nil afterDelay:2.0];
}

- (void) processNextTransaction;
{
	if (self.currentTransaction)
		return;
	
	if ([transactions count] == 0)
		return;
	
	self.currentTransaction = [transactions objectAtIndex:0];
	
	self.currentTransaction.transactionState = kILSimSKPaymentTransactionStatePurchasing;
	for (id <ILSimSKPaymentTransactionObserver> o in observers)
		[o paymentQueue:self updatedTransactions:[NSArray arrayWithObject:self.currentTransaction]];
	
	srandomdev();
	long l = random();
	self.currentTransaction.transactionIdentifier = [NSString stringWithFormat:@"%xl", l];
	
	NSString* action = [[[NSProcessInfo processInfo] environment] objectForKey:@"ILSimSKTransactionResult"];
	
	if ([action isEqual:@"AlwaysSucceed"])
		[self succeed];
	else if ([action isEqual:@"AlwaysFail"])
		[self fail:[NSError errorWithDomain:kILSimSKErrorDomain code:kILSimSimulatedFailure userInfo:nil]];
	else
		[self ask];
}

- (void) ask;
{	
	ILSimSKProduct* p = [ILSimSKProductsRequest simulatedProductForIdentifier:self.currentTransaction.payment.productIdentifier];
	
	if (!p)
		[self fail:[NSError errorWithDomain:kILSimSKErrorDomain code:kILSimNoSuchProduct userInfo:nil]];
	else {
		UIAlertView* a = [[UIAlertView new] autorelease];
		a.delegate = self;
		
		NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
		[numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
		[numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		[numberFormatter setLocale:p.priceLocale];
		NSString* formattedPrice = [numberFormatter stringFromNumber:p.price];
		
		a.title = [NSString stringWithFormat:@"SIMULATED: Would you like to buy %d x '%@' at %@?", self.currentTransaction.payment.quantity, p.localizedTitle, formattedPrice];
		[a addButtonWithTitle:@"Succeed Transaction"];
		[a addButtonWithTitle:@"Fail Transaction"];
		a.cancelButtonIndex = [a addButtonWithTitle:@"Cancel"];
		[a show];
	}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
	switch (buttonIndex) {
		case 0:
			[self succeed];
			break;
		case 1:
			[self fail:[NSError errorWithDomain:kILSimSKErrorDomain code:kILSimSimulatedFailure userInfo:nil]];
		case 2:
		default:
			[self fail:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
			break;
	}
}

- (void) succeed;
{
	ILSimSKProduct* p = [ILSimSKProductsRequest simulatedProductForIdentifier:self.currentTransaction.payment.productIdentifier];
	
	NSDictionary* r = [NSDictionary dictionaryWithObjectsAndKeys:
					   p.productIdentifier, @"ProductID",
					   [NSNumber numberWithInteger:self.currentTransaction.payment.quantity], @"Quantity",
					   self.currentTransaction.transactionIdentifier, @"TransactionID",
					   [NSNumber numberWithInteger:p.simulatedProductType], @"ProductType",
					   self.currentTransaction.transactionDate, @"Date",
					   nil];
	
	NSString* err = nil;
	NSData* d = [NSPropertyListSerialization dataFromPropertyList:r format:NSPropertyListBinaryFormat_v1_0 errorDescription:&err];
	if (d)
		self.currentTransaction.transactionReceipt = d;
	else {
		if (err) {
			NSLog(@"%@", err);
			[err release];
		}
		
		[self fail:[NSError errorWithDomain:kILSimSKErrorDomain code:kILSimCannotMakeReceipt userInfo:nil]];
		return;
	}
	
	self.currentTransaction.transactionState = kILSimSKPaymentTransactionStatePurchased;

	NSMutableArray* a = [[[[NSUserDefaults standardUserDefaults] arrayForKey:@"ILSimSKTransactions"] mutableCopy] autorelease];
	if (!d)
		a = [NSMutableArray array];
	
	[a addObject:r];
	[[NSUserDefaults standardUserDefaults] setObject:a forKey:@"ILSimSKTransactions"];
	
	for (id <ILSimSKPaymentTransactionObserver> o in observers)
		[o paymentQueue:self updatedTransactions:[NSArray arrayWithObject:self.currentTransaction]];
}

- (void) fail:(NSError*) e;
{
	self.currentTransaction.error = e;
	self.currentTransaction.transactionState = kILSimSKPaymentTransactionStateFailed;
	for (id <ILSimSKPaymentTransactionObserver> o in observers)
		[o paymentQueue:self updatedTransactions:[NSArray arrayWithObject:self.currentTransaction]];
}

- (void) finishTransaction:(ILSimSKPaymentTransaction*) t;
{
	if ([transactions count] > 0 && self.currentTransaction == [transactions objectAtIndex:0])
		[transactions removeObjectAtIndex:0];
	
	for (id <ILSimSKPaymentTransactionObserver> o in observers) {
		if ([o respondsToSelector:@selector(paymentQueue:removedTransactions:)])
			[o paymentQueue:self removedTransactions:[NSArray arrayWithObject:self.currentTransaction]];
	}
	
	self.currentTransaction = nil;
	
	if ([observers count] > 0)
		[self performSelector:@selector(processNextTransaction) withObject:nil afterDelay:2.0];
}

- (void) restoreCompletedTransactions;
{
	srandomdev();
	
	NSMutableArray* a = [NSMutableArray array];
	
	for (id d in [[NSUserDefaults standardUserDefaults] arrayForKey:@"ILSimSKTransactions"]) {
		if (![d isKindOfClass:[NSDictionary class]])
			continue;
		
		id kind = [d objectForKey:@"ProductType"];
		if (!kind || ![kind isKindOfClass:[NSNumber class]] || [kind integerValue] != kILSimSimulatedProductTypeNonConsumable)
			continue;
		
		ILSimSKPaymentTransaction* t = [[ILSimSKPaymentTransaction new] autorelease];
		t.transactionDate = [NSDate date];
		t.transactionState = kILSimSKPaymentTransactionStateRestored;
		t.transactionIdentifier = [NSString stringWithFormat:@"%lx", random()];
		
		ILSimSKPaymentTransaction* original = [[ILSimSKPaymentTransaction new] autorelease];
		original.transactionDate = [d objectForKey:@"TransactionDate"];
		original.transactionIdentifier = [d objectForKey:@"TransactionID"];
		
		ILSimSKMutablePayment* p = [ILSimSKMutablePayment paymentWithProductIdentifier:[d objectForKey:@"ProductID"]];
		p.quantity = [[d objectForKey:@"Quantity"] integerValue];
		original.payment = p;
		
		t.originalTransaction = original;
		
		[a addObject:t];
	}
	
	if ([a count] > 0) {
		for (id <ILSimSKPaymentTransactionObserver> o in observers)
			[o paymentQueue:self updatedTransactions:a];
	}
	
	for (id <ILSimSKPaymentTransactionObserver> o in observers) {
		if ([o respondsToSelector:@selector(paymentQueueRestoreCompletedTransactionsFinished:)])
			[o paymentQueueRestoreCompletedTransactionsFinished:self];
	}
}

- (void) addTransactionObserver:(id <ILSimSKPaymentTransactionObserver>) o;
{
	[observers addObject:o];
	[self processNextTransaction];
}

- (void) removeTransactionObserver:(id <ILSimSKPaymentTransactionObserver>) o;
{
	[observers removeObject:o];
	// TODO stop processing
}

- (NSArray*) transactions;
{
	return transactions;
}

@end
