//
//  ILSimSKPaymentQueue.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ILSimSKPayment.h"
#import "ILSimSKPaymentTransaction.h"

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
