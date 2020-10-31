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
param costs {a in AIRPLANES};

/*DECISION VARIABLES
----------------------------------------------------------------------------------*/
var AssignedPlaneSlots {a in AIRPLANES, s in AVAILABLESLOTS}, binary;

/*OPTIMIZATION FUNCTION
----------------------------------------------------------------------------------*/
minimize DelayCosts:
    sum {a in AIRPLANES, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*((slotstime[s] - schedulelandingtime[a])*costs[a]);

/*DECISION VARIABLES
----------------------------------------------------------------------------------*/
s.t. constraint1:
    sum {s in AVAILABLESLOTS, a in AIRPLANES} AssignedPlaneSlots[a,s] = 5;

s.t. constraint2:
    sum {a in PLANE1, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint3:
    sum {a in PLANE2, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint4:
    sum {a in PLANE3, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint5:
    sum {a in PLANE4, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint6:
    sum {a in PLANE5, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s] <= 1;

s.t. constarint7:
    sum {a in AIRPLANES, s in AVAILABLESLOT1} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint8:
    sum {a in AIRPLANES, s in AVAILABLESLOT2} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint9:
    sum {a in AIRPLANES, s in AVAILABLESLOT3} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint10:
    sum {a in AIRPLANES, s in AVAILABLESLOT4} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint11:
    sum {a in AIRPLANES, s in AVAILABLESLOT5} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint12:
    sum {a in AIRPLANES, s in AVAILABLESLOT6} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint13:
    sum {a in AIRPLANES, s in AVAILABLESLOT7} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint14:
    sum {a in AIRPLANES, s in AVAILABLESLOT8} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint15:
    sum {a in AIRPLANES, s in AVAILABLESLOT9} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint16:
    sum {a in AIRPLANES, s in AVAILABLESLOT10} AssignedPlaneSlots[a,s] <= 1;
s.t. constarint17:
    sum {a in AIRPLANES, s in AVAILABLESLOT11} AssignedPlaneSlots[a,s] <= 1;

s.t. constraint18:
    sum {a in PLANE1, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) <= 65;
s.t. constraint19:
    sum {a in PLANE2, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) <= 35;
s.t. constraint20:
    sum {a in PLANE3, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) <= 20;
s.t. constraint21:
    sum {a in PLANE4, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) <= 20;
s.t. constraint22:
    sum {a in PLANE5, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) <= 20;

s.t. constraint23:
    sum {a in PLANE1, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) >= 5;
s.t. constraint24:
    sum {a in PLANE2, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) >= 5;
s.t. constraint25:
    sum {a in PLANE3, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) >= 5;
s.t. constraint26:
    sum {a in PLANE4, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) >= 5;
s.t. constraint27:
    sum {a in PLANE5, s in AVAILABLESLOTS} AssignedPlaneSlots[a,s]*(slotstime[s] - schedulelandingtime[a]) >= 5;

s.t. constraint28:
    sum {a in AIRPLANES, s in PAIR1} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint29:
    sum {a in AIRPLANES, s in PAIR2} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint30:
    sum {a in AIRPLANES, s in PAIR3} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint31:
    sum {a in AIRPLANES, s in PAIR4} AssignedPlaneSlots[a,s] <= 1;
s.t. constraint32:
    sum {a in AIRPLANES, s in PAIR5} AssignedPlaneSlots[a,s] <= 1;
solve;
display AssignedPlaneSlots;
end;
