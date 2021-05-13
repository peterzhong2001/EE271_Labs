module input_processing (A, B, out, clk);

	input logic A, B, clk;
	output logic [1:0] out;
	// out[1] is player1, out[0] is player2
	
	enum {none, bpress, apress, hold} ps, ns;
	
	// Next state logic
	always_comb begin
		case(ps)
			none: if (A & B) ns = none;
					else if (A & (~B)) ns = bpress;
					else if ((~A) & B) ns = apress;
					else ns = hold;
			bpress: if (A & B) ns = none;
					else if (A & (~B)) ns = bpress;
					else if ((~A) & B) ns = apress;
					else ns = hold;
			apress: if (A & B) ns = none;
					else if (A & (~B)) ns = bpress;
					else if ((~A) & B) ns = apress;
					else ns = hold;
			hold: if (A & B) ns = none;
					else if (A & (~B)) ns = bpress;
					else if ((~A) & B) ns = apress;
					else ns = hold;
		endcase
	end
	
	// Output logic
	always_comb begin
		case (ps)
			none: if (A & (~B)) out = 2'b01;
					else if ((~A) & B) out = 2'b10;
					else out = 2'b00;
			bpress: if (A & (~B)) out = 2'b01;
					  else if ((~A) & B) out = 2'b10;
					  else out = 2'b00;
			apress: if (~B) out = 2'b01;
					  else out = 2'b00;
			hold: if (~B) out = 2'b01;
					else out = 2'b00;
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin
			ps <= ns;
	end
endmodule 

module input_processing_testbench();
	logic A, B, CLOCK_50;
	logic [1:0] out;

	input_processing dut (.A, .B, .out, .clk(CLOCK_50));
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	// Test the design
	initial begin
		A <= 1; B <= 1; repeat(2) @(posedge CLOCK_50);
		
			A <= 1; B <= 1;  @(posedge CLOCK_50); // player 1 press and hold 
			A <= 0; B <= 1;  @(posedge CLOCK_50); // player 1 release
			A <= 1; B <= 1;  @(posedge CLOCK_50); // player 1 press and hold 
			A <= 0; B <= 1;  @(posedge CLOCK_50); // player 1 release
			A <= 1; B <= 1;  @(posedge CLOCK_50); // player 1 press and hold 
			A <= 0; B <= 1;  @(posedge CLOCK_50); // player 1 release
		
		A <= 1; B <= 1; repeat(2) @(posedge CLOCK_50);
		
			A <= 1; B <= 1;  @(posedge CLOCK_50); // player 2 press and hold 
			A <= 1; B <= 0;  @(posedge CLOCK_50); // player 2 release
			A <= 1; B <= 1;  @(posedge CLOCK_50); // player 2 press and hold 
			A <= 1; B <= 0;  @(posedge CLOCK_50); // player 2 release
			A <= 1; B <= 1;  @(posedge CLOCK_50); // player 2 press and hold 
			A <= 1; B <= 0;  @(posedge CLOCK_50); // player 2 release
		
		A <= 1; B <= 1; repeat(2) @(posedge CLOCK_50);
		
			A <= 0; B <= 1;  @(posedge CLOCK_50); // player 1 press and hold 
			A <= 0; B <= 0;  @(posedge CLOCK_50); // player 2 press and hold , player 1 keep holding
			A <= 0; B <= 1;  @(posedge CLOCK_50); // player 2 release, player 1 keep holding
			A <= 0; B <= 0;  @(posedge CLOCK_50); // player 2 press and hold , player 1 keep holding
			A <= 1; B <= 1;  @(posedge CLOCK_50); // both release
		
		A <= 1; B <= 1; repeat(2) @(posedge CLOCK_50);
		
			A <= 1; B <= 0;  @(posedge CLOCK_50); // player 2 press and hold 
			A <= 0; B <= 0;  @(posedge CLOCK_50); // player 1 press and hold , player 2 keep holding
			A <= 1; B <= 0;  @(posedge CLOCK_50); // player 1 release, player 2 keep holding
			A <= 0; B <= 0;  @(posedge CLOCK_50); // player 1 press and hold , player 2 keep holding
			A <= 1; B <= 1;  @(posedge CLOCK_50); // both release
		
		A <= 1; B <= 1; repeat(2) @(posedge CLOCK_50);
		$stop; // End the simulation.
	end
endmodule 