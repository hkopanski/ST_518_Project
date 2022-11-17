libname project '/home/u52654547/ST518/Project';


/* Fit an All Random Model with both Brand and Temp as random factors
*/
title 'ALL Random Model with both Brand and Temp as random factors';
proc mixed data=project.eff method=type3 plots=residualpanel;
  class  brand temp;
  model time=;
  random temp brand brand*temp;
run;


/* Fit a Mixed Model with Brand as random and Temp as fixed factors
*/
title 'Mixed Model with Brand as random and Temp as fixed factors';
proc mixed data=project.eff method=type3 plots=residualpanel;
  class  brand temp;
  model time=temp;
  random brand brand*temp;
run;

/* Fit a Mixed Model with Brand as fixed and Temp as random factors
*/
title 'Mixed Model with Brand as fixed and Temp as random factors';
proc mixed data=project.eff method=type3 plots=residualpanel;
  class  brand temp;
  model time=brand;
  random temp brand*temp;
run;

title 'ALL Fixed Model with Stirred included in 3 factor interaction';
proc glm data=project.eff plots=diagnostics;
 class stirred brand temp;
 model time=stirred|brand|temp;
 lsmeans stirred*brand*temp;
 run;
 
 
