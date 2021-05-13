module stabilizer (in, A, clk);
	input logic in, clk;
	output logic A;
	
	logic X;
	
	D_FF d1 (.q(X), .d(in), .clk);
	D_FF d2 (.q(A), .d(X), .clk);

endmodule 


module stabilizer_testbench();
	logic in, A, CLOCK_50;

	stabilizer dut (.in, .A, .clk(CLOCK_50));
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	// Test the design
	initial begin

		in <= 1;   @(posedge CLOCK_50); // alternating presses
		in <= 0;   @(posedge CLOCK_50); 
		in <= 1;   @(posedge CLOCK_50); 
		in <= 0;   @(posedge CLOCK_50); 
		in <= 1;   @(posedge CLOCK_50); 
		in <= 0;   @(posedge CLOCK_50); 
		in <= 1;   @(posedge CLOCK_50); 
		in <= 0;   @(posedge CLOCK_50); 
		in <= 1;   @(posedge CLOCK_50); 
			
		$stop; // End the simulation.
	end
endmodule 