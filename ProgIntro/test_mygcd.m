function test_mygcd()
    ok=0;
    try
        mygcd(0,0);
    catch ME
        ok=1;
    end
    assert(ok==1);
    
   assert(mygcd(3,7)==1);
   assert(mygcd(7,3)==1);
   assert(mygcd(3,9)==3);
   assert(mygcd(9,3)==3);
   
   assert(mygcd(6,10)==2);
   assert(mygcd(10,6)==2);

   assert(mygcd(18,30)==6);
   assert(mygcd(30,18)==6);
   
   display("ok")
   
end