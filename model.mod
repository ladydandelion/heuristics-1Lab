# SETS
----------------------------------------------------------------------------------
set AIRPLANES;
set PLANE1;
set PLANE2;
set PLANE3;
set PLANE4;
set PLANE5;
set SLOTS;
set TYPE1;
set TYPE2;
set TYPE3;

# PARAMS
----------------------------------------------------------------------------------
param baggage {s in SLOTS};
param pricing {s in SLOTS};
param totalAirplaneSeats{a in AIRPLANES};
param capacity {a in AIRPLANES};

# DECISION VARIABLES
----------------------------------------------------------------------------------
var x {a in AIRPLANES, s in SLOTS} integer, >= 0;

# OPTIMIZATION FUNCTION
----------------------------------------------------------------------------------
maximize Profits:
    sum {a in AIRPLANES, s in SLOTS} pricing[s]*x[a][s];

# DECISION VARIABLES
----------------------------------------------------------------------------------
s.t. constraint1 {a in AIRPLANES}:
    sum {s in SLOTS} x[a][s]  <= totalAirplaneSeats[a];
s.t.  constarint2 {a in AIRPLANES}:
    sum {s in SLOTS} bagagge[s]*x[a][s] <= capacity[a];
s.t.  constraint3 {a in AIRPLANES, s in TYPE2}:
    x[a][s] >= 20;
s.t.  constraint4 {a in AIRPLANES, s in TYPE3}:
    x[a][s] >= 10;
s.t. con0straint5:
    sum {a in AIRPLANES, s in TYPE1} x[a][s] >= 0.6*(sum {a in AIRPLANES, s in SLOTS} x[a][s]);
solve;
display x;
end;