

#import "NewFieldsViewController.h"
#import "InfoViewController.h"
#import "FirstViewController.h"
#import "AddNewContactViewController.h"
#import "Contact.h"
#import "ContactsBook.h"

@interface NewFieldsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *labelField;


@end

@implementation NewFieldsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.text = @"";
    if ([ContactsBook sharedInstance].kindForAdding == 1) {
        self.labelField.text = @"Enter new phone number:";
    }
    else {
        self.labelField.text = @"Enter new e-mail:";
    }
    
    
}
- (IBAction)addNewFields:(id)sender {
    if ([[ContactsBook sharedInstance].fromScreen isEqualToString:@"Info"]) {
        FirstViewController* fvc = (FirstViewController*)self.navigationController.viewControllers[0];
        if ([ContactsBook sharedInstance].kindForAdding == 1) {
            [fvc.currentContact addPhoneNumber:self.textField.text];
        }
        else {
            [fvc.currentContact addEmail:self.textField.text];
        }

    }
    else {
        AddNewContactViewController* avc = (AddNewContactViewController*)self.navigationController.viewControllers[1];
        avc.addedComponent = self.textField.text;
         
    }
    self.textField.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
