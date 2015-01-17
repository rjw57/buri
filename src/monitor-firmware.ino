// Firmware for monitor board

// Pin definitions
#define MISO    2   // NB: (1)
#define MOSI    3   // NB: (1)
#define SCLK    4
#define DLOAD   8

// (1) Since the monitor board is a slave device w.r.t. the processor board,
// MISO is an OUTPUT and MOSI is an INPUT.

// MAX7219 registers. Note that these are bit-reversed since the MAX7219
// expects data to be shifted in MSB first.
#define MX7219_DPLY_TEST    0xF0

// Send a byte, LSB first, along the serial line. Return the bye which was
// simultaneously received over the MOSI line.
byte sendAndReceive(byte output) {
    byte input = 0;

    // For each bit...
    for(int bit_idx=0; bit_idx<8; ++bit_idx) {
        int bit = (output >> bit_idx) & 0x1;

        // Set bit
        digitalWrite(MISO, bit ? HIGH : LOW);

        // Toggle clock
        digitalWrite(SCLK, HIGH);
        delay(1);
        digitalWrite(SCLK, LOW);
        delay(1);

        // Read input
        if(digitalRead(MOSI) == HIGH) {
            input |= (1 << bit);
        }
    }

    return input;
}

void setup() {
    // Setup all pin modes
    pinMode(MISO, OUTPUT);  // NB: (1)
    pinMode(MOSI, INPUT);   // NB: (1)
    pinMode(SCLK, OUTPUT);
    pinMode(DLOAD, OUTPUT);

    digitalWrite(SCLK, LOW);
    digitalWrite(MISO, LOW);
    digitalWrite(DLOAD, LOW);
}

void loop() {
    // Set MAX7219 to display test
    digitalWrite(DLOAD, LOW);
    sendAndReceive(MX7219_DPLY_TEST);
    sendAndReceive(0xFF);
    digitalWrite(DLOAD, HIGH);
    delay(1);
    digitalWrite(DLOAD, LOW);

    delay(500);

    // Set MAX7219 to display test off
    digitalWrite(DLOAD, LOW);
    sendAndReceive(MX7219_DPLY_TEST);
    sendAndReceive(0x00);
    digitalWrite(DLOAD, HIGH);
    delay(1);
    digitalWrite(DLOAD, LOW);

    delay(500);
}

// vim:filetype=c
