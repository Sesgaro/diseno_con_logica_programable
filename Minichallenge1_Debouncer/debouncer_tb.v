module debouncer_tb();
    reg clk, rst, btn;
    wire btn_db, btn_db_pk;

    debouncer dut(.clk(clk), .btn(btn), .rst(rst), .btn_db(btn_db), .btn_db_pk(btn_db_pk));
 
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

 
    initial begin
        $display("Sim iniciada");
		  rst=1; 	#10;
        rst=0; 	#10;
		  rst=1; 	#10;
        btn = 1; 	#1000;
        btn = 0; 	#10;
        btn = 1; 	#10;
        btn = 0; 	#10;
        btn = 1; 	#10;
        
        btn = 0; 	#1000; 

        btn = 1; 	#10;
        btn = 0; 	#10;
        btn = 1; 	#1000;

        $display("Sim terminada");
        $finish;
    end
	 initial begin
		$dumpfile("debouncer_tb.vcd");
		$dumpvars(0, debouncer_tb);
    end
endmodule