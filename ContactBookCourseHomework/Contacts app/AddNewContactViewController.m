

#import "AddNewContactViewController.h"
#import "Contact.h"
#import "ContactsBook.h"

@interface AddNewContactViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate >

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property Contact* currentContact;
@property NSString* choosenGroup;
@property NSArray* choosenImageFromPhone;


@end

@implementation AddNewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstNameTextLabel.text = @"";
    self.lastNameTextLabel.text = @"";
    self.addressTextLabel.text = @"";
    
}

- (IBAction)chooseAGroup:(UIButton*)sender {
    if (sender.tag == 1) {
        self.choosenGroup = @"Family";
    }
    else if (sender.tag == 2) {
        self.choosenGroup = @"Friend";
    }
    else if (sender.tag == 3) {
        self.choosenGroup = @"Work";
    }
    else {
        self.choosenGroup = nil;

    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (IBAction)goToAddingScreen:(UIButton*)sender {
    [ContactsBook sharedInstance].fromScreen = @"New contact";
    if (sender.tag == 1) {
        [ContactsBook sharedInstance].kindForAdding = 1;
    }
    else {
        [ContactsBook sharedInstance].kindForAdding = 2;
    }
    [self performSegueWithIdentifier:@"addNewFieldsFromAddScreen" sender:sender];
}

- (IBAction)acceptImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.imageView.image = image;

    self.choosenImageFromPhone = [NSArray arrayWithObject:info[UIImagePickerControllerEditedImage]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
                             

- (IBAction)createNewContact:(id)sender {
    if (self.choosenGroup != nil) {
        self.currentContact = [[Contact alloc] initWithFirstName:self.firstNameTextLabel.text andLastName:self.lastNameTextLabel.text andHomeAddress:self.addressTextLabel.text andPicture:nil andGroup:self.choosenGroup];
        if ([ContactsBook sharedInstance].kindForAdding == 1) {
            [self.currentContact addPhoneNumber:self.addedComponent];
        }
        if ([ContactsBook sharedInstance].kindForAdding == 2) {
            [self.currentContact addEmail:self.addedComponent];
        }
        [self.currentContact addImageFromPhone:self.choosenImageFromPhone];
        [[ContactsBook sharedInstance] addContact:self.currentContact];
    }
    
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
