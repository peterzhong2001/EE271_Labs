module counter (victory, hexout, clk, reset);
	input logic victory, clk, reset;
	output logic [6:0] hexout;
	enum {v0, v1, v2, v3, v4, v5, v6, v7} ps, ns;
	
	logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7;
	assign hex0 = 7'b1000000; // 0
	assign hex1 = 7'b1111001; // 1
	assign hex2 = 7'b0100100; // 2
	assign hex3 = 7'b0110000; // 3
	assign hex4 = 7'b0011001; // 4
	assign hex5 = 7'b0010010; // 5
	assign hex6 = 7'b0000010; // 6
	assign hex7 = 7'b1111000; // 7

	// Next state logic
	always_comb begin
		case (ps)
			v0: if (victory) ns = v1;
				 else ns = v0;
			v1: if (victory) ns = v2;
				 else ns = v1;
			v2: if (victory) ns = v3;
				 else ns = v2;
			v3: if (victory) ns = v4;
				 else ns = v3;
			v4: if (victory) ns = v5;
				 else ns = v4;
			v5: if (victory) ns = v6;
				 else ns = v5;
			v6: if (victory) ns = v7;
				 else ns = v6;
			v7: ns = v7;
		endcase
	end
	
	// Output logic
	always_comb begin
		case (ps)
			v0: if (victory) hexout = hex1;
				 else hexout = hex0;
			v1: if (victory) hexout = hex2;
				 else hexout = hex1;
			v2: if (victory) hexout = hex3;
				 else hexout = hex2;
			v3: if (victory) hexout = hex4;
				 else hexout = hex3;
			v4: if (victory) hexout = hex5;
				 else hexout = hex4;
			v5: if (victory) hexout = hex6;
				 else hexout = hex5;
			v6: if (victory) hexout = hex7;
				 else hexout = hex6;
			v7: hexout = hex7;
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= v0;
		else
			ps <= ns;
	end
endmodule 