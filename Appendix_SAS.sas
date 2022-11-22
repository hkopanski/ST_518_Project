*libname project '/home/u52654547/ST518/Project';

data eff;
	input brand$ temp stirred$ order time;
	datalines;
name	6	yes	8	77.21546623
name	23	yes	3	75.37855207
name	40	yes	7	68.08491677
store	6	yes	1	77.87371483
store	23	yes	2	66.3843648
store	40	yes	18	59.82388393
name	6	yes	9	75.9429317
name	23	yes	4	69.0893732
name	40	yes	10	64.45156243
store	6	yes	12	77.3394716
store	23	yes	5	66.1417243
store	40	yes	19	59.30260653
name	6	yes	17	75.84152623
name	23	yes	6	73.56526743
name	40	yes	11	65.86350487
store	6	yes	15	77.8908945
store	23	yes	20	65.92808613
store	40	yes	21	58.24407393
name	6	yes	23	75.80972853
name	23	yes	14	72.73261297
name	40	yes	13	65.01375273
store	6	yes	16	76.24402373
store	23	yes	22	66.3108573
store	40	yes	24	59.13058173
name	6	no	34	79.01464587
name	23	no	36	76.3021997
name	40	no	28	70.63537563
store	6	no	31	80.92176503
store	23	no	30	67.08352567
store	40	no	25	58.5391963
name	6	no	41	79.7212952
name	23	no	37	76.06895157
name	40	no	29	69.99943167
store	6	no	35	77.78344813
store	23	no	32	67.93137777
store	40	no	26	59.13561007
name	6	no	44	79.07405083
name	23	no	42	76.8326456
name	40	no	33	70.38357203
store	6	no	39	79.43210273
store	23	no	38	67.1640595
store	40	no	27	58.84538307
name	6	no	46	78.15246253
name	23	no	48	76.2502474
name	40	no	47	71.20207503
store	6	no	45	79.83228
store	23	no	43	67.88313463
store	40	no	40	59.33370287
;


/* Fit an All Random Model with both Brand and Temp as random factors
*/
title 'ALL Random Model with both Brand and Temp as random factors';
proc mixed data=eff method=type3 plots=residualpanel;
  class  brand temp;
  model time= / solution;
  random temp brand brand*temp;
run;

/* Fit a Mixed Model with Brand as random and Temp as fixed factors
*/
title 'Mixed Model with Brand as random and Temp as fixed factors';
proc mixed data=eff method=type3 plots=residualpanel;
  class  brand temp;
  model time=temp / solution;
  random brand brand*temp;
run;

/* Fit a Mixed Model with Brand as fixed and Temp as random factors
*/
title 'Mixed Model with Brand as fixed and Temp as random factors';
proc mixed data=eff method=type3 plots=residualpanel;
  class  brand temp;
  model time=brand / solution;
  random temp brand*temp;
run;

title 'ALL Fixed Model with Stirred included in 3 factor interaction';
proc glm data=eff plots=diagnostics;
 class stirred brand temp;
 model time=stirred|brand|temp;
 lsmeans stirred*brand*temp;
 run;

title 'ALL Fixed Model with Stirred included in 3 factor interaction with Fit Statistics';
proc glmselect data=eff;
  class stirred brand temp;
  model time=stirred|brand|temp/ stats = all;
run;
