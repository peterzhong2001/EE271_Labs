module lab3 (U, P, C, M, Discount, Theft);
	input logic U, P, C, M;
	output logic Discount, Theft;
	
	// Setting up output variables
	logic a1Out, n1Out, nor1Out, nor2Out;
	
	//Setting up all gates and connections
	and a1 (a1Out, U, C);
	not n1 (n1Out, U);
	or o1 (Discount, a1Out, P);
	nor nor1 (nor2Out, P, n1Out, M);
	nor nor2 (nor1Out, P, C, M);
	or o2 (Theft, nor1Out, nor2Out);
endmodule 