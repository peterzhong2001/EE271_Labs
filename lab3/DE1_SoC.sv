// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	//Converting switches and LEDs to variables
	logic U, P, C, M;
	assign U = SW[9];
	assign P = SW[8];
	assign C = SW[7];
	assign M = SW[0];
	
	// Settiinh up output variables
	logic a1Out, n1Out, nor1Out, nor2Out, Discount, Theft;
	
	//Setting up all gates and connections
	and a1 (a1Out, U, C);
	not n1 (n1Out, U);
	or o1 (Discount, a1Out, P);
	nor nor1 (nor2Out, P, n1Out, M);
	nor nor2 (nor1Out, P, C, M);
	or o2 (Theft, nor1Out, nor2Out);
	
	//Assigning LEDs to output logic
	assign LEDR[1] = Discount;
	assign LEDR[0] = Theft;
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