module stabilizer (in1, in2, A, B, clk);
	input logic in1, in2, clk;
	output logic A, B;
	
	logic X, Y;
	
	D_FF d1 (.q(X), .d(in1), .clk);
	D_FF d2 (.q(A), .d(X), .clk);
	D_FF d3 (.q(Y), .d(in2), .clk);
	D_FF d4 (.q(B), .d(Y), .clk);

endmodule 


module stabilizer_testbench();
	logic in1, in2, A, B, CLOCK_50;

	stabilizer dut (.in1, .in2, .A, .B, .clk(CLOCK_50));
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	// Test the design
	initial begin
		in1 <= 1; in2 <= 0;  @(posedge CLOCK_50); // player 1 press 
		in1 <= 0; in2 <= 0;  @(posedge CLOCK_50); // player 1 release
		in1 <= 1; in2 <= 0;  @(posedge CLOCK_50); // player 1 press
		in1 <= 0; in2 <= 0;  @(posedge CLOCK_50); // player 1 release
	
		in1 <= 0; in2 <= 1;  @(posedge CLOCK_50); // player 2 press 
		in1 <= 0; in2 <= 0;  @(posedge CLOCK_50); // player 2 release
		in1 <= 0; in2 <= 1;  @(posedge CLOCK_50); // player 2 press
		in1 <= 0; in2 <= 0;  @(posedge CLOCK_50); // player 2 release
		
		in1 <= 1; in2 <= 0;  @(posedge CLOCK_50); // alternating presses
		in1 <= 0; in2 <= 1;  @(posedge CLOCK_50); 
		in1 <= 1; in2 <= 0;  @(posedge CLOCK_50); 
		in1 <= 0; in2 <= 1;  @(posedge CLOCK_50); 
		in1 <= 1; in2 <= 0;  @(posedge CLOCK_50); 
		in1 <= 0; in2 <= 1;  @(posedge CLOCK_50); 
		in1 <= 1; in2 <= 0;  @(posedge CLOCK_50); 
		in1 <= 0; in2 <= 1;  @(posedge CLOCK_50); 
		in1 <= 1; in2 <= 0;  @(posedge CLOCK_50); 
			
		$stop; // End the simulation.
	end
endmodule 