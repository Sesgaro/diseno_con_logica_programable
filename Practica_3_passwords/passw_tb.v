module passw_tb();
	reg [3:0] in;
	reg btn,rst;
	wire [27:0] out;

	passw DUT(.dig(in), .btn(btn), .rst(rst), .display(out));

	initial begin
		rst=1;
	end


	initial begin
		rst=0;	#10
		rst=1;	#10
		in=1; 	#10;
		btn=1;	#10;
		btn=0;   #10;
		
		in=2; 	#10;
		btn=1;	#10;
		btn=0;   #10;
		
		in=3; 	#10;
		btn=1;	#10;
		btn=0;   #10;
		
		in=4; 	#10;
		btn=1;	#10;
		btn=0;   #10;
		btn=1;	#10;
		btn=0;   #10;
		
		
		rst = 0; 	#10;
		rst=1;
		
		repeat(3) begin
			repeat(4) begin
				in = $random%2; #10;
				btn=1;	#10;
				btn=0;   #10;
			end
			btn=1;	#10;
			btn=0;   #10;
			
			rst = 0; 	#10;
			rst=1;
		end
		$finish;
	end

	initial begin
		$monitor("Entrada= %b, Salida=%b",in,out);
	end

	initial begin
		 $dumpfile("passw_tb.vcd");
		 $dumpvars(0, passw_tb);
	end
 
endmodule