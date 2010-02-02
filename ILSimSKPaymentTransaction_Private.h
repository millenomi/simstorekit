
#import "ILSimSKPaymentTransaction.h"

@interface ILSimSKPaymentTransaction ()

@property(nonatomic, setter=private_setError:, copy) NSError* error;
@property(nonatomic, setter=private_setOriginalTransaction:, retain) ILSimSKPaymentTransaction* originalTransaction;
@property(nonatomic, setter=private_setPayment:, copy) ILSimSKPayment* payment;
@property(nonatomic, setter=private_setTransactionDate:, copy) NSDate* transactionDate;
@property(nonatomic, setter=private_setTransactionIdentifier:, copy) NSString* transactionIdentifier;
@property(nonatomic, setter=private_setTransactionReceipt:, copy) NSData* transactionReceipt;
@property(nonatomic, setter=private_setTransactionState:, assign) ILSimSKPaymentTransactionState transactionState;

@end
