/*
This module takes a 4 bit number corresponding to the
number of note to play and outputs the frequency
associated with that number. These frequencies came from
https://pages.mtu.edu/~suits/notefreqs.html
*/

module NoteEncoder(input logic [3:0] note, output logic [12:0] freq);
    always_comb
        case(note)
            0:       freq = 262; // C4
            1:       freq = 294; // D4
            2:       freq = 330; // E4
            3:       freq = 349; // F4
            4:       freq = 392; // G4
            5:       freq = 440; // A5
            6:       freq = 494; // B5
            7:       freq = 523; // C5
            8:       freq = 587; // D5
            9:       freq = 659; // E5
            default: freq = 0;
        endcase
endmodule