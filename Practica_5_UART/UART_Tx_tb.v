module UART_Tx_tb();

//Señales para el transmisor
reg clk;
reg rst;
reg [7:0] data_in;
reg start;
//wire tx_out;
wire busy;

//Señales intermedias
wire UART_wire; // Conexión entre TX y RX

//Señales para el receptor
//reg rx_in;
wire [7:0] data_out;
wire data_ready;

UART_Tx #(.BAUD_RATE(9600), .CLOCK_FREQ(50000000), .BITS(8)) UART_TX (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .start(start),
    .tx_out(UART_wire),
    .busy(busy)
);

UART_Rx #(.BAUD_RATE(9600), .CLOCK_FREQ(50000000), .BITS(8)) UART_RX (
    .clk(clk),
    .rst(rst),
    .rx_in(UART_wire),
    .data_out(data_out),
    .data_ready(data_ready)
);


initial begin
    clk = 0;
    rst = 1;
    data_in = 8'h00;
    start = 0;
end

always
    #10 clk = ~clk; // Genera un reloj de 50 MHz

initial
begin
    $display("Simulación iniciada");
    #30;
    rst = 0; 
    #20;        
    rst = 1; 
    #200; 

    repeat(10) begin
        @(posedge clk);        
        data_in = $random;     
        start = 1;             
        @(posedge clk);
        start = 0;

        wait(data_ready == 1); 
        
        $display("Dato transmitido: %h, Dato recibido: %h", data_in, data_out);
        #100; 
        wait(!busy); 
        #500; 
    end
    $display("Simulación finalizada exitosamente");
    $stop;
end


initial begin
   $dumpfile("UART_Tx_tb.vcd");
   $dumpvars(0, UART_Tx_tb);
end

endmodule
