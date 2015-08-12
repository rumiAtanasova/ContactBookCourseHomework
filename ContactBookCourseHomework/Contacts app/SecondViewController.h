
#import <UIKit/UIKit.h>
#import "Contact.h"

@interface SecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate >
@property Contact* currentContact;

@end

