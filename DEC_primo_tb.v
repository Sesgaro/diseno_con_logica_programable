module DEC_primo_tb();
	reg [3:0] num;
	wire led;
	
	DEC_primo dut(.num(num), .led(led));
	
	initial begin
        num = 1;	#10;
		  num = 2;	#10;
		  num = 3;	#10;
		  num = 4;	#10;
		  num = 5;	#10;
		  num = 6;	#10;
		  num = 7;	#10;
		  num = 8;	#10;
		  num = 9;	#10;
		  num = 10;	#10;
		  num = 11;	#10;
		  num = 12;	#10;
		  num = 13;	#10;
		  num = 14;	#10;
		  num = 15;	#10;
		  $stop;
		  $finish;
    end
	 initial begin
		$monitor("inicia simulacion");
	 end
	 initial begin
		$dumpfile("DEC_primo.vcd");
		$dumpvars(0, DEC_primo_tb);
    end
endmodule 