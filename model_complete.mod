/*SETS
----------------------------------------------------------------------------------*/
/*All Airplanes*/
set AIRPLANES;
/*Airplane Av1*/
set PLANE1;
/*Airplane Av2*/
set PLANE2;
/*Airplane Av3*/
set PLANE3;
/*Airplane Av4*/
set PLANE4;
/*Airplane Av5*/
set PLANE5;

/*All Faires*/
set FAIR;
/*Standard fair*/
set TYPE1;
/*Leisure Plus fair*/
set TYPE2;
/*Business Plus fair*/
set TYPE3;

/*All Available Slots*/
set AVAILABLESLOTS;
/*First Available Slot*/
set AVAILABLESLOT1;
/*Second Available Slot*/
set AVAILABLESLOT2;
/*Third Available Slot*/
set AVAILABLESLOT3;
/*Fourth Available Slot*/
set AVAILABLESLOT4;
/*Fifth Available Slot*/
set AVAILABLESLOT5;
/*Sixth Available Slot*/
set AVAILABLESLOT6;
/*Seventh Available Slot*/
set AVAILABLESLOT7;
/*Eighth Available Slot*/
set AVAILABLESLOT8;
/*Ninth Available Slot*/
set AVAILABLESLOT9;
/*Tenth Available Slot*/
set AVAILABLESLOT10;
/*Eleventh Available Slot*/
set AVAILABLESLOT11;

/*Adjacent slots As1 and As2*/
set PAIR1;
/*Adjacent slots As3 and As4*/
set PAIR2;
/*Adjacent slots As5 and As6*/
set PAIR3;
/*Adjacent slots As6 and As7*/
set PAIR4;
/*Adjacent slots As10 and As11*/
set PAIR5;

/*PARAMS
----------------------------------------------------------------------------------*/
/*Allowed baggage you can carry with each fair type*/
param baggage {s in FAIR};
/*Price stablished for each fair*/
param pricing {s in FAIR};
/*Seats stablished for each plane*/
param totalAirplaneSeats {a in AIRPLANES};
/*Capacity of each plane*/
param capacity {a in AIRPLANES};
capacity of each plane
param slotstime {v in AVAILABLESLOTS};
/*Time in minutes of each available slot*/
param schedulelandingtime {a in AIRPLANES};
/*Cost for each delayed minute in each airplane*/
param costs {a in AIRPLANES};

/*DECISION VARIABLES
----------------------------------------------------------------------------------*/
/*Decision  variables for the assignment of tickets and time slots for each plane*/
var TypeofTicketsperAirplane {a in AIRPLANES, s in FAIR} integer, >= 0;
var AssignedPlaneSlots {a in AIRPLANES, v in AVAILABLESLOTS}, binary;

/*OPTIMIZATION FUNCTION
----------------------------------------------------------------------------------*/
/*Objective function set to maximize the total cost of the company by substracting the total cost of not landing on time to the total benefits obtained with the tickets sells*/
maximize Profits:
    sum {a in AIRPLANES, s in FAIR} (pricing[s]*TypeofTicketsperAirplane[a,s]) - sum {a in AIRPLANES, v in AVAILABLESLOTS} (AssignedPlaneSlots[a,v]*((slotstime[v] - schedulelandingtime[a])*costs[a]));

/*CONSTRAINTS
----------------------------------------------------------------------------------*/
/*Constraint to check that sold tickets should not exceed the airplanes number of seats*/
s.t. constraint1 {a in AIRPLANES}:
    sum {s in FAIR} TypeofTicketsperAirplane[a,s]  <= totalAirplaneSeats[a];

/*Constarint to check that the capacity of each airplane is not exceeded*/
s.t. constarint2 {a in AIRPLANES}:
    sum {s in FAIR} baggage[s]*TypeofTicketsperAirplane[a,s] <= capacity[a];

s.t. constraint3 {a in AIRPLANES, s in TYPE2}:
    TypeofTicketsperAirplane[a,s] >= 20;

s.t. constraint4 {a in AIRPLANES, s in TYPE3}:
    TypeofTicketsperAirplane[a,s] >= 10;

s.t. constraint5:
    sum {a in AIRPLANES, s in TYPE1} TypeofTicketsperAirplane[a,s] >= 0.6*(sum {a in AIRPLANES, s in FAIR} TypeofTicketsperAirplane[a,s]);

s.t. constraint6:
    sum {v in AVAILABLESLOTS, a in AIRPLANES} AssignedPlaneSlots[a,v] = 5;

s.t. constraint7:
    sum {a in PLANE1, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= 1;
s.t. constraint8:
    sum {a in PLANE2, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= 1;
s.t. constraint9:
    sum {a in PLANE3, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= 1;
s.t. constraint10:
    sum {a in PLANE4, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= 1;
s.t. constraint11:
    sum {a in PLANE5, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= 1;

s.t. constarint12:
    sum {a in AIRPLANES, v in AVAILABLESLOT1} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint13:
    sum {a in AIRPLANES, v in AVAILABLESLOT2} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint14:
    sum {a in AIRPLANES, v in AVAILABLESLOT3} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint15:
    sum {a in AIRPLANES, v in AVAILABLESLOT4} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint16:
    sum {a in AIRPLANES, v in AVAILABLESLOT5} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint17:
    sum {a in AIRPLANES, v in AVAILABLESLOT6} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint18:
    sum {a in AIRPLANES, v in AVAILABLESLOT7} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint19:
    sum {a in AIRPLANES, v in AVAILABLESLOT8} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint20:
    sum {a in AIRPLANES, v in AVAILABLESLOT9} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint21:
    sum {a in AIRPLANES, v in AVAILABLESLOT10} AssignedPlaneSlots[a,v] <= 1;
s.t. constarint22:
    sum {a in AIRPLANES, v in AVAILABLESLOT11} AssignedPlaneSlots[a,v] <= 1;

s.t. constraint23:
    sum {a in PLANE1, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= 65;
s.t. constraint24:
    sum {a in PLANE2, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= 35;
s.t. constraint25:
    sum {a in PLANE3, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= 20;
s.t. constraint26:
    sum {a in PLANE4, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= 20;
s.t. constraint27:
    sum {a in PLANE5, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= 20;

s.t. constraint28:
    sum {a in PLANE1, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= 5;
s.t. constraint29:
    sum {a in PLANE2, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= 5;
s.t. constraint30:
    sum {a in PLANE3, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= 5;
s.t. constraint31:
    sum {a in PLANE4, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= 5;
s.t. constraint32:
    sum {a in PLANE5, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= 5;

s.t. constraint33:
    sum {a in AIRPLANES, v in PAIR1} AssignedPlaneSlots[a,v] <= 1;
s.t. constraint34:
    sum {a in AIRPLANES, v in PAIR2} AssignedPlaneSlots[a,v] <= 1;
s.t. constraint35:
    sum {a in AIRPLANES, v in PAIR3} AssignedPlaneSlots[a,v] <= 1;
s.t. constraint36:
    sum {a in AIRPLANES, v in PAIR4} AssignedPlaneSlots[a,v] <= 1;
s.t. constraint37:
    sum {a in AIRPLANES, v in PAIR5} AssignedPlaneSlots[a,v] <= 1;
solve;
display TypeofTicketsperAirplane;
display AssignedPlaneSlots;
end;
