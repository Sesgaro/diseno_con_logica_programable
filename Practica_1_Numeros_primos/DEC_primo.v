module DEC_primo(
	input [3:0] num,
	output reg led
);

	always @(*) begin
		case(num)
			2:led=1;
			3:led=1;
			5:led=1;
			7:led=1;
			11:led=1;
			13:led=1;
			default:led=0;
		endcase
	end

endmodule
