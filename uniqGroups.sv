//I have a 7 bit par_groups. Every time I randomize, I need to pick 3 groups that are unique and less than 32.
//par_groups is one among these three groups

class test;
    rand bit [6:0] par_groups;
    rand bit[4:0] group1;
    rand bit[4:0] group2;
    rand bit[4:0] group3;

    constraint uniqGrps {
        unique{group1, group2, group3};
    }

    constraint parGrpSel {
        par_groups inside {group1, group2, group3};
    }

endclass

program chkConstraint;
  test t;
  
  initial
    begin
      t = new();
      for (int i=0;i<10;i++) begin
        t.randomize;
        $display("Value of groups are group1=0x%0x, group2=0x%0x, group3=0x%0x",t.group1, t.group2, t.group3);
        $display("value of par_groups=0x%0x",t.par_groups);
      end
    end
endprogram

/*
Value of groups are group1=0x10, group2=0xf, group3=0x0
value of par_groups=0x10
Value of groups are group1=0x13, group2=0x16, group3=0xb
value of par_groups=0xb
Value of groups are group1=0x15, group2=0x1e, group3=0x13
value of par_groups=0x15
Value of groups are group1=0x19, group2=0x12, group3=0x0
value of par_groups=0x12
Value of groups are group1=0x15, group2=0x17, group3=0x9
value of par_groups=0x9
Value of groups are group1=0x9, group2=0xb, group3=0x1a
value of par_groups=0x9
Value of groups are group1=0x4, group2=0x14, group3=0x3
value of par_groups=0x4
Value of groups are group1=0xa, group2=0x16, group3=0x15
value of par_groups=0x16
Value of groups are group1=0x14, group2=0x2, group3=0x18
value of par_groups=0x18
Value of groups are group1=0xf, group2=0x9, group3=0xb
value of par_groups=0xf
*/
