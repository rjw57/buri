#pragma once
#ifndef GUARD_EDGE_TRIGGER_H__
#define GUARD_EDGE_TRIGGER_H__

#include "Arduino.h"

class EdgeTrigger {
public:
    enum Edge { RisingEdge, FallingEdge };

    EdgeTrigger(Edge trigger = RisingEdge, int initialState = LOW)
        : trigger_(trigger), previousState_(initialState)
        , triggered_(false)
    { }

    void update(int state) {
        if(state != previousState_)
        {
            if(((state == LOW) && (trigger_ == FallingEdge)) ||
                    ((state == HIGH) && (trigger_ == RisingEdge)))
            {
                triggered_ = true;
            }
        }

        previousState_ = state;
    }

    void clear() { triggered_ = false; }

    bool triggered() const { return triggered_; }
private:
    Edge    trigger_;
    int     previousState_;
    bool    triggered_;
};

#endif // GUARD_EDGE_TRIGGER_H__
