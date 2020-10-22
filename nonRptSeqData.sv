//Constraint to create non repetitive data by remembering the history

//Method1 - Generate all the values at one go with SV's own unique method,
//store them in an array at the start of the test and use it as required.
class test1;
  rand bit [31:0] addr [5];
  constraint nonRptAddr {
    unique{addr};
  }
endclass

//Method2 - Generate one value at a time, store it in a queue. When a new
//value is generated, ensure it is not already available in the queue.
class test2;
  rand bit [31:0] addr;
  bit [31:0] prevAddr [$];

  constraint nonRptAddr {
    foreach (prevAddr[n])
        addr != prevAddr[n];
  }

  function void post_randomize ();
    prevAddr.push_back(addr);
  endfunction
endclass

program chkConstraint;
  test1 t1;
  test2 t2;
  
  initial
    begin
        t1 = new();
        t2 = new();
        t1.randomize;
        for (int i=0;i<$size(t1.addr);i++) begin
            $display("Mtd1 :: Value of t1.addr[%0x] is 0x%0x",i,t1.addr[i]);
        end
      
        for (int i=0;i<5; i++) begin
            t2.randomize;
            $display("Mtd2 :: %0d - Value of t2.addr is 0x%0x", i, t2.addr);
        end
    end
endprogram

/*
Simulation Output:
Mtd1 :: Value of t1.addr[0] is 0x815f8d74
Mtd1 :: Value of t1.addr[1] is 0x7bb6d188
Mtd1 :: Value of t1.addr[2] is 0x401079a
Mtd1 :: Value of t1.addr[3] is 0x471cef5f
Mtd1 :: Value of t1.addr[4] is 0xe1e26284
Mtd2 :: 0 - Value of t2.addr is 0xfaba4738
Mtd2 :: 1 - Value of t2.addr is 0x992fb362
Mtd2 :: 2 - Value of t2.addr is 0x8369c082
Mtd2 :: 3 - Value of t2.addr is 0x31b6ffb
Mtd2 :: 4 - Value of t2.addr is 0x5e9fe4e5
*/
