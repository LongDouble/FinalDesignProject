module NoteEncoder(input logic [3:0] note, output logic [12:0] freq);
    always_comb
        case(note)
            0:       freq = 262; 
            1:       freq = 294;
            2:       freq = 330;
            3:       freq = 349;
            4:       freq = 392;
            5:       freq = 440;
            6:       freq = 494;
            7:       freq = 523;
            8:       freq = 587;
            9:       freq = 659;
            default: freq = 0;
        endcase
endmodule