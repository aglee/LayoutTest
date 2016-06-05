#import <Foundation/Foundation.h>

/*!
 * Like NSLog, but omits the verbose info at the beginning of each line.
 *
 * Credit: Mark Dalrymple <http://borkware.com/quickies/single?id=261>.
 */
extern void QuietLog (NSString *format, ...);
