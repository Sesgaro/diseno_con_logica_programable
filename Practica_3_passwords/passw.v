module passw(
    input [3:0] dig,
    input btn, rst, clk,
    output reg [0:27] display
);

    parameter IDLE=3'd0, S0=3'd1, S1=3'd2, S2=3'd3, S3=3'd4, S4=3'd5;
    reg [2:0] state, nextstate;
    reg [0:6] aux;
	 reg btn_a;
	 reg [15:0] contra =16'h1234;
	 
	 always @(posedge clk or negedge rst) begin
			if (rst == 0) begin
            state <= S0;
				display <= ~28'b0;
			end 
			else begin
				if (state == S4) display <= ~28'b0111101_0011101_0011101_1111011;
				else if (state==IDLE) display <= ~28'b0000000_0111101_1110111_0011111;
				
				if (btn == 1'b0 && btn_a == 1'b1) begin
					if (display[21:27]==~7'b0000_000) begin
						 display[7:27] <= display[0:20];
						 
						 display[0:6]  <= aux;
						 
						 state <= nextstate;
						 
					end 
					else begin
						 if (state == S4)
							  display <= ~28'b0111101_0011101_0011101_1111011;
					end
				end
				btn_a <= btn;
			end
		endw
		
    always @(*) begin
        case(dig)
            0 : aux = ~7'b1111_110;
            1 : aux = ~7'b0110_000;
            2 : aux = ~7'b1101_101;
            3 : aux = ~7'b1111_001;
            4 : aux = ~7'b0110_011;
            5 : aux = ~7'b1011_011;
            6 : aux = ~7'b1011_111;
            7 : aux = ~7'b1110_000;
            8 : aux = ~7'b1111_111;
            9 : aux = ~7'b1111_011;
            10: aux = ~7'b1110_111;
            11: aux = ~7'b0011_111;
            12: aux = ~7'b0001_101;
            13: aux = ~7'b0111_101;
            14: aux = ~7'b1001_111;
            15: aux = ~7'b1000_111;
            default: aux = ~7'b0000_000;
        endcase
    end
	 
    always @(*) begin
        nextstate = S0;
        case(state)
				IDLE: nextstate = IDLE;
            S0: 
					if(contra[3:0] == dig) 
						nextstate = S1;
					else 
						nextstate = IDLE;
            S1: 
					if(contra[7:4] == dig) 
						nextstate = S2; 
					else 
						nextstate = IDLE;
            S2: 
					if(contra[11:8] == dig) 
						nextstate = S3; 
					else 
						nextstate = IDLE;
            S3: 
					if(contra[15:12] == dig) 
						nextstate = S4;
					else 
						nextstate = IDLE;
            default: nextstate = IDLE;
        endcase
    end

endmodule