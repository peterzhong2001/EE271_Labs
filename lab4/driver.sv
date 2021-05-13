module driver (UPC, leds0, leds1, leds2, leds3, leds4, leds5);
	input logic [2:0] UPC;
	output logic [6:0] leds0, leds1, leds2, leds3, leds4, leds5;
	
	logic [6:0] A, C, E, H, I, L, O, P, S, T, U;
	integer i;
	
	//assigning 7-bit values to letters
	assign A = 7'b1110111;
	assign C = 7'b0111001;
	assign E = 7'b1111001;
	assign H = 7'b1110110;
	assign I = 7'b0000110;
	assign L = 7'b0111000;
	assign O = 7'b0111111;
	assign P = 7'b1110011;
	assign S = 7'b1101101;
	assign T = 7'b1111000;
	assign U = 7'b0111110;
	
	always_comb begin
		//1st letter
		case (UPC)
			3'b000: leds5 = T;
			3'b001: leds5 = C;
			3'b011: leds5 = C;
			3'b100: leds5 = C;
			3'b101: leds5 = P;
			3'b110: leds5 = P;
			default: leds5 = 7'bX;
		endcase
		
		//2nd letter
		case (UPC)
			3'b000: leds4 = E;
			3'b001: leds4 = H;
			3'b011: leds4 = H;
			3'b100: leds4 = L;
			3'b101: leds4 = I;
			3'b110: leds4 = L;
			default: leds4 = 7'bX;
		endcase
		
		//3rd letter
		case (UPC)
			3'b000: leds3 = A;
			3'b001: leds3 = A;
			3'b011: leds3 = I;
			3'b100: leds3 = O;
			3'b101: leds3 = S;
			3'b110: leds3 = A;
			default: leds3 = 7'bX;
		endcase
		
		//4th letter
		case (UPC)
			3'b000: leds2 = C;
			3'b001: leds2 = L;
			3'b011: leds2 = S;
			3'b100: leds2 = S;
			3'b101: leds2 = T;
			3'b110: leds2 = T;
			default: leds2 = 7'bX;
		endcase
		//5th letter
		case (UPC)
			3'b000: leds1 = U;
			3'b001: leds1 = E;
			3'b011: leds1 = E;
			3'b100: leds1 = E;
			3'b101: leds1 = O;
			3'b110: leds1 = E;
			default: leds1 = 7'bX;
		endcase
		
		//6th letter
		case (UPC)
			3'b000: leds0 = P;
			3'b001: leds0 = T;
			3'b011: leds0 = L;
			3'b100: leds0 = T;
			3'b101: leds0 = L;
			3'b110: leds0 = S;
			default: leds0 = 7'bX;
		endcase
		
		//inverting all the outputs
		for (i=0; i<= 6; i++) begin
			leds0[i] = ~leds0[i];
			leds1[i] = ~leds1[i];
			leds2[i] = ~leds2[i];
			leds3[i] = ~leds3[i];
			leds4[i] = ~leds4[i];
			leds5[i] = ~leds5[i];
		end
	end
endmodule 