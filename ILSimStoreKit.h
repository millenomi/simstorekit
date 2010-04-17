
#if !defined(kILSimAllowSimulatedStoreKit) && TARGET_IPHONE_SIMULATOR
#define kILSimAllowSimulatedStoreKit 1
#endif

#if kILSimAllowSimulatedStoreKit

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

		#define SKErrorDomain kILSimSKErrorDomain
		#define SKErrorUnknown kILSimSKErrorUnknown 
		#define SKErrorClientInvalid kILSimSKErrorClientInvalid 
		#define SKErrorPaymentCancelled kILSimSKErrorPaymentCancelled 
		#define SKErrorPaymentInvalid kILSimSKErrorPaymentInvalid 
		#define SKErrorPaymentNotAllowed kILSimSKErrorPaymentNotAllowed 

	#endif

#endif