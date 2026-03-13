module BCD_4displays_tb #(parameter n_in=10, n_out=28)();

	reg   [n_in-1:0] bcd_in;
	wire	[n_out-1:0] bcd_out;
	
	BCD_4displays dut(.bcd_in(bcd_in), .bcd_out(bcd_out));
	
	initial begin
		$display("Sim iniciada");
		repeat (20) begin
			bcd_in=$random%1024; #10;
		end
		$display("Sim terminada");
		$finish;
	end
	initial begin
	    $dumpfile("BCD_4displays_tb.vcd");
	    $dumpvars(0, BCD_4displays_tb);
    end
endmodule