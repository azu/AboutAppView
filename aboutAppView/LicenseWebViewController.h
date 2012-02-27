//
//  Created by azu on 12/02/22.
//


#import <Foundation/Foundation.h>


@interface LicenseWebViewController : UIViewController <UIWebViewDelegate>{
    UIWebView *webView_;
}

@property(nonatomic, retain) UIWebView *webView;


@end