

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface FirstViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(readonly) Contact* currentContact;


@end

