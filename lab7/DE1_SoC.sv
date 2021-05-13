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
	
	// Assign wire variables
	logic reset, clk, A, win1, win2;
	logic compout;
	logic [1:0] out;
	logic [9:0] LFSRout;
	assign reset = SW[9];
	
	// assigning clock
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] div_clk;
	parameter whichClock = 15;
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk));
	
	
	// assign clk = CLOCK_50;
	assign clk = div_clk[whichClock];
	
	// Stabilize player input to A
	stabilizer s1 (.in(KEY[3]), .A, .clk);
	
	// Set up LFSR, output to LFSRout
	LFSR l1 (.clk, .out(LFSRout), .reset);
	
	// Set up comparator, output to compout
	comparator comp1 (.A({1'b0, SW[8:0]}), .B(LFSRout), .result(compout));
	
   // Process input, player input to out[1], cyber input to out[0]
	input_processing IP (.A, .B(~compout), .out, .clk);
	
	// Output to LED and Hex
	light_control LC (.player1(out[1]), .player2(out[0]), .ledout(LEDR[9:1]), .win1, .win2, .clk, .reset);
	
	// 2 counters for the 2 players
	counter c1 (.victory(win1), .hexout(HEX5), .clk, .reset);
	counter c2 (.victory(win2), .hexout(HEX0), .clk, .reset);
	
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
		SW[8:0] <= 9'b000000000; @(posedge CLOCK_50); // setting the comparator
		SW[9] <= 1; KEY[3] <= 1;  repeat(2) @(posedge CLOCK_50); // reset the module
		
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		SW[9] <= 0;	KEY[3] <= 0;   @(posedge CLOCK_50); // player 1 press and hold
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // player 1 release
		

		SW[9] <= 1; KEY[3] <= 1;  repeat(2) @(posedge CLOCK_50); // reset the module
		
		SW[9] <= 0;	KEY[3] <= 0;   repeat(4) @(posedge CLOCK_50); // player 1 press and hold for 4 cycles
		SW[9] <= 0;	KEY[3] <= 1;   @(posedge CLOCK_50); // release
		
		SW[9] <= 1; KEY[3] <= 1;  repeat(2) @(posedge CLOCK_50); // reset the module
		$stop; // End the simulation.
	end
endmodule
