#pragma once

#include <functional>

namespace dronelink {

class CalibrationImpl;

class Calibration
{
public:
    explicit Calibration(CalibrationImpl *impl);
    ~Calibration();

    enum class Result {
        SUCCESS = 0,
        NO_DEVICE,
        CONNECTION_ERROR,
        BUSY,
        COMMAND_DENIED,
        TIMEOUT,
        ERROR_ARMED,
        UNKNOWN
    };

    enum class Mode {
        UNKNOWN = -1,
        GYRO,//0
        ACCELEROMETER,//1
        MAGNETOMETER//2
    };

    enum class Orientation {
        UNKNOWN = -1,
        DOWN,//0
        UP,//1
        LEFT,//2
        RIGHT,//3
        FRONT,//4
        BACK//5
    };

    enum class Status {
        UNKNOWN = -1,
        STARTED,//0
        DONE,//1
        FAILED,//2
        WARNING,//3
        CANCELLED,//4
    };

    static const char *result_str(Result result);
    typedef std::function<void(Result)> result_callback_t;

    void calibrate_gyro_async(result_callback_t callback);
    void calibrate_accelerometer_async(result_callback_t callback);
    void calibrate_magnetometer_async(result_callback_t callback);


    typedef std::function<void(Status status, Mode mode, Orientation orientation, int progress)>
    feedback_callback_t;
    void subscribe_to_feeback(feedback_callback_t callback);

    // Non-copyable
    Calibration(const Calibration &) = delete;
    const Calibration &operator=(const Calibration &) = delete;

private:
    // Underlying implementation, set at instantiation
    CalibrationImpl *_impl;
};

} // namespace dronelink
