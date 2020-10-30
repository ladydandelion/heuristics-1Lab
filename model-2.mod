/*SETS
----------------------------------------------------------------------------------*/
set AIRPLANES;
set PLANE1;
set PLANE2;
set PLANE3;
set PLANE4;
set PLANE5;

set AVAILABLESLOTS;
set AVAILABLESLOT1;
set AVAILABLESLOT2;
set AVAILABLESLOT3;
set AVAILABLESLOT4;
set AVAILABLESLOT5;
set AVAILABLESLOT6;
set AVAILABLESLOT7;
set AVAILABLESLOT8;
set AVAILABLESLOT9;
set AVAILABLESLOT10;
set AVAILABLESLOT11;

set PAIR1;
set PAIR2;
set PAIR3;
set PAIR4;
set PAIR5;

/*PARAMS
----------------------------------------------------------------------------------*/
param slotstime {s in AVAILABLESLOTS};
param schedulelandingtime {a in AIRPLANES};
param maxallotedtime {a in AIRPLANES};
param costs {a in AIRPLANES};

/*DECISION VARIABLES
----------------------------------------------------------------------------------*/
var AssignedPlaneSlots {a in AIRPLANES, s in AVAILABLESLOTS} integer, >=0;

/*OPTIMIZATION FUNCTION
----------------------------------------------------------------------------------*/
minimize DelayCosts:
    sum {a in AIRPLANES, s in AVAILABLESLOTS} costs[a]*(AssignedPlaneSlots[a,s]*slotstime[s] - schedulelandingtime[a]);

/*DECISION VARIABLES
----------------------------------------------------------------------------------*/
s.t. constraint44:
    sum {a in AIRPLANES, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] = 5;

s.t. constraint1 {a in PLANE1}:
    sum {s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint2 {a in PLANE2}:
    sum {s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint3 {a in PLANE3}:
    sum {s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint4 {a in PLANE4}:
    sum {s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint5 {a in PLANE5}:
    sum {s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;

s.t. constarint6 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT1} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint7 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT2} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint8 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT3} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint9 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT4} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint10 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT5} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint11 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT6} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint12 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT7} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint13 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT8} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint14 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT9} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint15 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT10} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint16 {a in AIRPLANES}:
    sum {s in AVAILABLESLOT11} AssignedPlaneSlots[a,s] <= 1;

s.t. constraint17 {a in AIRPLANES, s in AVAILABLESLOTS}:
    AssignedPlaneSlots[a,s]*slotstime[s] - schedulelandingtime[a] >= 5;

s.t. constraint18 {a in PLANE1, s in AVAILABLESLOTS}:
    AssignedPlaneSlots[a,s]*slotstime[s] - schedulelandingtime[a] <= maxallotedtime[a] - schedulelandingtime[a];
s.t. constraint19 {a in PLANE2, s in AVAILABLESLOTS}:
    AssignedPlaneSlots[a,s]*slotstime[s] - schedulelandingtime[a] <= maxallotedtime[a] - schedulelandingtime[a];
s.t. constraint20 {a in PLANE3, s in AVAILABLESLOTS}:
    AssignedPlaneSlots[a,s]*slotstime[s] - schedulelandingtime[a] <= maxallotedtime[a] - schedulelandingtime[a];
s.t. constraint21 {a in PLANE4, s in AVAILABLESLOTS}:
    AssignedPlaneSlots[a,s]*slotstime[s] - schedulelandingtime[a] <= maxallotedtime[a] - schedulelandingtime[a];
s.t. constraint22 {a in PLANE5, s in AVAILABLESLOTS}:
    AssignedPlaneSlots[a,s]*slotstime[s] - schedulelandingtime[a] <= maxallotedtime[a] - schedulelandingtime[a];

s.t. constraint23 {s in PAIR1}:
    sum {a in AIRPLANES} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint24 {s in PAIR2}:
    sum {a in AIRPLANES} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint25 {s in PAIR3}:
    sum {a in AIRPLANES} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint26 {s in PAIR4}:
    sum {a in AIRPLANES} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint27 {s in PAIR5}:
    sum {a in AIRPLANES} AssignedPlaneSlots[a,s] <= 1;
solve;
display AssignedPlaneSlots;
end;
