module servo_control#(parameter frec_servo=50, frec_clk=50_000_000, minD=2, maxD=12)( //25MHz
	input [7:0] in,
	input clk, rst,
	output [0:20] display,
	output reg pwm
	);
	reg [7:0] grados;
   localparam MAX_COUNT = (frec_clk / frec_servo)/2; 
 
	localparam BITS_COUNT = ceillog2(MAX_COUNT);

	localparam m = ((maxD * MAX_COUNT / 100) - (minD * MAX_COUNT / 75)) / 180;
	localparam b = (minD * MAX_COUNT) / 75;

	wire [BITS_COUNT-1:0] count;
	
	counter #(.max_count(MAX_COUNT), .n(BITS_COUNT)) pwm1 (.clk(clk), .rst(rst), .count(count));
	BCD_4displays #(.bits_in(8), .displays(3)) bcd (.bcd_in(grados), .bcd_out(display));
	
	always @(posedge clk or negedge rst) begin
		if(rst==0) begin
			pwm=0;
		end
		else begin
			if(in>180)
				grados=180;
			else
				grados=in;
			if(count<((m*grados)+b))
				pwm=1;
			else
				pwm=0;
		end
	end
	
	function integer ceillog2;
     input integer data;
     integer i,result;
		  begin
			 for(i=0; 2**i < data; i=i+1)
				 result = i + 1;
			 ceillog2 = result;
		  end
    endfunction
endmodule