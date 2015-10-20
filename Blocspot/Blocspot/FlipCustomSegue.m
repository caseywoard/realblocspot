//
//  FlipCustomSegue.m
//  
//
//  Created by Casey Ward on 10/17/15.
//
//

#import "FlipCustomSegue.h"

@implementation FlipCustomSegue

-(void)perform {
    [self performFlipCustomSegue];
}


- (void) performFlipCustomSegue {
    NSLog(@"custom segue was called");
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
//    SearchViewController *rootController = (SearchViewController*)[[[[UIApplication sharedApplication]delegate] window] rootViewController];
//    UINavigationController *navitgationController = [[UINavigationController alloc] initWithRootViewController:rootController];
//    navitgationController = dst.navigationController;
        //[navigationController pushViewController:dst animated:YES]
    
    
    [UIView transitionWithView:src.navigationController.view duration:.8
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        //[src.navigationController popToRootViewControllerAnimated:NO];
                        [src.navigationController pushViewController:dst animated:NO];
                        //[src presentViewController:dst animated:YES completion:nil];
                        //this removed back button
                    }
     
                    completion:^(BOOL finished) {
                        dst.navigationItem.leftBarButtonItem = nil;//try hiding this
                    }];
    
}

@end
