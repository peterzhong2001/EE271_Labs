// make user's button push 1 clock cycle long
module input_processing (A, out, clk);

	input logic A, clk;
	output logic out;
	
	enum {none, hold} ps, ns;
	
	// Next state logic
	always_comb begin
		case(ps)
			none: if (A) ns = hold;
					else ns = none;
			hold: if (A) ns = hold;
					else ns = none;
		endcase
	end
	
	// Output logic
	always_comb begin
		case (ps)
			none: if (A) out = 1'b1;
					else out = 1'b0;
			hold: out = 1'b0;
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin
			ps <= ns;
	end
endmodule 