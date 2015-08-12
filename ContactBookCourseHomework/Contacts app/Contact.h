
#import <Foundation/Foundation.h>

@interface Contact : NSObject
@property(nonatomic, readonly) NSString* firstName;
@property(nonatomic, readonly) NSString* lastName;
@property(nonatomic, readonly) NSString* homeAddress;
@property(nonatomic, readonly) NSString* picture;
@property(nonatomic, readonly) NSString* group;
@property(nonatomic, readonly) NSInteger currentNumber;
@property(nonatomic, readonly) NSInteger groupNumber;



- (instancetype)initWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName  andHomeAddress:(NSString*)address andPicture:(NSString*)picture andGroup:(NSString*)group;

- (void)addPhoneNumber:(NSString*)number;
- (void)addEmail:(NSString*)email;
- (NSString*)lastNumber;
- (NSString*)lastEmail;
- (NSInteger)emailsCount;
- (NSInteger)phoneNumbersCount;
- (NSString*)giveNumberForRow:(NSInteger)row;
- (NSString*)giveEmailForRow:(NSInteger)row;
- (BOOL)deletePhonNumberForRow:(NSInteger)row;
- (BOOL)deleteEmailForRow:(NSInteger)row;
+ (void)addToContact:(Contact*) contact firstName:(NSString*)firstName andLastName:(NSString*)lastName andHomeAddress:(NSString*)address andPicture:(NSString*)picture andGroup:(NSString*)group;
- (void)addImageFromPhone:(NSArray*)images;
- (id)giveImageFromPhone:(NSInteger)image;
@end
