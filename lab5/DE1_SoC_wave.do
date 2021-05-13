onerror {resume}
quietly virtual function -install /DE1_SoC_testbench -env /DE1_SoC_testbench/#INITIAL#60 { &{/DE1_SoC_testbench/LEDR[2], /DE1_SoC_testbench/LEDR[1], /DE1_SoC_testbench/dut/LEDR[0] }} output
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate {/DE1_SoC_testbench/KEY[0]}
add wave -noupdate {/DE1_SoC_testbench/dut/SW[1]}
add wave -noupdate {/DE1_SoC_testbench/dut/SW[0]}
add wave -noupdate /DE1_SoC_testbench/output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {2363 ps}
