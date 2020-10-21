//Contstraint to set any 9 bits of a 32 bit address to 1
//Additional constraint is not to set any 2 consecutive bits to 1
//

class test;
    rand bit addr_ary [32];
    rand bit [31:0] addr;

    constraint noAdjBitsOne {
        foreach (addr_ary[i]) {
            if (addr_ary[i] && i<31)
                addr_ary[i+1] != addr_ary[i];
        }
    }

    constraint numBits {
        addr_ary.sum() with ($countones(item)) == 9;
    }

    function void post_randomize();
        foreach (addr_ary[i]) begin
            addr[i] = addr_ary[i];
        end
    endfunction
endclass

program chkConstraint;
  test t;
  initial
    begin
      t = new();
      for (int i=0;i<10;i++) begin
        t.randomize;
        $display("Value of addr is 0x%0x",t.addr);

        //Checker
        if ($countones(t.addr) != 9) $error("Number of ones in address not equal to 9");
        for (int i=0; i <31; i++) begin
            if (t.addr[i]==1 && (t.addr[i]==t.addr[i+1])) $error("Two adjacent bits in address are ones at bit %0d",i);
        end
      end
    end
endprogram

/*
Simulation Output:
Value of addr is 0xa84495
Value of addr is 0x2212495
Value of addr is 0xa88a814
Value of addr is 0x2490a224
Value of addr is 0x402548a1
Value of addr is 0x525445
Value of addr is 0x9249222
Value of addr is 0x2291542
Value of addr is 0x12aa4a
Value of addr is 0x2aaaa
*/
