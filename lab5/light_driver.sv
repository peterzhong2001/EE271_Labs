module light_driver (clk, left, right, out, reset);
	input logic clk, left, right, reset;
	output logic [2:0] out;
	
	// State variables
	enum { A, B, C, D } ps, ns;
	
	//Next State logic
	//A: 010; B: 100; C: 101; D: 001;
	always_comb begin
		case (ps)
			A: if (right) ns = D;
				else if (left) ns = B;
				else ns = C;
			B: if (right) ns = A;
				else if (left) ns = D;
				else ns = C;
			C: ns = A;
			D: if (right) ns = B;
				else if (left) ns = A;
				else ns = C;
		endcase
	end
	
	// Output logic
	always_comb begin
		case (ps)
			A: if (right) out = 3'b001;
				else if (left) out = 3'b100;
				else out = 3'b101;
			B: if (right) out = 3'b010;
				else if (left) out = 3'b001;
				else out = 3'b101;
			C: out = 3'b010;
			D: if (right) out = 3'b100;
				else if (left) out = 3'b010;
				else out = 3'b101;
		endcase
	end
	
	// DFFs
	always_ff @(posedge clk) begin
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end
endmodule 