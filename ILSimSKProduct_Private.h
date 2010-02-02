
#import "ILSimSKProduct.h"

@interface ILSimSKProduct ()

@property(nonatomic, setter=private_setLocalizedDescription:, copy) NSString* localizedDescription;
@property(nonatomic, setter=private_setLocalizedTitle:, copy) NSString* localizedTitle;

@property(nonatomic, setter=private_setLocalizedPriceLocale:, retain) NSLocale* priceLocale;
@property(nonatomic, setter=private_setPrice:, copy) NSDecimalNumber* price;

@property(nonatomic, setter=private_setProductIdentifier:, copy) NSString* productIdentifier;

@end
