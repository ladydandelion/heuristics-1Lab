set AIRPLANES;
set SLOTS;

param baggage {s in SLOTS};
param pricing {s in SLOTS};
param seats {a in AIRPLANES};
param capacity {a in AIRPLANES};

var x {a in AIRPLANES, s in SLOTS}, integer;

maximize profits:
    sum {a in AIRPLANES, s in SLOTS} pricing[s]*x[a][s];