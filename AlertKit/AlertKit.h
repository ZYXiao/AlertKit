#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^AlertAction)();

@interface AlertKit : NSObject <UIAlertViewDelegate>

+ (AlertKit *)shareKit;

- (void)showAlertWithViewController:(UIViewController *)viewController
                              title:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                 confirmButtonTitle:(NSString *)confirmButtonTitle
                       cancelAction:(AlertAction)cancelAction confirmAction:(AlertAction)confirmAction;


- (void)showAlertWithViewController:(UIViewController *)viewController
                              title:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                       cancelAction:(AlertAction)cancelAction;


@end
