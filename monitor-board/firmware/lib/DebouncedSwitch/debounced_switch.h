#pragma once
#ifndef GUARD_DEBOUNCED_SWITCH_H__
#define GUARD_DEBOUNCED_SWITCH_H__

#include "Arduino.h"

class DebouncedSwitch {
public:
    DebouncedSwitch(int pin, bool activeLow = true);

    void poll();
    int state() const;
private:
    const unsigned long DEBOUNCE_TIME = 20; // milliseconds

    bool            activeLow_;
    int             state_;
    int             pin_;
    unsigned long   previousReadTime_;
    int             previousState_;
};

#endif // GUARD_DEBOUNCED_SWITCH_H__
