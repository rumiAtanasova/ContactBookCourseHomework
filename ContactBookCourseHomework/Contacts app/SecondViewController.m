

#import "SecondViewController.h"
#import "ContactsBook.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentContact = [[ContactsBook sharedInstance] returnContactForRow:indexPath.row];
    [self performSegueWithIdentifier:@"goToMailScreen" sender:tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ContactsBook sharedInstance] allContactsCount];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"secondScreenCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    Contact* anyContact = [[ContactsBook sharedInstance] returnContactForRow:indexPath.row];
    NSString* contactName = [[[NSString stringWithString:anyContact.firstName]stringByAppendingString:@" "]stringByAppendingString:anyContact.lastName];
    cell.textLabel.text = contactName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (anyContact.picture) {
        cell.imageView.image = [UIImage imageNamed:anyContact.picture];
    }
    else {
        cell.imageView.image = [anyContact giveImageFromPhone:0];
        
    }
    
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
