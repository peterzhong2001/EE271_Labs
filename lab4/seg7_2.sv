module seg7_2 (bcd1, bcd2, leds1, leds2);
	input logic [3:0] bcd1;
	input logic [3:0] bcd2;
	output logic [6:0] leds1;
	output logic [6:0] leds2;

	seg7 display1 (.bcd(bcd1), .leds(leds1));
	seg7 display2 (.bcd(bcd2), .leds(leds2));
	
endmodule 