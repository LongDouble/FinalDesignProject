module IRDecoder(input logic [7:0] value, output logic [3:0] result);
    always_comb
        case(value)
            8'b01101101: result = 0;
            8'b11111101: result = 1;
            8'b01111101: result = 2;
            8'b10111101: result = 3;
            8'b00111101: result = 4;
            8'b11011101: result = 5;
            8'b01011101: result = 6;
            8'b10011101: result = 7;
            8'b00011101: result = 8;
            8'b11101101: result = 9;
            default:     result = 0;
        endcase
endmodule