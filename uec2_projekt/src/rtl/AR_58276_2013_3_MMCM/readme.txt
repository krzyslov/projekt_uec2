© Copyright 1987 - 2013 Xilinx, Inc. All rights reserved. 

This file contains confidential and proprietary information of Xilinx, Inc. 
and is protected under U.S. and international copyright and other intellectual 
property laws.

DISCLAIMER
This disclaimer is not a license and does not grant any rights to the 
materials distributed herewith. Except as otherwise provided in a valid 
license issued to you by Xilinx, and to the maximum extent permitted by 
applicable law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL 
FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, 
IMPLIED, OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF 
MERCHANTABILITY, NON-INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; 
and (2) Xilinx shall not be liable (whether in contract or tort, including 
negligence, or under any other theory of liability) for any loss or damage of 
any kind or nature related to, arising under or in connection with these 
materials, including for any direct, or any indirect, special, incidental, or 
consequential loss or damage (including loss of data, profits, goodwill, or
any type of loss or damage suffered as a result of any action brought by a 
third party) even if such damage or loss was reasonably foreseeable or Xilinx 
had been advised of the possibility of the same.

CRITICAL APPLICATIONS
Xilinx products are not designed or intended to be fail-safe, or for use in 
any application requiring fail-safe performance, such as life-support or 
safety devices or systems, Class III medical devices, nuclear facilities, 
applications related to the deployment of airbags, or any other applications
that could lead to death, personal injury, or severe property or environmental 
damage (individually and collectively, "Critical Applications"). Customer 
assumes the sole risk and liability of any use of Xilinx products in Critical 
Applications, subject only to applicable laws and regulations governing 
limitations on product liability. 

THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE 
AT ALL TIMES

Not for distribution: This Tactical Patch is solely distributed by Xilinx 
Technical Support as a preliminary temporary solution between the time of
delivery and the official patch release in a major Software/IP release.  For 
details on what Software version is scheduled to include this Patch, please 
contact Technical Support (linked below). Users should not share this Patch 
with other users unless specifically directed by Xilinx Technical Support to
do so.

CAUTION: This Tactical Patch is intended as a fast response for the following 
customer issue only. The risk inherent in this fast response is that there is 
not enough time or resources available for the full regression testing which 
is done for Software releases and there is a higher risk of introducing new 
problems. It is recommended that users always install the latest Software 
release, but only install Tactical Patches when needed to resolve specific 
issues. This Tactical Patch may not be compatible with other Tactical Patchs 
made available by Xilinx.

--------------------------------------------------------------------------------
-- Overview
--------------------------------------------------------------------------------

Date: 
    11/05/2013

File Name: 
    AR_58276_2013_3_MMCM.zip

Description: 
    Patch to correct the error with the MMCM model.
    
Answer Record: 
    58276

Platform: 
    Windows/Linux 

--------------------------------------------------------------------------------
-- Instructions
--------------------------------------------------------------------------------

Installation/Use:
    This patch will overwrite existing files, please make a backup copy of your
    original files prior to installing this patch. This patch applies only to
    the Vivado 2013.3 tool set. Installation and use in prior versions of Vivado
    are not supported.

Move the Verilog file into the source libraries
-   file is MMCME2_ADV.v
-   create copy of existing unisim_retarget_comp.vp file : ex: MMCME2_ADV.v.old
-   move file to the directory : <vivado_install>/data/verilog/src/unisims

Re-run the library compilation process for all external simulation tools
-   ex : compile_simlib -simulator ncsim -family all -language all -library all -directory ./
-   for more information on the compile_simlib command enter "help compile_simlib" on the 
    Vivado TCL command line.
    
    