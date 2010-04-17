//
//  ILSimSKPaymentQueue.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import <Foundation/Foundation.h>
#import "ILSimSKPayment.h"
#import "ILSimSKPaymentTransaction.h"

// ENVIRONMENT VARIABLES THAT CHANGE THIS CLASS'S BEHAVIOR:

// if -boolValue == NO, the user cannot make payments.
// Defaults to YES if missing.
#define kILSimSKCanMakePaymentsEnvironmentVariable @"ILSimSKCanMakePayments"

// the path to a plist file containing simulated store product info info.
// format:
// dict {
//	any number of @"<product code>" => dict {
//		@"Title" => @"<product title>";
//		@"Description" => @"<guess>";
//		@"Tier" => int(<a price tier, eg 1 for $0.99. 0 (free) is not a valid tier in IAP>);
//		@"ProductType" => int(<0 means nonconsumable, 1 consumable, 2 subscription>);
//	}
// }
#define kILSimSKProductsPlistEnvironmentVariable @"ILSimSKProductsPlist"

// the storefront to use.
// Use a currency symbol for the storefront -- f. ex. "USD" is the USA storefront, "EUR" an Euro-using storefront etc.
// Default is USD.
#define kILSimSKStorefrontCodeEnvironmentVariable @"ILSimSKStorefrontCode"


extern NSString* const kILSimSKErrorDomain;

enum {
	// doubles from SKErrorDomain
	kILSimSKErrorUnknown,
	kILSimSKErrorClientInvalid,
	kILSimSKErrorPaymentCancelled,
	kILSimSKErrorPaymentInvalid,
	kILSimSKErrorPaymentNotAllowed,
};


@protocol ILSimSKPaymentTransactionObserver;


@interface ILSimSKPaymentQueue : NSObject {
	NSMutableSet* observers;
	NSMutableArray* transactions;
	
	ILSimSKPaymentTransaction* currentTransaction;
}

+ (BOOL) canMakePayments;

+ (ILSimSKPaymentQueue*) defaultQueue;

- (void) addPayment:(ILSimSKPayment*) p;
- (void) addTransactionObserver:(id <ILSimSKPaymentTransactionObserver>) o;
- (void) removeTransactionObserver:(id <ILSimSKPaymentTransactionObserver>) o;

- (void) finishTransaction:(ILSimSKPaymentTransaction*) t;

- (void) restoreCompletedTransactions;

@property(nonatomic, readonly) NSArray* transactions;

@end


@protocol ILSimSKPaymentTransactionObserver <NSObject>
@required
- (void) paymentQueue:(ILSimSKPaymentQueue*) queue updatedTransactions:(NSArray*) transactions;

@optional
- (void) paymentQueue:(ILSimSKPaymentQueue*) queue removedTransactions:(NSArray*) transactions;

- (void) paymentQueue:(ILSimSKPaymentQueue*) queue restoreCompletedTransactionsFailedWithError:(NSError*) e;

- (void) paymentQueueRestoreCompletedTransactionsFinished:(ILSimSKPaymentQueue*) queue;

@end

#endif // #if kILSimAllowSimulatedStoreKit
