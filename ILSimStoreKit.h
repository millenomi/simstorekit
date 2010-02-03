
#import "ILSimSKTiers.h"
#import "ILSimSKPaymentTransaction.h"
#import "ILSimSKProductsRequest.h"
#import "ILSimSKPaymentQueue.h"
#import "ILSimSKRequest.h"
#import "ILSimSKPayment.h"
#import "ILSimSKProduct.h"

#if ILSimReplaceRealStoreKit

#define SKPaymentTransaction ILSimSKPaymentTransaction
#define SKProductsRequest ILSimSKProductsRequest
#define SKPaymentQueue ILSimSKPaymentQueue
#define SKRequest ILSimSKRequest
#define SKProduct ILSimSKProduct
#define SKPayment ILSimSKPayment
#define SKProductsRequestDelegate ILSimSKProductsRequestDelegate
#define SKPaymentTransactionObserver ILSimSKPaymentTransactionObserver
#define SKRequestDelegate ILSimSKRequestDelegate
#define SKProductsResponse ILSimSKProductsResponse

#define SKPaymentTransactionStatePurchased kILSimSKPaymentTransactionStatePurchased
#define SKPaymentTransactionStateFailed kILSimSKPaymentTransactionStateFailed
#define SKPaymentTransactionStatePurchasing kILSimSKPaymentTransactionStatePurchasing
#define SKPaymentTransactionStateRestored kILSimSKPaymentTransactionStateRestored

#endif
