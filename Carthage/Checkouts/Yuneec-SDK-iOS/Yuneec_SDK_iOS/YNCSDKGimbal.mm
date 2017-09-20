/** @brief YNCSDKGimbal  implementation file */

#import "YNCSDKGimbal.h"
#import "YNCSDKInternal.h"

using namespace dronelink;
using namespace std::placeholders; // for _1, _2, etc.

//MARK: C Functions
void receive_gimbal_result(YNCGimbalCompletion completion, Gimbal::Result result) {
    if (completion) {
        NSError *error = nullptr;
        if (result != Gimbal::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Gimbal::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Gimbal"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
        }
        completion(error);
    }

}

@interface YNCSDKGimbal ()

@end

@implementation YNCSDKGimbal

//MARK: Set PitchAndYaw
+ (void)setPitchDeg:(float)pitchDeg andYawDeg:(float)yawDeg withCompletion:(YNCGimbalCompletion)completion{
    DroneLink *dl = [[YNCSDKInternal instance] dl];
    dl->device().gimbal().set_pitch_and_yaw_async(pitchDeg, yawDeg, std::bind(&receive_gimbal_result, completion, _1));
}

@end
