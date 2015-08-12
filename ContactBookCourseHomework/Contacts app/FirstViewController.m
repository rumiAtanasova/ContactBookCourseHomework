

#import "FirstViewController.h"
#import "ContactsBook.h"
#import "OneContactTableViewCell.h"
#import "Contact.h"

@interface FirstViewController ()

@property (weak, nonatomic) IBOutlet UIButton *addContactButton;
@property(readwrite, strong, nonatomic) Contact* currentContact;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"OneContactTableViewCell" bundle:nil] forCellReuseIdentifier:@"contactCell"];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.tableFooterView = self.addContactButton;
    [[ContactsBook sharedInstance] arange];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[ContactsBook sharedInstance] arange];
    [self.tableView reloadData];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (self.tableView.isEditing )
        [self.tableView setEditing:NO animated:animated];
    else
        [self.tableView setEditing:YES animated:animated];
    
}
- (IBAction)goToAddPage:(id)sender {
    [self performSegueWithIdentifier:@"addNewContact" sender:sender];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [[ContactsBook sharedInstance] deleteRow:indexPath.row inSection:indexPath.section];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentContact = [[ContactsBook sharedInstance]returnContactForSection:indexPath.section andRow:indexPath.row];
    
    [self performSegueWithIdentifier:@"infoScreen" sender:tableView];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[ContactsBook sharedInstance] numberOfGroups];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[ContactsBook sharedInstance] numbersOfContactsInSection:section];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[ContactsBook sharedInstance]returnGroupNameForSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"contactCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    Contact* anyContact = [[ContactsBook sharedInstance] returnContactForSection:indexPath.section andRow:indexPath.row];   
    NSString* contactName = [[[NSString stringWithString:anyContact.firstName]stringByAppendingString:@" "]stringByAppendingString:anyContact.lastName];
    ((OneContactTableViewCell*)cell).contactName.text = contactName;
    ((OneContactTableViewCell*)cell).contactPhoneNumber.text = [anyContact lastNumber];
    ((OneContactTableViewCell*)cell).contactEmail.text = [anyContact lastEmail];
    if (anyContact.picture) {
        ((OneContactTableViewCell*)cell).contactPicture.image = [UIImage imageNamed:anyContact.picture];
    }
    else {
        ((OneContactTableViewCell*)cell).contactPicture.image = [anyContact giveImageFromPhone:0];
        
    }
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
