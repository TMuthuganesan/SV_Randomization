// Write a constraint to generate a random value for a ver1 [7:0] within 50
// and var2 [7:0] with the non repeated value in every randomization

class test;
    rand bit [7:0] var1, var2;

    constraint c_var1 {var1<50;}
    constraint c_var2 {var2 != var1;}
endclass

program chkConstraint;
    test t;
    initial begin
        t = new();
        for (int i=0;i<10;i++) begin
            t.randomize;
            $display("var1=0x%0x, var2=0x%0x",t.var1, t.var2);
        end
    end
endprogram

/*
var1=0x18, var2=0x81
var1=0xd, var2=0x4
var1=0x4, var2=0xe1
var1=0x2a, var2=0x6a
var1=0x29, var2=0x53
var1=0x23, var2=0x98
var1=0x1d, var2=0x5c
var1=0x2a, var2=0x28
var1=0x1f, var2=0x63
var1=0x1a, var2=0x24
*/
