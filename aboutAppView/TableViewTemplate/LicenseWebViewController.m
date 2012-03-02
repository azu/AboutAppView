//
//  Created by azu on 12/02/22.
//


#import "LicenseWebViewController.h"


@implementation LicenseWebViewController {

}

@synthesize webView = webView_;

- (void)loadView {
    self.view = [[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];
    self.webView = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
    [self.webView setDelegate:self];
    [self.view addSubview:self.webView];
    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0];

}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
        duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    self.webView.frame = (CGRect) {
        0,
        0,
        self.view.frame.size.width,
        self.view.frame.size.height
    };
}


- (void)dealloc {
    [webView_ release], webView_ = nil;
    [super dealloc];
}


@end