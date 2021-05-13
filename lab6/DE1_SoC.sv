// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;

	// Turn off the hex display
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	// Assign wire variables
	logic reset, clk, X, Y, A, B;
	logic [1:0] out;
	assign reset = SW[9];
	assign clk = CLOCK_50;
	
	// Stabilize input
	stabilizer s1 (.in1(KEY[3]), .in2(KEY[0]), .A, .B, .clk);
	
	// Process input
	input_processing IP (.A, .B, .out, .clk);
	
	// Output to LED and Hex
	light_control LC (.player1(out[1]), .player2(out[0]), .ledout(LEDR[9:1]), .hexout(HEX0), .clk, .reset);
	
endmodule



module DE1_SoC_testbench();
	logic CLOCK_50;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;

	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,.SW);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	// Test the design
	initial begin
		SW[9] <= 1; KEY[3] <= 1; KEY[0] <= 1; repeat(2) @(posedge CLOCK_50); // reset the module
		
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 release
		
		SW[9] <= 1; KEY[3] <= 1; KEY[0] <= 1; repeat(2) @(posedge CLOCK_50); // reset the module
		
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 0;  @(posedge CLOCK_50); // player 2 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 2 release
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 0;  @(posedge CLOCK_50); // player 2 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 2 release
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 0;  @(posedge CLOCK_50); // player 2 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 2 release
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 0;  @(posedge CLOCK_50); // player 2 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 2 release
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 0;  @(posedge CLOCK_50); // player 2 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 2 release
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 0;  @(posedge CLOCK_50); // player 2 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // player 2 release
		
		SW[9] <= 1; KEY[3] <= 1; KEY[0] <= 1; repeat(2) @(posedge CLOCK_50); // reset the module
		
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 1;  @(posedge CLOCK_50); // player 1 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 0;  @(posedge CLOCK_50); // player 2 press and hold for 2 cycles, player 1 keep holding
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 1;  @(posedge CLOCK_50); // player 2 release, player 1 keep holding
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 0;  @(posedge CLOCK_50); // player 2 press and hold for 2 cycles, player 1 keep holding
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // both release
		
		SW[9] <= 1; KEY[3] <= 1; KEY[0] <= 1; repeat(2) @(posedge CLOCK_50); // reset the module
		
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 0;  @(posedge CLOCK_50); // player 2 press and hold for 2 cycles
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 0;  @(posedge CLOCK_50); // player 1 press and hold for 2 cycles, player 2 keep holding
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 0;  @(posedge CLOCK_50); // player 1 release, player 2 keep holding
		SW[9] <= 0;	KEY[3] <= 0; KEY[0] <= 0;  @(posedge CLOCK_50); // player 1 press and hold for 2 cycles, player 2 keep holding
		SW[9] <= 0;	KEY[3] <= 1; KEY[0] <= 1;  @(posedge CLOCK_50); // both release
		
		SW[9] <= 1; KEY[3] <= 1; KEY[0] <= 1; repeat(2) @(posedge CLOCK_50); // reset the module
		$stop; // End the simulation.
	end
endmodule
