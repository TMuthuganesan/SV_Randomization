//Constraint to generate random size of a dynamic array. In this case, a data packet
//with variable lenght need to be created, every time it is randomized. The length
//and the contents of the array are both randomized here.

class test;
    rand bit [31:0] dataPkt [];

    constraint datLen {
        dataPkt.size >= 10;
        dataPkt.size <= 20;
    }

    constraint data {
        unique {dataPkt};
    }
endclass

program test;
    test t;

    initial begin
        t = new();
        for (int i=0; i <= 5; i++) begin
            t.randomize();
            $display ("Data pkt length = %0d",t.dataPkt.size);
            $display (t);
        end
    end
endprogram

/*
Simulation Output:
Data pkt length = 11
'{dataPkt:'{'hcf578554, 'hfad5c89b, 'hcf21010, 'haeb011de, 'h79e8075f, 'hbc3080d8, 'had9a49ab, 'h3af75429, 'h5a975252, 'ha437e049, 'heb4ec449} }
Data pkt length = 17
'{dataPkt:'{'h5c5691a1, 'h9642a094, 'h28010d0d, 'hd918322e, 'h637635f3, 'ha09830ca, 'h24bb14c1, 'h85ac530c, 'hdffad34b, 'h9a21b59f, 'habfd4645, 'hf6ac3bec, 'hdbddedd2, 'h21afad8c, 'hde304f87, 'h600defd7, 'h40e3afe0} }
Data pkt length = 11
'{dataPkt:'{'h112ecf3f, 'h6b2a2e11, 'h1178bb8a, 'hef568138, 'ha6bc9e11, 'h252c109d, 'he2e2aaf9, 'h73a34a2b, 'hb126ef38, 'h1f3031fd, 'h2ed23139} }
Data pkt length = 15
'{dataPkt:'{'hc33e9a06, 'ha72fe0ac, 'h656cd541, 'hb9c209e0, 'h13d98e4, 'hd4d15918, 'h871b4f75, 'ha3c063cb, 'h7c2b15d, 'h75cbf98d, 'hb8676314, 'h8e386b44, 'h7f508371, 'hce276442, 'h94aaf301} }
Data pkt length = 20
'{dataPkt:'{'h74f86a91, 'h2eea77ea, 'hab62c647, 'hbc123061, 'h4b7a4fdc, 'h4a368559, 'h4e2e7197, 'h585c2d78, 'hd1852ef0, 'hef92fa08, 'hb031e11c, 'h803ed421, 'h261913ad, 'ha03c2021, 'h192e6783, 'hbe88c7da, 'h14d6e0df, 'h1c27ee92, 'h56b28f57, 'hb7e42fd3} }
Data pkt length = 10
'{dataPkt:'{'h3eeaf0d3, 'h285eef34, 'h207eb7cd, 'h3310627c, 'h1b1c3d72, 'hb5d7c920, 'hd5795643, 'hfb9bbe, 'had09c033, 'he6178624} }
*/
