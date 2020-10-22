//This code demonstrates how to generate mutually exclusive fields in a class and some weighted distribution.
//In this example, the class consists of command type and intention to write. Command type can be No Operation,
//ReaD, WRite and WRite with RESPponse. Write intention can be Write or No Write. There can be two types of 
//stimulus - All good stimulus, which does not generate NOPs and create a write intention with read command etc.
//Another type of stimulus the generates good as well as bad stimulus, which can generate errors like read
//command with write intent.
//Mutually exclusive character of stimulus is demonstrated with the constraint where W as wr intent is not
//generated wtih RD as command.

typedef enum bit [1:0] {NOP, RD, WR, WR_RESP} cmdType;
typedef enum {W, NW} wrInt;

class test;
    rand cmdType    cmd;
    rand wrInt      wrIntent;
    bit allGood = 1;

    //Constraint to generate type of command using weighted distribution
    constraint cmdWt {
        if (allGood)    //Generate all good cmds - No NOP
            //NOP weight = 0; RD weight = 1/3; WR weight = 1/3; WR_RESP = 1/3;
            cmd dist {NOP := 0, RD := 30, WR := 30, WR_RESP := 30};
        else
            //NOP weight = 10/100; RD = 30/100; WR = 30/100; WR_RESP = 30/100
            cmd dist {NOP := 10, RD := 30 , WR := 30, WR_RESP := 30};
    }

    //Constraint not to generate mutually exclusive combinations of cmd type and write intention
    //For example, in a good command, write intention must be No Write (NW) in a read command. In a error
    //command, it can be allowed. Similarly, in a write command, it can be W or NW. So, a distribution is
    //followed, to have more write and less no-writes. If it not all good commands, it can have errors also.
    //In such commands, W and NW are equally distribute in both read and write commands.
    constraint wrInt {
        if (allGood) {
            (cmd == RD) -> wrIntent == NW;
            (cmd == WR || cmd == WR_RESP) -> wrIntent dist{NW := 3, W := 7};
        }
        else {
            (cmd == RD) -> wrIntent dist {NW := 5, W := 5};
            (cmd == WR || cmd == WR_RESP) -> wrIntent dist{NW := 5, W := 5};
        }
    }
endclass

program chkConstraint;
    test t;
    initial begin
        t = new();
        //Generate all good commands
        $display("All Good Commands");
        for (int i=0; i<20; i++) begin
            t.randomize();
            $display (t);
        end
        
        //Generate all commands including NOPS
        t.allGood = 0;
        $display("\n\nAll Commands");
        for (int i=0; i<20; i++) begin
            t.randomize();
            $display (t);
        end
    end
endprogram

/*
Simulation Output:
All Good Commands
'{cmd:WR, wrIntent:W, allGood:'h1}
'{cmd:WR_RESP, wrIntent:W, allGood:'h1}
'{cmd:WR, wrIntent:W, allGood:'h1}
'{cmd:RD, wrIntent:NW, allGood:'h1}
'{cmd:WR, wrIntent:NW, allGood:'h1}
'{cmd:WR_RESP, wrIntent:W, allGood:'h1}
'{cmd:RD, wrIntent:NW, allGood:'h1}
'{cmd:RD, wrIntent:NW, allGood:'h1}
'{cmd:WR, wrIntent:NW, allGood:'h1}
'{cmd:WR, wrIntent:NW, allGood:'h1}
'{cmd:RD, wrIntent:NW, allGood:'h1}
'{cmd:WR_RESP, wrIntent:W, allGood:'h1}
'{cmd:WR_RESP, wrIntent:W, allGood:'h1}
'{cmd:WR_RESP, wrIntent:NW, allGood:'h1}
'{cmd:WR_RESP, wrIntent:W, allGood:'h1}
'{cmd:RD, wrIntent:NW, allGood:'h1}
'{cmd:WR_RESP, wrIntent:NW, allGood:'h1}
'{cmd:WR_RESP, wrIntent:NW, allGood:'h1}
'{cmd:WR, wrIntent:NW, allGood:'h1}
'{cmd:WR_RESP, wrIntent:W, allGood:'h1}


All Commands
'{cmd:RD, wrIntent:NW, allGood:'h0}
'{cmd:WR_RESP, wrIntent:W, allGood:'h0}
'{cmd:WR_RESP, wrIntent:W, allGood:'h0}
'{cmd:NOP, wrIntent:W, allGood:'h0}
'{cmd:WR, wrIntent:NW, allGood:'h0}
'{cmd:NOP, wrIntent:NW, allGood:'h0}
'{cmd:RD, wrIntent:W, allGood:'h0}
'{cmd:WR, wrIntent:NW, allGood:'h0}
'{cmd:NOP, wrIntent:W, allGood:'h0}
'{cmd:WR, wrIntent:NW, allGood:'h0}
'{cmd:WR_RESP, wrIntent:W, allGood:'h0}
'{cmd:WR_RESP, wrIntent:NW, allGood:'h0}
'{cmd:WR, wrIntent:NW, allGood:'h0}
'{cmd:WR, wrIntent:W, allGood:'h0}
'{cmd:RD, wrIntent:NW, allGood:'h0}
'{cmd:WR, wrIntent:W, allGood:'h0}
'{cmd:RD, wrIntent:W, allGood:'h0}
'{cmd:WR_RESP, wrIntent:W, allGood:'h0}
'{cmd:RD, wrIntent:NW, allGood:'h0}
'{cmd:WR, wrIntent:NW, allGood:'h0}
*/
