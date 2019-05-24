#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#define RIGHTPADDING 6
#define LEFTPADDING 6

@interface MyDelegate : NSObject
{
  NSWindow *topBar;
  NSRect screenFrame;
  NSSize screenSize;
}

- (NSColor *) backgroundColor;
- (NSColor *) transparentColor;
- (void) createTopBar;
- (void) applicationWillFinishLaunching: (NSNotification *)not;
- (void) applicationDidFinishLaunching: (NSNotification*)not;



@end
