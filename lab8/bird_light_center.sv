module bird_light_center (in, fall, uplit, downlit, out, clk, reset);

	input logic in, fall, uplit, downlit, clk, reset;
	output logic out;
	
	enum {off, lit} ps, ns;
	
	// next state logic
	always_comb begin
		case(ps)
			off: if (in & downlit) ns = lit;
				  else if (fall & uplit) ns = lit;
				  else ns = off;
			lit: if (in | fall) ns = off;
				  else ns = lit;
		endcase
	end
	
	//output logic
	always_comb begin
		case(ps)
			off: out = 1'b0;
			lit: out = 1'b1;
		endcase
	end
	
	//DFF
	always_ff @(posedge clk) begin
		if (reset)
			ps <= lit;
		else
			ps <= ns;
	end
	
endmodule
