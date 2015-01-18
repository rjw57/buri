#include "Arduino.h"
#include "debounced_switch.h"

DebouncedSwitch::DebouncedSwitch(int pin, bool activeLow) :
    activeLow_(activeLow), state_(LOW), pin_(pin),
    previousReadTime_(millis()), previousState_(LOW)
{ }

void DebouncedSwitch::poll() {
    if(millis() - previousReadTime_ > DebouncedSwitch::DEBOUNCE_TIME) {
        state_ = previousState_;
    }

    int newState = digitalRead(pin_);
    if(activeLow_) {
        newState = (newState == HIGH) ? LOW : HIGH;
    }

    if(newState != previousState_) {
        previousReadTime_ = millis();
        previousState_ = newState;
    }
}

int DebouncedSwitch::state() {
    return state_;
}

