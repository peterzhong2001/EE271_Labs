// This module is for the demonstration and testing of 7-segment display
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	// setting up hex1 and hex2
	seg7_2 seg (.bcd1(SW[3:0]), .bcd2(SW[7:4]), .leds1(HEX0), .leds2(HEX1));
	
	// assigning off values to other hex displays
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
endmodule

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;

	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);
	// Try all combinations of inputs.
	integer i;
	initial begin
		for(i = 0; i < 10; i++) begin
			SW[3:0] = i; #10;
		end
		for(i = 0; i < 10; i++) begin
			SW[7:4] = i; #10;
		end
	end
endmodule