//This demonstrates how a non random variable can be randomized.

class nonRandBase;
    int unsigned a;
    integer b;
endclass

class randChild extends nonRandBase;
    rand int unsigned c;
    rand integer d;
    constraint c1 {c<32; d>=32; d<64;}

    function void post_randomize ();
        a = c; b = d;
    endfunction
endclass

program test;
    nonRandBase nrb; //has non random variables
    randChild rc; //has random variables
    initial begin
        nrb = new();
        rc = new();
        
        //No radomization, as the variables are non random. Default value retained
        nrb.randomize();
        $display("1. Values of variables - nrb.a=%0d, nrb.b=%0d", nrb.a, nrb.b);
        
        //Randomizing non random variable wont be caught as a failure in randomization
        if (nrb.randomize())
            $display("2. Values of variables - nrb.a=%0d, nrb.b=%0d", nrb.a, nrb.b);

        //Randomize, non random variable by giving the specific variable name - Yes, it works !!!
        for (int i=3; i<=5; i++) begin
            nrb.randomize (a) with {a<100;};
            nrb.randomize (b) with {b>=0;b<50;};
            $display("%0d. Values of variables - nrb.a=%0d, nrb.b=%0d", i, nrb.a, nrb.b);
        end

        //Use the extended class and randomize
        for (int i=6; i<=8; i++) begin
            rc.randomize();
            $display("6. Values of variables - rc.a=%0d, rc.b=%0d, rc.c=%0d, rc.d=%0d", rc.a, rc.b, rc.c, rc.d);
        end
    end
endprogram

/*
Simulation Output:
1. Values of variables - nrb.a=0, nrb.b=x
2. Values of variables - nrb.a=0, nrb.b=x
3. Values of variables - nrb.a=38, nrb.b=25
4. Values of variables - nrb.a=13, nrb.b=24
5. Values of variables - nrb.a=53, nrb.b=0
6. Values of variables - rc.a=6, rc.b=39, rc.c=6, rc.d=39
6. Values of variables - rc.a=19, rc.b=58, rc.c=19, rc.d=58
6. Values of variables - rc.a=3, rc.b=51, rc.c=3, rc.d=51
*/
