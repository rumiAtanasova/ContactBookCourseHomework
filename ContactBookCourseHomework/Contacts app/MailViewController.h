//
//  MailViewController.h
//  Contacts app
//
//  Created by Rumyana Atanasova on 31.05.15.
//  Copyright (c) 2015 г. Rumyana Atanasova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface MailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
