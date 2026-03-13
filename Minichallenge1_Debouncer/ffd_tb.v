module ffd_tb();
	reg d, clk, rst;
	wire q;
	ffd dut(.d(d), .clk(clk), .rst(rst), .q(q));
	initial begin
		clk=0;
		forever #5 clk=~clk;
	end
	
	initial begin
		$display("Sim iniciada");
		rst=1; 	#100;
		d<=1;		#100;
		d<=0;		#100;
		d<=1;		#100;
		
		$display("Sim terminada");
		$finish;
	end
endmodule