
#import "Contact.h"

@interface Contact ()
@property(nonatomic, readwrite) NSString* firstName;
@property(nonatomic, readwrite) NSString* lastName;
@property(nonatomic, readwrite) NSString* homeAddress;
@property(nonatomic, readwrite) NSString* picture;
@property(nonatomic, strong) NSMutableArray* imagesFromPhone;
@property(nonatomic, readwrite) NSString* group;
@property(nonatomic, strong) NSMutableArray* phoneNumbers;
@property(nonatomic, strong) NSMutableArray* emails;
@property(nonatomic, readwrite) NSInteger currentNumber;
@property(nonatomic, readwrite) NSInteger groupNumber;




@end

@implementation Contact

- (instancetype)init
{
    return [self initWithFirstName:nil andLastName:nil andHomeAddress:nil andPicture:nil andGroup:nil];
}

- (instancetype)initWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName  andHomeAddress:(NSString*)address andPicture:(NSString*)picture andGroup:(NSString*)group
{
    self = [super init];
    if (self) {
        self.firstName = firstName;
        self.lastName = lastName;
        self.homeAddress = address;
        self.picture = picture;
        self.group = group;
        self.phoneNumbers = [NSMutableArray array];
        self.emails = [NSMutableArray array];
        self.imagesFromPhone = [NSMutableArray array];
        static NSInteger familyNumber = 0;
        static NSInteger friendNumber = 0;
        static NSInteger workNumber = 0;
        
        if ([self.group isEqualToString:@"Family"]) {
            self.currentNumber = familyNumber;
            self.groupNumber = 0;
            familyNumber++;
        }
        if ([self.group isEqualToString:@"Friend"]) {
            self.currentNumber = friendNumber;
            self.groupNumber = 1;
            friendNumber++;
        }
        if ([self.group isEqualToString:@"Work"]) {
            self.currentNumber = workNumber;
            self.groupNumber = 2;
            workNumber++;
        }       
        
    }
    return self;
}



+ (void)addToContact:(Contact*) contact firstName:(NSString*)firstName andLastName:(NSString*)lastName andHomeAddress:(NSString*)address andPicture:(NSString*)picture andGroup:(NSString*)group {
    contact.firstName = firstName;
    contact.lastName = lastName;
    contact.homeAddress = address;
    contact.group = group;
    contact.picture = picture;
    
}

-(void)setGroup:(NSString *)group {
    if ([group isEqualToString:@"Work"] || [group isEqualToString:@"Family"] || [group isEqualToString:@"Friend"]) {
        _group = group;
    }
}

- (BOOL)deletePhonNumberForRow:(NSInteger)row {
    if ([self.phoneNumbers count] > 1) {
         [self.phoneNumbers removeObjectAtIndex:row];
        return YES;
    }
    return NO;
}

- (BOOL)deleteEmailForRow:(NSInteger)row {
    if ([self.emails count] > 1) {
        [self.emails removeObjectAtIndex:row];
        return YES;
    }
    return NO;
}

- (void)addPhoneNumber:(NSString*)number {
    [self.phoneNumbers addObject:number];
}

- (void)addEmail:(NSString*)email {
    [self.emails addObject:email];
}

- (NSString*)lastNumber {
    if ([self.phoneNumbers count] > 0) {
        return [self.phoneNumbers objectAtIndex:([self.phoneNumbers count] - 1)];
    }
    return nil;
}
- (NSString*)lastEmail {
    if ([self.emails count]) {
        return [self.emails objectAtIndex:([self.emails count]-1)];
    }
    return nil;
}

- (NSInteger)emailsCount {
    return [self.emails count];
}

- (NSInteger)phoneNumbersCount {
    return [self.phoneNumbers count];
}

- (NSString*)giveNumberForRow:(NSInteger)row {
    return [self.phoneNumbers objectAtIndex:row];
}

- (NSString*)giveEmailForRow:(NSInteger)row {
    return [self.emails objectAtIndex:row];
}

-(void)addImageFromPhone:(NSArray*)images {
    [self.imagesFromPhone addObjectsFromArray:images];
}

- (id)giveImageFromPhone:(NSInteger)image {
    return [self.imagesFromPhone objectAtIndex:image];
}


@end
