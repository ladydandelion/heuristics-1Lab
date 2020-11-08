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
/*capacity of each plane*/
param slotstime {v in AVAILABLESLOTS};
/*Time in minutes of each available slot*/
param schedulelandingtime {a in AIRPLANES};
/*Cost for each delayed minute in each airplane*/
param costs {a in AIRPLANES};
/*maximum landing time of the first plane*/
param maxLandingTime1 {a in PLANE1};
/*maximum landing time of the second plane*/
param maxLandingTime2 {a in PLANE2};
/*maximum landing time of the third plane*/
param maxLandingTime3 {a in PLANE3};
/*maximum landing time of the fourth plane*/
param maxLandingTime4 {a in PLANE4};
/*maximum landing time of the fifth plane*/
param maxLandingTime5 {a in PLANE5};
/*Occupied slot identifier*/
param occupiedSlot;
/*Required total number of occupied slots*/
param totalOccupiedSlot;
/*minimum time that passes until planes can land*/
param possibleRealLanding;
/*Minimum number of Leisure Plus tickets*/
param minLeisurePlus;
/*Minimum number of Business Plus tickets*/
param minBusinessPlus;
/*Minimum percentage of total Standard tickets*/
param totalStandardTickets;

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

/*Constraint to check that the capacity of each airplane is not exceeded*/
s.t. Constraint2 {a in AIRPLANES}:
    sum {s in FAIR} baggage[s]*TypeofTicketsperAirplane[a,s] <= capacity[a];

/*Constraint to check that the number of Leisure Plus tickets is at the very least 20*/
s.t. constraint3 {a in AIRPLANES, s in TYPE2}:
    TypeofTicketsperAirplane[a,s] >= minLeisurePlus;

/*Constraint to check that the number of Business Plus tickets is at the very least 10*/
s.t. constraint4 {a in AIRPLANES, s in TYPE3}:
    TypeofTicketsperAirplane[a,s] >= minBusinessPlus;

/*Constraint to check that the number of Standard tickets is at least 60% of the total amount*/
s.t. constraint5:
    sum {a in AIRPLANES, s in TYPE1} TypeofTicketsperAirplane[a,s] >= totalStandardTickets*(sum {a in AIRPLANES, s in FAIR} TypeofTicketsperAirplane[a,s]);

/*Constraint to check that the number of slots used by the planes does not exceed 5*/
s.t. constraint6:
    sum {v in AVAILABLESLOTS, a in AIRPLANES} AssignedPlaneSlots[a,v] = totalOccupiedSlot;

/*Constraint to check that the number of slots used by the Av1 is 1*/
s.t. constraint7:
    sum {a in PLANE1, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of slots used by the Av2 is 1*/
s.t. constraint8:
    sum {a in PLANE2, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of slots used by the Av3 is 1*/
s.t. constraint9:
    sum {a in PLANE3, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of slots used by the Av4 is 1*/
s.t. constraint10:
    sum {a in PLANE4, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of slots used by the Av5 is 1*/
s.t. constraint11:
    sum {a in PLANE5, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the first available slot is 1*/
s.t. constraint12:
    sum {a in AIRPLANES, v in AVAILABLESLOT1} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the second available slot is 1*/
s.t. constraint13:
    sum {a in AIRPLANES, v in AVAILABLESLOT2} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the third available slot is 1*/
s.t. constraint14:
    sum {a in AIRPLANES, v in AVAILABLESLOT3} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the fourth available slot is 1*/
s.t. constraint15:
    sum {a in AIRPLANES, v in AVAILABLESLOT4} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the fifth available slot is 1*/
s.t. constraint16:
    sum {a in AIRPLANES, v in AVAILABLESLOT5} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the sixth available slot is 1*/
s.t. constraint17:
    sum {a in AIRPLANES, v in AVAILABLESLOT6} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the seventh available slot is 1*/
s.t. constraint18:
    sum {a in AIRPLANES, v in AVAILABLESLOT7} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the eighth available slot is 1*/
s.t. constraint19:
    sum {a in AIRPLANES, v in AVAILABLESLOT8} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the ninth available slot is 1*/
s.t. constraint20:
    sum {a in AIRPLANES, v in AVAILABLESLOT9} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the tenth available slot is 1*/
s.t. constraint21:
    sum {a in AIRPLANES, v in AVAILABLESLOT10} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes using the eleventh available slot is 1*/
s.t. constraint22:
    sum {a in AIRPLANES, v in AVAILABLESLOT11} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the amount of time Av1 spends on the air after arrival does not exceeded 65 minutes*/
s.t. constraint23{a in PLANE1}:
    sum {v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= maxLandingTime1[a]-schedulelandingtime[a];

/*Constraint to check that the amount of time Av2 spends on the air after arrival does not exceeded 35 minutes*/
s.t. constraint24{a in PLANE2}:
    sum {v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= maxLandingTime2[a]-schedulelandingtime[a];

/*Constraint to check that the amount of time Av3 spends on the air after arrival does not exceeded 20 minutes*/
s.t. constraint25{a in PLANE3}:
    sum {v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= maxLandingTime3[a]-schedulelandingtime[a];

/*Constraint to check that the amount of time Av4 spends on the air after arrival does not exceeded 20 minutes*/
s.t. constraint26{a in PLANE4}:
    sum {v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= maxLandingTime4[a]-schedulelandingtime[a];

/*Constraint to check that the amount of time Av5 spends on the air after arrival does not exceeded 20 minutes*/
s.t. constraint27{a in PLANE5}:
    sum {v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) <= maxLandingTime5[a]-schedulelandingtime[a];

/*Constraint to check that the amount of time Av1 spends on the air after arrival exceeds 5 minutes*/
s.t. constraint28:
    sum {a in PLANE1, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= possibleRealLanding;

/*Constraint to check that the amount of time Av2 spends on the air after arrival exceeds 5 minutes*/
s.t. constraint29:
    sum {a in PLANE2, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= possibleRealLanding;

/*Constraint to check that the amount of time Av3 spends on the air after arrival exceeds 5 minutes*/
s.t. constraint30:
    sum {a in PLANE3, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= possibleRealLanding;

/*Constraint to check that the amount of time Av4 spends on the air after arrival exceeds 5 minutes*/
s.t. constraint31:
    sum {a in PLANE4, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= possibleRealLanding;

/*Constraint to check that the amount of time Av5 spends on the air after arrival exceeds 5 minutes*/
s.t. constraint32:
    sum {a in PLANE5, v in AVAILABLESLOTS} AssignedPlaneSlots[a,v]*(slotstime[v] - schedulelandingtime[a]) >= possibleRealLanding;

/*Constraint to check that the number of planes in the first pair of adjacent slots is 1*/
s.t. constraint33:
    sum {a in AIRPLANES, v in PAIR1} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes in the second pair of adjacent slots is 1*/
s.t. constraint34:
    sum {a in AIRPLANES, v in PAIR2} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes in the third pair of adjacent slots is 1*/
s.t. constraint35:
    sum {a in AIRPLANES, v in PAIR3} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes in the fourth pair of adjacent slots is 1*/
s.t. constraint36:
    sum {a in AIRPLANES, v in PAIR4} AssignedPlaneSlots[a,v] <= occupiedSlot;

/*Constraint to check that the number of planes in the fifth pair of adjacent slots is 1*/
s.t. constraint37:
    sum {a in AIRPLANES, v in PAIR5} AssignedPlaneSlots[a,v] <= occupiedSlot;
solve;
display TypeofTicketsperAirplane;
display AssignedPlaneSlots;
end;
