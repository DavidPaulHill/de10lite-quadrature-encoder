# DE10-Lite Quadrature Encoder Decoder

Small FPGA learning project using a Terasic DE10-Lite board to read a real two-channel quadrature encoder from a geared DC motor and display the count on the onboard 7-segment display.

## Project summary

This project started as a sequence of simple FPGA exercises in Verilog on the DE10-Lite:
- switches to LEDs
- counters on LEDs
- debounced button logic
- hexadecimal output on HEX0
- simulated quadrature decoding using switches

The final step was reading a real quadrature encoder from a small DC geared motor.

The motor was driven open-loop from an Arduino Uno through a motor driver, while the encoder channels were interfaced to the FPGA through resistor dividers to protect the 3.3 V FPGA inputs.

## Hardware used

- Terasic DE10-Lite FPGA board
- Arduino Uno
- DC motor driver
- Small geared DC motor with encoder
- Breadboard and jumper wires
- Resistor dividers on encoder channels
- Battery pack

## Signal interface

The encoder board connections were:
- C1 = encoder channel A
- C2 = encoder channel B
- GND = common ground
- VCC = encoder supply
- M1/M2 = motor terminals

Initial multimeter checks showed encoder outputs at motor supply voltage, so the encoder signals were not connected directly to the FPGA.

Each channel was reduced through a simple divider before being routed into the FPGA.

## FPGA behaviour

The FPGA:
- synchronises the encoder inputs
- detects encoder transitions
- updates a 4-bit count
- displays the count on HEX0
- can also mirror encoder channels on LEDs for debug

## Notes

- The DE10-Lite 7-segment display is active low.
- Early bring-up used switch-generated fake quadrature before moving to the real encoder.
- The real encoder interface required verifying voltage levels before connecting to the FPGA.

## Files

- `src/` contains the Verilog source
- `docs/` contains bench photos
- `pin_assignments.txt` lists the key FPGA pin mappings

## Bench setup

![Bench setup](docs/bench_setup_1.jpg)

## What I learned

- Quartus project/file hierarchy is easy to get wrong early on
- Pin naming on the board and FPGA package naming in Quartus are different things
- Real encoder signals need voltage checking before connecting to FPGA inputs
- Proving the logic with simulated quadrature first made real hardware bring-up much easier
