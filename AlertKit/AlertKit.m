#import "AlertKit.h"

#define EXCEED_iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface AlertKit() <UIAlertViewDelegate>

@property (nonatomic,assign) BOOL ifShow; // 当前是否显示了alert
@property (nonatomic,strong) AlertAction cancelAction;
@property (nonatomic,strong) AlertAction confirmAction;

@end

@implementation AlertKit

#pragma mark - obj life cycle
static AlertKit *instance = nil;
+ (AlertKit *)shareKit {
    @synchronized(self) {
        if (instance == nil) {
            instance = [[AlertKit alloc] init];
        }
    }
    
    return instance;
}

- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}


#pragma mark - methods
- (void)showAlertWithViewController:(UIViewController *)viewController
                              title:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                 confirmButtonTitle:(NSString *)confirmButtonTitle
                       cancelAction:(AlertAction)cancelAction confirmAction:(AlertAction)confirmAction {
    NSAssert(cancelButtonTitle.length, @"");
    NSAssert(confirmButtonTitle.length, @"");
    
    if (self.ifShow) {
        return;
    }
    self.ifShow = YES;
    
    self.cancelAction = cancelAction;
    self.confirmAction = confirmAction;
    if (EXCEED_iOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action0 = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            _ifShow = NO;
            if (cancelAction) {
                cancelAction();
            }
        }];
        [alertController addAction:action0];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:confirmButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            _ifShow = NO;
            if (confirmAction) {
                confirmAction();
            }
        }];
        [alertController addAction:action1];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:cancelButtonTitle otherButtonTitles:confirmButtonTitle,nil];
        [alert show];
    }
}

- (void)showAlertWithViewController:(UIViewController *)viewController
                              title:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                       cancelAction:(AlertAction)cancelAction {
    NSAssert(cancelButtonTitle.length, @"");
    
    if (self.ifShow) {
        return;
    }
    self.ifShow = YES;
    
    self.cancelAction = cancelAction;
    if (EXCEED_iOS8) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            _ifShow = NO;
            if (cancelAction) {
                cancelAction();
            }
        }];
        [alertController addAction:action];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    _ifShow = NO;
    if (buttonIndex == 0) {
        if (self.cancelAction) {
            self.cancelAction();
        }
    }
    else {
        if (self.confirmAction) {
            self.confirmAction();
        }
    }
}



@end
