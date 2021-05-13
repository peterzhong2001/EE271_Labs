module comparator (A, B, result);

	input logic [9:0] A, B;
	output logic result;
	
	assign result = (A > B);

endmodule 