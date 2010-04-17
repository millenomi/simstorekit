//
//  ILSimSKPaymentTransaction.h
//  SimStoreKit
//
//  Created by ∞ on 02/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ILSimStoreKit.h"
#if kILSimAllowSimulatedStoreKit


#import <Foundation/Foundation.h>

#import "ILSimSKPayment.h"

enum {
    kILSimSKPaymentTransactionStatePurchasing,    // Transaction is being added to the server queue.
    kILSimSKPaymentTransactionStatePurchased,     // Transaction is in queue, user has been charged.  Client should complete the transaction.
    kILSimSKPaymentTransactionStateFailed,        // Transaction was cancelled or failed before being added to the server queue.
    kILSimSKPaymentTransactionStateRestored       // Transaction was restored from user's purchase history.  Client should complete the transaction.
};
typedef NSInteger ILSimSKPaymentTransactionState;
	

@interface ILSimSKPaymentTransaction : NSObject {
	NSError* error;
	ILSimSKPaymentTransaction* originalTransaction;
	ILSimSKPayment* payment;
	NSDate* transactionDate;
	NSString* transactionIdentifier;
	NSData* transactionReceipt;
	ILSimSKPaymentTransactionState transactionState;
}

@property(nonatomic, readonly, copy) NSError* error;
@property(nonatomic, readonly, retain) ILSimSKPaymentTransaction* originalTransaction;
@property(nonatomic, readonly, copy) ILSimSKPayment* payment;
@property(nonatomic, readonly, copy) NSDate* transactionDate;
@property(nonatomic, readonly, copy) NSString* transactionIdentifier;
@property(nonatomic, readonly, copy) NSData* transactionReceipt;
@property(nonatomic, readonly, assign) ILSimSKPaymentTransactionState transactionState;

@end

#endif // #if kILSimAllowSimulatedStoreKit
