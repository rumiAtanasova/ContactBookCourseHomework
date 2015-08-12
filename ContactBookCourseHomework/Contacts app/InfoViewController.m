
#import "InfoViewController.h"
#import "ContactsBook.h"
#import "FirstViewController.h"
#import "Contact.h"
#import "AddNewFieldTableViewCell.h"
#import "NewFieldsViewController.h"

@interface InfoViewController ()
@property (readwrite, nonatomic) NSString* kindForAdding;
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"AddNewFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"newField"];
    FirstViewController* fvc = (FirstViewController*)self.navigationController.viewControllers[0];
    self.title = [[fvc.currentContact.firstName stringByAppendingString:@" "] stringByAppendingString:fvc.currentContact.lastName];
   
    self.tableView.tableFooterView = self.addButton;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (IBAction)goToAddPage:(id)sender {
    [self performSegueWithIdentifier:@"addContact" sender:sender];
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    if (self.tableView.isEditing) {
        [self.tableView setEditing:NO animated:animated];
    }
    else {
        [self.tableView setEditing:YES animated:animated];
        
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 2) {
        return YES;
    }
    return NO;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (UITableViewCellEditingStyleDelete );
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstViewController* fvc = (FirstViewController*)self.navigationController.viewControllers[0];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section == 0) {
            if ([fvc.currentContact deletePhonNumberForRow:indexPath.row]) {
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }
        else {
            if ([fvc.currentContact deleteEmailForRow:indexPath.row]) {
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 20;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Numbers";
        
    }
    if (section == 1) {
        return @"Emails";
    }
    if (section == 2) {
        return @"Other";
    }
    return nil;
    
    
}
-(void)addFieldWithSender:(UIButton*)sender {
    [ContactsBook sharedInstance].fromScreen = @"Info";
    if ([sender.titleLabel.text isEqualToString:@"Add phone"]) {
        self.kindForAdding = @"phone numbers";
        [ContactsBook sharedInstance].kindForAdding = 1;
    }
    else {
        self.kindForAdding = @"e-mails";
        [ContactsBook sharedInstance].kindForAdding = 2;
    }
    [self performSegueWithIdentifier:@"toNewFielsScreen" sender:sender];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIButton* addPhone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [addPhone setTitle:@"Add phone" forState:UIControlStateNormal];
        [addPhone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addPhone sizeToFit];
        [addPhone addTarget:self action:@selector(addFieldWithSender:) forControlEvents:UIControlEventTouchDown];
        return addPhone;
    }
    if (section == 1) {
        UIButton* addEmail = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [addEmail setTitle:@"Add e-mail" forState:UIControlStateNormal];
        [addEmail setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addEmail addTarget:self action:@selector(addFieldWithSender:) forControlEvents:UIControlEventTouchDown];
        return addEmail;
    }

    return nil;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FirstViewController* fvc = (FirstViewController*)self.navigationController.viewControllers[0];
    if (section == 0) {
        return [fvc.currentContact phoneNumbersCount];
    }
    if (section == 1) {
        return [fvc.currentContact emailsCount];
    }
    if (section == 2) {
        return 2;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* identifier = @"tableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
   FirstViewController* fvc = (FirstViewController*)self.navigationController.viewControllers[0];
    if (indexPath.section == 0) {
        cell.textLabel.text = [fvc.currentContact giveNumberForRow:indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = [fvc.currentContact giveEmailForRow:indexPath.row];
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = fvc.currentContact.homeAddress;
        }
        else {
            cell.textLabel.text = fvc.currentContact.group;
        }
        
    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
