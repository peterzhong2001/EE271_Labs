// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	input logic CLOCK_50; // 50MHz clock.
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY; // True when not pressed, False when pressed
	input logic [9:0] SW;

	// Turn off the hex display
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	// Assign reset
	logic reset;
	assign reset = ~KEY[0];
	
	// Generate clk off of CLOCK_50, whichClock picks rate.
	logic [31:0] div_clk;
	parameter whichClock = 25; // 0.75 Hz clock
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk));
	
	// Clock selection; allows for easy switching between simulation and board clocks
	logic clkSelect;
	
	// Uncomment ONE of the following two lines depending on intention
	// assign clkSelect = CLOCK_50; // for simulation
	assign clkSelect = div_clk[whichClock]; // for board
	
	// Sequential Logic for cycling lights in each state
	light_driver ld (.clk(clkSelect), .left(SW[0]), .right(SW[1]), .out(LEDR[2:0]), .reset);
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
		KEY[0] <= 0; 								 repeat(5) @(posedge CLOCK_50); // 5 cycles of Holding reset
		KEY[0] <= 1; SW[1] <= 0; SW[0] <= 0; repeat(6) @(posedge CLOCK_50); // 6 cycles of calm
		KEY[0] <= 1; SW[1] <= 0; SW[0] <= 1; repeat(6) @(posedge CLOCK_50); // 6 cycles of right to left
		KEY[0] <= 1; SW[1] <= 1; SW[0] <= 0; repeat(6) @(posedge CLOCK_50); // 6 cycles of left to right
		$stop; // End the simulation.
	end
endmodule
