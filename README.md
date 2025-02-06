
# tsa5511/tsa5512 PLL Controller

## Description

- This code in C controls FM Transmitters with the TSA5511 or TSA5512 pll ic, with the Pic16F628A microcontroller.

## Requirements

- **Microcontroller**: Microchip Pic16F628A.
- **PLL IC**: Philips TSA5511 or TSA5512.
- **Crystal Oscillator**: 3.2MHz or 4.0MHz.
- **Compiler**: MikroC Pro Pic 7.6.0 (demo).
- **Programmer Hardware**: Pickit2 or Pickit3.
- **OS**: Windows 7 with USB 2.0 Ports.

## Installation

1. Download the repository from GitHub:
   [https://github.com/junon10/tsa5511](https://github.com/junon10/tsa5511)

2. Open the MCPPI project file, click in compile.

3. Burn the hex file in the Pic16F628A using Microchip Pickit2 or Pickit3 Programmer.

4. Insert the tsa5511/12 in the IC socket board connected to Pic16f628A and Fm Oscillator.

5. Configure the Dip Switches to desired frequency.

## Limitations

- For detailed technical specifications, refer to the TSA5511/12 datasheet.
- The 3.2MHz crystal oscillator presents better precision in generating frequencies in Broadcast Band 88-108MHz, but a 4MHz crystal can also be used with a small difference in frequencies.

## Author

- **Junon M.**  
  Contact: [junon10@tutamail.com](mailto:junon10@tutamail.com)

## Contributing

Contributions are welcome! Please fork the repository and send a pull request.

## Repository

- [https://github.com/junon10/tsa5511](https://github.com/junon10/tsa5511)

## References

- TSA5511/12 Datasheet

## Changelog

- **v1.0.0 (2024/06/16)**: Initial commit.
