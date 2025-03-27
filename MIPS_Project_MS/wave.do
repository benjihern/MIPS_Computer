onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Top Level}
add wave -noupdate -radix hexadecimal /top_level_tb/clk
add wave -noupdate -radix hexadecimal /top_level_tb/switches
add wave -noupdate -radix hexadecimal -childformat {{/top_level_tb/buttons(1) -radix hexadecimal} {/top_level_tb/buttons(0) -radix hexadecimal}} -subitemconfig {/top_level_tb/buttons(1) {-height 15 -radix hexadecimal} /top_level_tb/buttons(0) {-height 15 -radix hexadecimal}} /top_level_tb/buttons
add wave -noupdate -radix hexadecimal /top_level_tb/LED
add wave -noupdate -divider Controller
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/clk
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/reset
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/opcode
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/funct
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/MemRead
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/MemWrite
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/MemtoReg
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/IorD
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/IRWrite
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/PCWrite
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/PCWriteCond
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/PCSource
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/ALUOp
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/ALUSrcA
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/ALUSrcB
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/RegWrite
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/RegDst
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/JumpAndLink
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/IsSigned
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/current_state
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/next_state
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Controller_inst/internal_JumpAndLink
add wave -noupdate -divider MUX_2A
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_A/d0
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_A/d1
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_A/sel
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_A/y
add wave -noupdate -divider MUX_2B
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_B/d0
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_B/d1
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_B/sel
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_B/y
add wave -noupdate -divider MUX_2C
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_C/d0
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_C/d1
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_C/sel
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_C/y
add wave -noupdate -divider MUX_2D
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_D/d0
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_D/d1
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_D/sel
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX2x1_D/y
add wave -noupdate -divider MUX_3A
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_A/d0
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_A/d1
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_A/d2
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_A/sel
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_A/y
add wave -noupdate -divider MUX_3B
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_B/d0
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_B/d1
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_B/d2
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_B/sel
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX3x1_B/y
add wave -noupdate -divider MUX_4A
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX4x1_A/d0
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX4x1_A/d1
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX4x1_A/d2
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX4x1_A/d3
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX4x1_A/sel
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/MUX4x1_A/y
add wave -noupdate -divider {Memory Module}
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/clk
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/baddr
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/dataIn
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/memRead
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/memWrite
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/dataOut
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/switches
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/port_select
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/input_enable
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/display_out
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/ram_addr
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/ram_q
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/ram_wren
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/ram_rden
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/is_io_addr
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/inport0_internal
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/inport1_internal
add wave -noupdate -radix hexadecimal /top_level_tb/UUT/Datapath_inst/Memory/outport_write_enable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1950990901198 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {2031949027730 ps} {3101395884432 ps}
