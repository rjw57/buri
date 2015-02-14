#pragma once
#ifndef GUARD_SERIAL_STATE_MACHINE__H
#define GUARD_SERIAL_STATE_MACHINE__H

#include <Arduino.h> // for "byte"

// A state machine state contains a function pointer, next, which takes an
// incoming character and returns the next states.
struct SerialState {
    typedef struct SerialState (*Func) (byte);
    Func next;
protected:
    static SerialState nullState_(byte) {
        return { .next = &nullState_ };
    }
};


#endif // GUARD_SERIAL_STATE_MACHINE__H
