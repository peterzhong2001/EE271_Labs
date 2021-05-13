// This module is for Fred's House of Useful Stuff
module DE1_SoC_2 (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	// Converting switches to variables
	logic U, P, C, M;
	logic [2:0] UPC;
	assign U = SW[9];
	assign P = SW[8];
	assign C = SW[7];
	assign M = SW[0];
	assign UPC = SW[9:7];
	
	driver fred (.UPC(UPC), .leds0(HEX0), .leds1(HEX1), .leds2(HEX2), .leds3(HEX3), .leds4(HEX4), .leds5(HEX5));
	lab3 discount_theft (.U, .P, .C, .M, .Discount(LEDR[1]), .Theft(LEDR[0]));
	
endmodule

module DE1_SoC_2_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;

	DE1_SoC_2 dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
.SW);
	// Try all combinations of inputs.
	integer i;
	initial begin
		SW[6:1] = 0;
		SW[0] = 0;
		for(i = 0; i < 8; i++) begin
			SW[9:7] = i; #10;
		end
		SW[0] = 1;
		for(i = 0; i < 8; i++) begin
			SW[9:7] = i; #10;
		end
	end
endmodule