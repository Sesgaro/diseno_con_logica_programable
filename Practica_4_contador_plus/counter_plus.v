module counter_plus #(parameter max_count = 8'd100)(
    input clk, 
    input rst, 
    input load_btn, 
    input updown,
    input [7:0] load_bits,
    output reg [7:0] count
);

    reg load_ch;
    reg aux;

    always @(posedge clk or negedge rst) begin  
        if (rst == 1'b0) begin
            count         	<= 8'b0;  
				load_ch       	<= 1'b0;
            aux 				<= 1'b0;
        end 
		  
		  else begin
            if (load_btn == 1'b1 && aux == 1'b0) begin
                load_ch <= ~load_ch;
            end
				aux <= load_btn;
				
            case (load_ch)
                0 : begin
                    if (updown) begin
                        if (count >= max_count)
                            count <= 8'b0;
                        else 
                            count <= count + 1'b1;
                    end 
						  else begin
                        if (count == 8'b0)
                            count <= max_count;
                        else
                            count <= count - 1'b1;
                    end
                end
                1 : begin
                    if (load_bits <= max_count)
                        count <= load_bits;
                    else begin
                        count <= max_count; 
                    end
                end
            endcase
        end
    end
endmodule