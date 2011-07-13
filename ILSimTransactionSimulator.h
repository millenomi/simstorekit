//
//  ILSimTransactionSimulator.h
//  SimStoreKit
//
//  Created by ∞ on 13/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#if kILSimAllowSimulatedStoreKit

#import "ILSimSKPaymentQueue.h"
#import "ILSimSKPaymentTransaction.h"
#import "ILSimSKProduct.h"

@protocol ILSimTransactionSimulator <NSObject>

- (void) simulateTransaction:(ILSimSKPaymentTransaction*)transaction product:(ILSimSKProduct*) product forQueue:(ILSimSKPaymentQueue*)queue completionHandler:(void (^)(NSError *))block;

@end

extern id <ILSimTransactionSimulator> ILSimDefaultTransactionSimulator();
#endif // kILSimAllowSimulatedStoreKit