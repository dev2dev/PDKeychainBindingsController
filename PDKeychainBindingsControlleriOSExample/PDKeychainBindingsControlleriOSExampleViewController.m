//
//  PDKeychainBindingsControlleriOSExampleViewController.m
//  PDKeychainBindingsControlleriOSExample
//
//  Created by Carl Brown on 7/10/11.
//  Copyright 2011 PDAgent, LLC. Released under MIT License.
//

#import "PDKeychainBindingsControlleriOSExampleViewController.h"
#import "PDKeychainBindings.h"

@implementation PDKeychainBindingsControlleriOSExampleViewController
@synthesize retrievedLabel;
@synthesize passwordField;
@synthesize revealButton;

- (void)dealloc
{
    [passwordField release];
    [revealButton release];
    [retrievedLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [passwordField setText:[[PDKeychainBindings sharedKeychainBindings] objectForKey:@"passwordString"]];
}


- (void)viewDidUnload
{
    [passwordField release];
    passwordField = nil;
    [revealButton release];
    revealButton = nil;
    [retrievedLabel release];
    retrievedLabel = nil;
    [self setPasswordField:nil];
    [self setRevealButton:nil];
    [self setRetrievedLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    PDKeychainBindings *bindings=[PDKeychainBindings sharedKeychainBindings];
    [bindings setObject:[textField.text stringByReplacingCharactersInRange:range withString:string] forKey:@"passwordString"];
    return YES;
}


- (IBAction)toggleReveal:(id)sender {
    PDKeychainBindings *bindings=[PDKeychainBindings sharedKeychainBindings];
    if ([[[revealButton titleLabel] text] isEqualToString:@"Reveal"]) {
        [retrievedLabel setText:
         [bindings stringForKey:@"passwordString"]
         ];
        [revealButton setTitle:@"Conceal" forState:(UIControlStateNormal&UIControlStateSelected)];
    } else {
        //Conceal
        [retrievedLabel setText:@""];
        [revealButton setTitle:@"Reveal" forState:(UIControlStateNormal&UIControlStateSelected)];
    }
}
@end
