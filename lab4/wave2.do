onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/DE1_SoC_2_testbench/SW[9]}
add wave -noupdate {/DE1_SoC_2_testbench/SW[8]}
add wave -noupdate {/DE1_SoC_2_testbench/SW[7]}
add wave -noupdate {/DE1_SoC_2_testbench/SW[0]}
add wave -noupdate {/DE1_SoC_2_testbench/LEDR[1]}
add wave -noupdate {/DE1_SoC_2_testbench/LEDR[0]}
add wave -noupdate /DE1_SoC_2_testbench/HEX5
add wave -noupdate /DE1_SoC_2_testbench/HEX4
add wave -noupdate /DE1_SoC_2_testbench/HEX3
add wave -noupdate /DE1_SoC_2_testbench/HEX2
add wave -noupdate /DE1_SoC_2_testbench/HEX1
add wave -noupdate /DE1_SoC_2_testbench/HEX0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 281
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
WaveRestoreZoom {0 ps} {875 ps}
