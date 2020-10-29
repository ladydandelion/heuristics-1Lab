# SETS
----------------------------------------------------------------------------------
set AIRPLANES;
set SLOTS;

# PARAMS
----------------------------------------------------------------------------------
param baggage {s in SLOTS};
param pricing {s in SLOTS};
param totalAirplaneSeats{a in AIRPLANES};
param capacity {a in AIRPLANES};
param numberSeats{a in AIRPLANES, }

# DECISION VARIABLES
----------------------------------------------------------------------------------
var x {a in AIRPLANES, s in SLOTS}, integer;

# OPTIMIZATION FUNCTION
----------------------------------------------------------------------------------
maximize profits:
        sum {a in AIRPLANES, s in SLOTS} (pricing[s]*x[a][s]);

# DECISION VARIABLES
----------------------------------------------------------------------------------
s.t. constraint1:
          sum{a in AIRPLANES, s in SLOTS} x[a][s]  <= totalAirplaneSeats[a]
s.t  constarint2:
          sum{a in AIRPLANES, s in SLOTS} bagagge[s]*x[a][s] <= capacity[a]
s.t  constraint3:
          {x[a][s]>=20
          x12>= 20
          x22>=20
