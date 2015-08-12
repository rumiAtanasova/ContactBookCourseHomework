
#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (readonly, nonatomic) NSString* kindForAdding;

@end
