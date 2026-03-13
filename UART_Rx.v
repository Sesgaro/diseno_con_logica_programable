module UART_Rx #(parameter BAUD_RATE = 9600, parameter CLOCK_FREQ = 50000000, parameter BITS = 8)(
    input wire clk,
    input wire rst,
    input wire rx_in,          
    output reg [BITS-1:0] data_out,
    output reg data_ready,
    output reg busy            
);
    localparam IDLE = 2'b00, START_BIT = 2'b01, DATA_BITS = 2'b10, STOP_BIT  = 2'b11;

    reg [1:0] state;
    reg [15:0] baud_counter;
    reg [3:0] bit_index;
    reg [BITS-1:0] rx_shift_reg;
    localparam BAUD_LIMIT = CLOCK_FREQ / BAUD_RATE;
	 
    always @(posedge clk or negedge rst) begin
        if (rst == 0) begin
            state <= IDLE;
            data_out <= 0;
            data_ready <= 0;
            busy <= 0;
            baud_counter <= 0;
            bit_index <= 0;
            rx_shift_reg <= 0;
				
        end else begin
            data_ready <= 0;
            case (state)
                IDLE: begin
                    busy <= 0;
                    baud_counter <= 0;
                    bit_index <= 0;
						  data_ready <= 0;
                    if (rx_in == 0) begin
                        state <= START_BIT;
                        busy <= 1;
                    end
                end

					START_BIT: begin
                    if (baud_counter < (BAUD_LIMIT - 1)) begin
                        baud_counter <= baud_counter + 1;
                    end else begin
                        baud_counter <= 0;
                        state <= DATA_BITS;
                        bit_index <= 0;
                    end
                end

                DATA_BITS: begin
                    if (baud_counter == (BAUD_LIMIT / 2)) begin
                         rx_shift_reg[bit_index] <= rx_in;
                    end
                    
                    if (baud_counter < BAUD_LIMIT - 1) begin
                        baud_counter <= baud_counter + 1;
                    end else begin
                        baud_counter <= 0;
                        if (bit_index < BITS - 1) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            state <= STOP_BIT;
                        end
                    end
                end
                STOP_BIT: begin
                    if (baud_counter < BAUD_LIMIT - 1) begin
                        baud_counter <= baud_counter + 1;
                    end else begin
                        data_out <= rx_shift_reg;
                        data_ready <= 1;
                        baud_counter <= 0;
                        busy <= 0;
								state <= IDLE;
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end
endmodule