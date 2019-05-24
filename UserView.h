#import <Foundation/Foundation.h>
@class NSButton;

@interface UserView : NSObject
{
  NSButton* userButton;
  NSString* userName;
}

-(NSButton *) userButton;
-(CGFloat) width;
-(id) initWithOrigin:(CGFloat)xOrigin
               height:(CGFloat)h;
@end
