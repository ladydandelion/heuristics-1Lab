# SETS
----------------------------------------------------------------------------------
set AIRPLANES;
set SLOTS;

# PARAMS
----------------------------------------------------------------------------------
param baggage {s in SLOTS};
param pricing {s in SLOTS};
param seats {a in AIRPLANES,s in SLOTS};
#param totalAirplaneSeats{a in AIRPLANES};
param capacity {a in AIRPLANES};

# DECISION VARIABLES
----------------------------------------------------------------------------------
var x {a in AIRPLANES, s in SLOTS}, integer;

# OPTIMIZATION FUNCTION
----------------------------------------------------------------------------------
maximize profits:
        sum {a in AIRPLANES, s in SLOTS} (pricing[a][s]*x[a][s]);

# DECISION VARIABLES
----------------------------------------------------------------------------------
s.t. sum{a in AIRPLANES}  <= totalAirplaneSeats[a]
s.t  
