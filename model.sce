/////////////////////////parameter values/////////////////////////////////////////
Nzero=100 //N0
wintersurv=0.7 //Winter survival rate
monthsurv=0.92 //Survival rate of adults at age 1
monthsurv2=0.82 //Survival rate of adults at age 2
monthsurv3=0.7 //Survival rate of adults at age 3
Njaj1=1 //Number of eggs laid by adults at age 1 during 1st month of the breeding season
Njaj2=1 //Number of eggs laid by adults at age 1 during 2nd month of the breeding season
Njaj3=10 //Number of eggs laid by adults at age 1 during 3rd month of the breeding season
Njaj4=2 //Number of eggs laid by adults at age 2 during 1st month of the breeding season
Njaj5=2 //Number of eggs laid by adults at age 2 during 2nd month of the breeding season
Njaj6=15 //Number of eggs laid by adults at age 2 during 3rd month of the breeding season
eggsurv=0.4//Eggs hatching rate
juvsurv=0.5 //Survival rate of juveniles
///////////////////////////////////////////////////////////////////////////////////


function [N]=f(t)
///////Fixed values for starting season/////////////
stop=t*6
N1(1)=0
N1(2)=0
N1(3)=0
N1(4)=0
N1(5)=100
N1(6)=90
N2(1)=63
N2(2)=57
N2(3)=51
N2(4)=41
N2(5)=15
N2(6)=4
N3(1)=3
N3(2)=3
N3(3)=2
N3(4)=2
N3(5)=1
N3(6)=0
j(1)=1
j(2)=2
j(3)=3
j(4)=4
j(5)=5
j(6)=6
Eggs1(1)=Njaj1
Eggs1(2)=Njaj2
Eggs1(3)=Njaj3
Eggs1(4)=0
Eggs1(5)=0
Eggs1(6)=0
Eggs2(1)=Njaj4
Eggs2(2)=Njaj5
Eggs2(3)=Njaj6
Eggs2(4)=0
Eggs2(5)=0
Eggs2(6)=0
hatch(1)=0
hatch(2)=N1(1)*Eggs1(1)*eggsurv+N2(1)*Eggs2(1)*eggsurv
hatch(3)=N1(2)*Eggs1(2)*eggsurv+N2(2)*Eggs2(2)*eggsurv
hatch(4)=N1(3)*Eggs1(3)*eggsurv+N2(3)*Eggs2(3)*eggsurv
hatch(5)=N1(4)*Eggs1(4)*eggsurv+N2(4)*Eggs2(4)*eggsurv
hatch(6)=N1(5)*Eggs1(5)*eggsurv+N2(5)*Eggs2(5)*eggsurv
juv(1)=0
juv(2)=juv(1)*juvsurv+hatch(2)
juv(3)=juv(2)*juvsurv+hatch(3)
juv(4)=juv(3)*juvsurv+hatch(4)
juv(5)=juv(4)*juvsurv+hatch(5)
juv(6)=juv(5)*juvsurv+hatch(6)

N(1)=round(N1(1)+N2(1)+N3(1)+juv(1))
N(2)=round(N1(2)+N2(2)+N3(2)+juv(2))
N(3)=round(N1(3)+N2(3)+N3(3)+juv(3))
N(4)=round(N1(4)+N2(4)+N3(4)+juv(4))
N(5)=round(N1(5)+N2(5)+N3(5)+juv(5))
N(6)=round(N1(6)+N2(6)+N3(6)+juv(6))
/////////////////////////////////////////////////////////////////////////


for i=7:stop
    j(i)=i

    lagmaj(i)=i-7
    lagczerwiec(i)=i-8
    laglipiec(i)=i-9
    lagsierpien(i)=i-10
    lagwrzesien(i)=i-11
    lagpazdziernik(i)=i-12
       
        //May
        if modulo(lagmaj(i),6)==0 then 
        Eggs1(i)=Njaj1;
        Eggs2(i)=Njaj4;
        hatch(i)=0;
        juv(i)=(juv(i-1)-juv(i-5))*wintersurv;
        N1(i)=round(0.85*juv(i-5)*wintersurv);
        N2(i)=round(N1(i-1)*wintersurv);
        N3(i)=round(N2(i-1)*monthsurv3);
            
       //June
       elseif modulo(lagczerwiec(i),6)==0 
       Eggs1(i)=Njaj2;
       Eggs2(i)=Njaj5;
       hatch(i)=N1(i-1)*Eggs1(i-1)*eggsurv+N2(i-1)*Eggs2(i-1)*eggsurv;
       juv(i)=hatch(i);
       N1(i)=round(N1(i-1)*monthsurv+0.95*juv(i-1)*monthsurv);
       N2(i)=round(N2(i-1)*monthsurv);
       N3(i)=round(N3(i-1)*monthsurv3);
      
        //July
        elseif modulo(laglipiec(i),6)==0
        Eggs1(i)=Njaj3;
        Eggs2(i)=Njaj6; 
        hatch(i)=N1(i-1)*Eggs1(i-1)*eggsurv+N2(i-1)*Eggs2(i-1)*eggsurv;
        juv(i)=juv(i-1)*juvsurv+hatch(i);
        N1(i)=N1(i-1)*monthsurv+0.05*juv(i-2)*monthsurv;
        N2(i)=N2(i-1)*monthsurv;
        N3(i)=N3(i-1)*monthsurv3;
        
        
        //August
        elseif modulo(lagsierpien(i),6)==0 
        Eggs1(i)=0;
        Eggs2(i)=0; 
        hatch(i)=N1(i-1)*Eggs1(i-1)*eggsurv+N2(i-1)*Eggs2(i-1)*eggsurv;
        juv(i)=juv(i-1)*juvsurv+hatch(i);
        N1(i)=N1(i-1)*monthsurv;
        N2(i)=N2(i-1)*monthsurv; 
        N3(i)=N3(i-1)*monthsurv3;
           
        //September
        elseif modulo(lagwrzesien(i),6)==0
        Eggs1(i)=0;
        Eggs2(i)=0; 
        hatch(i)=N1(i-1)*Eggs1(i-1)*eggsurv+N2(i-1)*Eggs2(i-1)*eggsurv;
        juv(i)=juv(i-1)*juvsurv-0.15*juv(i-3)+hatch(i);
        N1(i)=N1(i-1)*monthsurv+0.15*juv(i-3);
        N2(i)=N2(i-1)*monthsurv2;
        N3(i)=N3(i-1)*monthsurv3;
              
        //October
        elseif modulo(lagpazdziernik(i),6)==0
        Eggs1(i)=0;
        Eggs2(i)=0;
        hatch(i)=N1(i-1)*Eggs1(i-1)*eggsurv+N2(i-1)*Eggs2(i-1)*eggsurv;
        juv(i)=juv(i-1)*juvsurv+hatch(i);
        N1(i)=N1(i-1)*monthsurv;
        N2(i)=N2(i-1)*monthsurv3;
        N3(i)=N3(i-1)*monthsurv3;
        
        else
        N1(i)=999999999999;
        N2(i)=999999999999;
        N3(i)=999999999999;
        juv(i)=99999999999;
      end
N(i)=round(N1(i)+N2(i)+N3(i)+juv(i));   
 
end
plot(j,N,'black')
endfunction
