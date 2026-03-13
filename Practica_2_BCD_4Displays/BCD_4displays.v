module BCD_4displays #(parameter bits_in=8, displays=3)(
	input  [bits_in-1:0] bcd_in,
	output reg [0:(displays*7)-1] bcd_out);
	
	wire [(displays*4)-1:0] val;

	reg [displays-2:0] aux;

	assign val [3:0]	= bcd_in % 10;	

	genvar i;
	generate
		for(i=2;i<=displays;i=i+1)	begin : unidades
			assign val [(i*4)-1:(i-1)*4] = (bcd_in/10**(i-1)) % 10;
		end
	endgenerate
	
	always @(*) begin
		case(val[(displays*4)-1:(displays-1)*4])
			0 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b0000_000;
			1 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b0110_000;
			2 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b1101_101;
			3 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b1111_001;
			4 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b0110_011;
			5 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b1011_011;
			6 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b1011_111;
			7 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b1110_000;
			8 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b1111_111;
			9 : bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b1111_011;			
			default: bcd_out[(displays-1)*7:(displays*7)-1] = ~7'b1001_111;
		endcase
	end
	
	generate
		for(i=displays-2; i>=0; i=i-1) begin : display
			always @(*) begin
				aux[i] = (bcd_out[((i+1)*7):6+((i+1)*7)] != 7'b1111_111);
				
				case(val[3+(i*4):(i*4)])
					0 : begin
						if (aux[i] || i == 0) begin
							bcd_out[(i*7):6+(i*7)] = ~7'b1111_110;
						end 
						else begin
							bcd_out[(i*7):6+(i*7)] = ~7'b0000_000;
						end
					end
					1 : bcd_out[(i*7):6+(i*7)] = ~7'b0110_000;
					2 : bcd_out[(i*7):6+(i*7)] = ~7'b1101_101;
					3 : bcd_out[(i*7):6+(i*7)] = ~7'b1111_001;
					4 : bcd_out[(i*7):6+(i*7)] = ~7'b0110_011;
					5 : bcd_out[(i*7):6+(i*7)] = ~7'b1011_011;
					6 : bcd_out[(i*7):6+(i*7)] = ~7'b1011_111;
					7 : bcd_out[(i*7):6+(i*7)] = ~7'b1110_000;
					8 : bcd_out[(i*7):6+(i*7)] = ~7'b1111_111;
					9 : bcd_out[(i*7):6+(i*7)] = ~7'b1111_011;			
					default: bcd_out[(i*7):6+(i*7)] = ~7'b1001_111;
				endcase
			end
		end
	endgenerate
	
endmodule