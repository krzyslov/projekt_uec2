#Param needed to avoid memory overload error
set_param synth.elaboration.rodinMoreOptions "rt::set_parameter var_size_limit 1572865"


#Project name                                 -- EDIT
set project PROJEKT_UEC2
# Top module name                             -- EDIT
set top_module top_level
# FPGA device
set target xc7a35tcpg236-1
# Bitstream location
set bitstream_file build/${project}.runs/impl_1/${top_module}.bit


# Print how to use the script
proc usage {} {
puts "===========================================================================\n
usage: vivado -mode tcl -source [info script] -tclargs \[open/rebuild/sim/bit/prog\]\n
\topen    - open project and start gui\n
\trebuild - clear build directory and create the project again from sources, then open gui\n
\tsim     - run simulation\n
\tbit     - generate bitstream\n
\tprog    - load bitstream to FPGA\n
If a project is already created in the build directory, run.tcl opens it. Otherwise, creates a new one.
==========================================================================="
}


#rtl/frame_buffer/frame_buffer.vhd
#constraints/dont_touch.xdc
#rtl/frame_buffer/frame_buffer_sim_netlist.vhdl 
#rtl/frame_buffer/frame_buffer_stub.vhdl 
		
# Create project
proc create_new_project {project target top_module} {
    file mkdir build
    create_project ${project} build -part ${target} -force
    
    # Specify .xdc files location             -- EDIT
    read_xdc {
        constraints/project_constraints.xdc
		
		
    }

    # Specify verilog design files location   -- EDIT
    read_verilog {
		rtl/ov7670_fr/RGB.v
		rtl/ov7670_fr/address_Generator.v
		
		rtl/basys3_ov7670/clocking.v
		rtl/basys3_ov7670/clocking_clk_wiz.v
		rtl/basys3_ov7670/clock.v
		rtl/basys3_ov7670/clock_clk_wiz.v
		rtl/ov7670_fr/ov7670_capture.v
		rtl/ov7670_fr/debounce.v
		rtl/ov7670_fr/ov7670_controller.v
		rtl/ov7670_fr/top_level.v
		rtl/ov7670_fr/vga.v
		rtl/basys3_ov7670/i2c_sender.v
		rtl/basys3_ov7670/ov7670_registers.v
		rtl/filtering/char_rom.v
		rtl/filtering/delay.v
		rtl/filtering/draw_rect_char.v
		rtl/filtering/filtering.v
		rtl/filtering/font_rom.v
		rtl/ov7670_fr/resetlocked.v
		rtl/frame_buffer/ram_buffer.v
		
		
		
		
    }
	#rtl/frame_buffer/blk_mem_gen_v8_4_0.vhd
	#rtl/frame_buffer/frame_buffer.v
	#rtl/AR_58276_2013_3_MMCM/MMCME2_ADV.v
	#rtl/frame_buffer/frame_buffer_stub.v
    #rtl/frame_buffer/frame_buffer_sim_netlist.v
    # Specify vhdl design files location      -- EDIT
	#rtl/frame_buffer/blk_mem_gen_v8_4_0.v
   # read_vhdl {
	#		
	#		rtl/frame_buffer/frame_buffer.vhd
	#		rtl/frame_buffer/blk_mem_gen_v8_4_0.vhd
	#	
		
	#}
    read_ip		rtl/frame_buffer/frame_buffer.xci

    # Specify files for memory initialization -- EDIT
    #read_mem {
        #./image_rom.data
    #}

    # Specify simulation files location       -- EDIT
    #add_files -fileset sim_1 {
    #    sim/testbench.v
	#	sim/tiff_writer.v
	#	sim/draw_rect_ctl_tb.v
	#	sim/draw_rect_ctl_test.v
	#	sim/delay_test.v
    #}

    set_property top ${top_module} [current_fileset]
    update_compile_order -fileset sources_1
    update_compile_order -fileset sim_1
}

# Open existing project
proc open_existing_project {project} {
    open_project build/$project.xpr
    update_compile_order -fileset sources_1
    update_compile_order -fileset sim_1
}

# If project already exists, open it. Otherwise, create it.
proc open_or_create_project {project target top_module} {
    if {[file exists build/$project.xpr] == 1} {
        open_existing_project $project 
    } else {
        create_new_project $project $target $top_module
    }
}


# Load bitstream to FPGA
proc program_fpga {bitstream_file} {
    if {[file exists $bitstream_file] == 0} {
        puts "ERROR: No bitstream found"
    } else {
        open_hw_manager
        connect_hw_server
        current_hw_target [get_hw_targets *]
        open_hw_target
        current_hw_device [lindex [get_hw_devices] 0]
        refresh_hw_device -update_hw_probes false [lindex [get_hw_devices] 0]

        set_property PROBES.FILE {} [lindex [get_hw_devices] 0]
        set_property FULL_PROBES.FILE {} [lindex [get_hw_devices] 0]
        set_property PROGRAM.FILE ${bitstream_file} [lindex [get_hw_devices] 0]

        program_hw_devices [lindex [get_hw_devices] 0]
        refresh_hw_device [lindex [get_hw_devices] 0]
    }
}

# Simulation
proc simulation {} {
    launch_simulation
    # run all
}

# Generate bitstream
proc bitstream {} {
    # Run synthesis
    reset_run synth_1
    launch_runs synth_1 -jobs 8
    wait_on_run synth_1
    
    # Run implemenatation up to bitstream generation
    launch_runs impl_1 -to_step write_bitstream -jobs 8
    wait_on_run impl_1
}

## MAIN
if {$argc == 1} {
    switch $argv {
        open {
            open_or_create_project $project $target $top_module    
            start_gui
        }
        rebuild {
            create_new_project $project $target $top_module    
            start_gui
        }
        sim {
            open_or_create_project $project $target $top_module    
            simulation
            start_gui
        }
        bit {
            open_or_create_project $project $target $top_module    
            bitstream
            exit
        }
        prog {
            program_fpga $bitstream_file
            exit
        }
        default {
            usage
            exit 1
        }
    }
} else {
    usage
    exit 1
}
