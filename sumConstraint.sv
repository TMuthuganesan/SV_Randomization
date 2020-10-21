//Constraint to set only 9 bits as one in address
class test;
  rand bit [31:0] addr;
  constraint addr31 {
    addr <= (2**$bits(addr))-1;
  }

  constraint addr9bits {
    $countones(addr) == 9;
  }
endclass

program chkConstraint;
  test t;
  
  initial
    begin
      t = new();
      for (int i=0;i<10;i++) begin
        t.randomize;
        $display("Value of addr is 0x%0x",t.addr);
      end
    end
endprogram

/*
Simulation Output:
Value of addr is 0xcc0a8120
Value of addr is 0x9601a028
Value of addr is 0x2554418
Value of addr is 0x26a02058
Value of addr is 0x420a6620
Value of addr is 0xc221404a
Value of addr is 0x26802524
Value of addr is 0xc820874
Value of addr is 0x88242429
Value of addr is 0x21900554
*/
