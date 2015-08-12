
#import "ContactsBook.h"
#import "Contact.h"

@interface ContactsBook ()
@property(nonatomic) NSMutableArray* allContacts;
@property(nonatomic) NSMutableArray* groups;
@end
@implementation ContactsBook

+(instancetype)sharedInstance {
    static ContactsBook* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[super alloc] init];
    });
    return instance;
}

+(instancetype)alloc {
    return [ContactsBook sharedInstance];
}

-(id)copy {
    return [ContactsBook sharedInstance];
}

- (NSInteger)numberOfGroups {
    return 3;
}

- (NSInteger)numbersOfContactsInSection:(NSInteger)section {    
   NSInteger counter = 0;
    for (Contact* contact in self.allContacts) {
        if (contact.groupNumber == section ) {
            counter++;
        }
    }
    return counter;

}

- (Contact*)returnContactForRow:(NSInteger)row {
    return [self.allContacts objectAtIndex:row];
    
}

- (Contact*)returnContactForSection:(NSInteger)section andRow:(NSInteger)row {
    for (Contact* contact in self.allContacts) {
        if (contact.groupNumber == section && contact.currentNumber == row) {
            return contact;
        }
    }
    return nil;
}

- (NSString*)returnGroupNameForSection:(NSInteger)section {
    if (section >= 0) {
        for (Contact* contact in self.allContacts) {
            if (contact.groupNumber == section) {
                return contact.group;
            }
        }
    }
    return nil;
}

-(void)deleteRow:(NSInteger)row inSection:(NSInteger)section {
    for (Contact* contact in self.allContacts) {
        if (contact.groupNumber == section && contact.currentNumber == row) {
            [self.allContacts removeObject:contact];
        }
    }
}

- (NSInteger) giveInfoForContactEmails:(NSInteger)section andRow:(NSInteger)row {
    for (Contact* contact in self.allContacts) {
        if (contact.groupNumber == section && contact.currentNumber == row) {
            return [contact emailsCount];
        }
    }
    return 0;
}

- (NSInteger) giveInfoForContactPhoneNumbers:(NSInteger)section andRow:(NSInteger)row {
       for (Contact* contact in self.allContacts) {
        if (contact.groupNumber == section && contact.currentNumber == row) {
            return [contact phoneNumbersCount];
        }
    }
    
    return 0;
}

-(void)arange {
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
    NSMutableArray* arangedContacts = [NSMutableArray arrayWithArray:[self.allContacts sortedArrayUsingDescriptors:@[sort]]];
    self.allContacts = arangedContacts;   

}


- (void) addContact:(Contact*)contact {
    [self.allContacts addObject:contact];
    
}

- (NSInteger)allContactsCount {
    return [self.allContacts count];
}



-(NSMutableArray*)allContacts {
    if (_allContacts == nil) {
        self.allContacts = [NSMutableArray array];
        Contact* demo = [[Contact alloc]initWithFirstName:@"Gancho" andLastName:@"Ganchev" andHomeAddress:@"address" andPicture:@"fun.jpg" andGroup:@"Friend"];
        [demo addEmail:@"test@abv.bg"];
        [demo addPhoneNumber:@"0888997766"];
        Contact* demo1 = [[Contact alloc]initWithFirstName:@"Mancho" andLastName:@"Ganchev" andHomeAddress:@"address" andPicture:@"fun.jpg" andGroup:@"Friend"];
        [demo1 addEmail:@"test@abv.bg"];
        [demo1 addPhoneNumber:@"0888997766"];
        Contact* demo2 = [[Contact alloc]initWithFirstName:@"Iliancho" andLastName:@"Ganchev" andHomeAddress:@"address" andPicture:@"fun.jpg" andGroup:@"Family"];
        [demo2 addEmail:@"test@abv.bg"];
        [demo2 addPhoneNumber:@"0888997766"];
        Contact* demo3 = [[Contact alloc]initWithFirstName:@"Mitko" andLastName:@"Ganchev" andHomeAddress:@"address" andPicture:@"fun.jpg" andGroup:@"Friend"];
        [demo3 addEmail:@"test@abv.bg"];
        [demo3 addPhoneNumber:@"0888997766"];
        Contact* demo4 = [[Contact alloc]initWithFirstName:@"Vlado" andLastName:@"Ganchev" andHomeAddress:@"address" andPicture:@"fun.jpg" andGroup:@"Work"];
        [demo4 addEmail:@"test@abv.bg"];
        [demo4 addPhoneNumber:@"0888997766"];
        Contact* demo5 = [[Contact alloc]initWithFirstName:@"Anton" andLastName:@"Ganchev"  andHomeAddress:@"address" andPicture:@"fun.jpg" andGroup:@"Work"];
        [demo5 addEmail:@"test@abv.bg"];
        [demo5 addPhoneNumber:@"0888997766"];

        [self.allContacts addObject: demo];
        [self.allContacts addObject: demo1];
        [self.allContacts addObject: demo2];
        [self.allContacts addObject: demo3];
        [self.allContacts addObject: demo4];
        [self.allContacts addObject: demo5];
        
    }
    return _allContacts;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@", self.allContacts];
}

@end
