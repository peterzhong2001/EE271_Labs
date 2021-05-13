onerror {resume}
quietly virtual function -install /DE1_SoC_testbench -env /DE1_SoC_testbench/#INITIAL#52 { &{/DE1_SoC_testbench/LEDR[9], /DE1_SoC_testbench/LEDR[8], /DE1_SoC_testbench/LEDR[7], /DE1_SoC_testbench/LEDR[6], /DE1_SoC_testbench/LEDR[5], /DE1_SoC_testbench/LEDR[4], /DE1_SoC_testbench/LEDR[3], /DE1_SoC_testbench/LEDR[2], /DE1_SoC_testbench/LEDR[1] }} LED
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate {/DE1_SoC_testbench/SW[9]}
add wave -noupdate {/DE1_SoC_testbench/KEY[3]}
add wave -noupdate {/DE1_SoC_testbench/KEY[0]}
add wave -noupdate /DE1_SoC_testbench/LED
add wave -noupdate /DE1_SoC_testbench/HEX0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {667 ps} 0}
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
WaveRestoreZoom {0 ps} {9713 ps}
