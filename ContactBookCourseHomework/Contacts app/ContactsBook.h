

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactsBook : NSObject
@property NSInteger kindForAdding;
@property NSString* fromScreen;



+(instancetype)sharedInstance;
- (NSInteger)numberOfGroups;
- (NSInteger)numbersOfContactsInSection:(NSInteger)section;
- (Contact*)returnContactForSection:(NSInteger)section andRow:(NSInteger)row;
- (Contact*)returnContactForRow:(NSInteger)row;
- (NSString*)returnGroupNameForSection:(NSInteger)section;
- (void) addContact:(Contact*)contact;
- (void)deleteRow:(NSInteger)row inSection:(NSInteger)section;
- (NSInteger) giveInfoForContactEmails:(NSInteger)section andRow:(NSInteger)row;
- (NSInteger) giveInfoForContactPhoneNumbers:(NSInteger)section andRow:(NSInteger)row;
- (NSInteger)allContactsCount;
-(void)arange;

@end
