# **FPGA Image Processing with Basys 3 and OV7670 Camera**

## Description
This project leverages the Basys 3 FPGA board and the OV7670 camera to capture and display images on a connected monitor, with the capability to apply various image filters. Additionally, it uses a distance meter module to output distance-based tones on an external speaker.

## Key Components
- **FPGA Board**: Basys 3
- **Camera**: OV7670
- **External Speaker**
- **Monitor** (connected to the Basys board for image display)

## Features
1. **Image Display and Filtering**: Captured images are displayed on a monitor, with various filters that can be applied depending on the switch settings.
2. **Distance Meter**: Measures the distance from a sensor and outputs a tone with frequency corresponding to the measured distance.
3. **I2C Communication**: Utilized for communication with specific components; details available in the code.

## Available Image Filters
The following filters can be applied to the captured image:
- Motion Blur (X-axis)
- Motion Blurring (XY)
- Sharpen
- Emboss
- Edge Detection
- Sobel Edge Detection
- Average Blurring
- Blue Filter
- Red Filter
- Color Inversion
- Brightness Decrease
- Brightness Increase
- RGB to Grayscale Conversion (gray-center scale)

## Module Overview
The project is organized into several RTL modules:

- **Image Processing Filters**: [Source Code](https://github.com/krzyslov/projekt_uec2/tree/main/uec2_projekt/src/rtl)  
  These modules handle image processing and apply the specified filters based on switch inputs.

- **Distance Meter**: [Module Code](https://github.com/krzyslov/projekt_uec2/tree/main/uec2_projekt/src/rtl/distance_meter)  
  This module calculates distance and sends an appropriate frequency tone to the speaker based on the measured distance.

- **Loudspeaker Control**: [Loudspeaker Module](https://github.com/krzyslov/projekt_uec2/blob/main/uec2_projekt/src/rtl/loudspeaker/loudspeaker.v)  
  Outputs sound through the speaker based on frequency signals from the distance meter.

## Specification and Architecture Report
The project documentation includes a detailed report with key information on the system’s specifications and architecture: [Raport](https://github.com/krzyslov/projekt_uec2/blob/main/uec2_projekt/doc/Raport_BB_MW.pdf)
The report covers:
- **Algorithm Specification**: General algorithm description and an event table detailing system functionality.
- **Architecture Details**:
  - **Top Module**: Block diagram, ports, and interfaces.
  - **Clock Signal Distribution**: Details on clock routing across the modules.
- **Implementation Notes**:
  - Ignored warnings in Vivado
  - Resource utilization
  - Timing margins

This report provides an in-depth view of the system’s design, architecture, and implementation specifics.

## Getting Started
1. **Setup**: Ensure the Basys 3 FPGA board, OV7670 camera, and external speaker are properly connected.
2. **Programming the FPGA**: Load the Verilog modules onto the Basys 3 board.
3. **Operating the Filters**: Use the board switches to toggle between different filters and effects.

## Future Improvements
Potential future improvements for the project include:
- Additional image processing effects and filters.
- Enhanced distance measurement and sound mapping.
- Improved I2C communication handling and expansion.

