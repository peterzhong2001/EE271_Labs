onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/DE1_SoC_testbench/dut/SW[7]}
add wave -noupdate {/DE1_SoC_testbench/dut/SW[6]}
add wave -noupdate {/DE1_SoC_testbench/dut/SW[5]}
add wave -noupdate {/DE1_SoC_testbench/dut/SW[4]}
add wave -noupdate {/DE1_SoC_testbench/dut/SW[3]}
add wave -noupdate {/DE1_SoC_testbench/dut/SW[2]}
add wave -noupdate {/DE1_SoC_testbench/dut/SW[1]}
add wave -noupdate {/DE1_SoC_testbench/dut/SW[0]}
add wave -noupdate {/DE1_SoC_testbench/dut/LEDR[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {1 ns}
