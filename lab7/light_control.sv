module light_control (player1, player2, ledout, win1, win2, clk, reset);
	input logic player1, player2, clk, reset;
	output logic [8:0] ledout;
	output logic win1, win2;
	
	enum {led1, led2, led3, led4, led5, led6, led7, led8, led9, victory1, victory2} ps, ns;
	
	// setting up outputs to simply logic blocks
	logic [8:0] ledoff, lit1, lit2, lit3, lit4, lit5, lit6, lit7, lit8, lit9;
	logic [6:0] hex1, hex2, hexoff;
	assign ledoff = 9'b000000000;
	assign lit9 = 9'b100000000;
	assign lit8 = 9'b010000000;
	assign lit7 = 9'b001000000;
	assign lit6 = 9'b000100000;
	assign lit5 = 9'b000010000;
	assign lit4 = 9'b000001000;
	assign lit3 = 9'b000000100;
	assign lit2 = 9'b000000010;
	assign lit1 = 9'b000000001;
	
	
	//Next state logic
	always_comb begin
		case (ps)
			led9: if (player1) ns = victory1;
					else if (player2) ns = led8;
					else ns = led9;
			led8: if (player1) ns = led9;
					else if (player2) ns = led7;
					else ns = led8;
			led7: if (player1) ns = led8;
					else if (player2) ns = led6;
					else ns = led7;
			led6: if (player1) ns = led7;
					else if (player2) ns = led5;
					else ns = led6;
			led5: if (player1) ns = led6;
					else if (player2) ns = led4;
					else ns = led5;
			led4: if (player1) ns = led5;
					else if (player2) ns = led3;
					else ns = led4;
			led3: if (player1) ns = led4;
					else if (player2) ns = led2;
					else ns = led3;
			led2: if (player1) ns = led3;
					else if (player2) ns = led1;
					else ns = led2;
			led1: if (player1) ns = led2;
					else if (player2) ns = victory2;
					else ns = led1;
			victory1: ns = led5;
			victory2: ns = led5;
		endcase
	end
	
	//win1 Output logic
	always_comb begin
		case (ps)
			led9: if (player1) win1 = 1'b1;
					else win1 = 1'b0;
			default: win1 = 1'b0;
		endcase
	end
	
	//win2 Output logic
	always_comb begin
		case (ps)
			led1: if (player2) win2 = 1'b1;
					else win2 = 1'b0;
			default: win2 = 1'b0;
		endcase
	end
	
	// LED output logic
	always_comb begin
		case (ps)
			led9: if (player1) ledout = ledoff;
					else if (player2) ledout = lit8;
					else ledout = lit9;
			led8: if (player1) ledout = lit9;
					else if (player2) ledout = lit7;
					else ledout = lit8;
			led7: if (player1) ledout = lit8;
					else if (player2) ledout = lit6;
					else ledout = lit7;
			led6: if (player1) ledout = lit7;
					else if (player2) ledout = lit5;
					else ledout = lit6;
			led5: if (player1) ledout = lit6;
					else if (player2) ledout = lit4;
					else ledout = lit5;
			led4: if (player1) ledout = lit5;
					else if (player2) ledout = lit3;
					else ledout = lit4;
			led3: if (player2) ledout = lit2;
					else ledout = lit3;
			led2: if (player1) ledout = lit3;
					else if (player2) ledout = lit1;
					else ledout = lit2;
			led1: if (player2) ledout = ledoff;
					else if (player1) ledout = lit2;
					else ledout = lit1;
			default: ledout = ledoff;
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= led5;
		else
			ps <= ns;
	end
endmodule 

module light_control_testbench();
	logic player1, player2, CLOCK_50, reset;
	logic [8:0] ledout;
	logic win1, win2;

	light_control dut (.player1, .player2, .ledout, .win1, .win2, .clk(CLOCK_50), .reset);
	
	// Set up a simulated clock.
	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; // Forever toggle the clock
	end
	
	// Test the design
	initial begin
		reset <= 1; player1 <= 0; player2 <= 0; repeat(2) @(posedge CLOCK_50); // reset the module
		
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); // player 1 press 
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 1 release
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); // player 1 press
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 1 release
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); // player 1 press
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 1 release
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); // player 1 press
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 1 release
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); // player 1 press
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 1 release
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); // player 1 press
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 1 release
		
		reset <= 1; player1 <= 0; player2 <= 0; repeat(2) @(posedge CLOCK_50); // reset the module
		
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); // player 2 press 
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 2 release
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); // player 2 press
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 2 release
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); // player 2 press 
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 2 release
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); // player 2 press 
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 2 release
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); // player 2 press
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 2 release
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); // player 2 press 
		reset <= 0;	player1 <= 0; player2 <= 0;  @(posedge CLOCK_50); // player 2 release
		
		reset <= 1; player1 <= 0; player2 <= 0; repeat(2) @(posedge CLOCK_50); // reset the module
		
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); // alternating presses
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); 
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); 
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); 
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); 
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); 
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); 
		reset <= 0;	player1 <= 0; player2 <= 1;  @(posedge CLOCK_50); 
		reset <= 0;	player1 <= 1; player2 <= 0;  @(posedge CLOCK_50); 
		
		reset <= 1; player1 <= 0; player2 <= 0; repeat(2) @(posedge CLOCK_50); // reset the module
		$stop; // End the simulation.
	end
endmodule 