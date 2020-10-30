/*SETS
----------------------------------------------------------------------------------*/
set AIRPLANES;
set PLANE1;
set PLANE2;
set PLANE3;
set PLANE4;
set PLANE5;

set RUNAWAYS;
set RUNAWAY1;
set RUNAWAY2;
set RUNAWAY3;
set RUNAWAY4;

set TIMESLOTS;
set TIMESLOT1;
set TIMESLOT2;
set TIMESLOT3;
set TIMESLOT4;
set TIMESLOT5;
set TIMESLOT6;

/*PARAMS
----------------------------------------------------------------------------------*/
param initialslotime {t in TIMESLOTS};
param schedulelandingtime {a in AIRPLANES};
param maxallotedtime {a in AIRPLANES};
param costs {a in AIRPLANES};
param slotsplanes {t in TIMESLOT, a in AIRPLANES};
param p {r in RUNAWAYS, a in AIRPLANES, t in TIMESLOT};

/*DECISION VARIABLES
----------------------------------------------------------------------------------*/
var time{a in AIRPLANES, t in TIMESLOT} := schedulelandingtime[a]- initialslotime[t];


/*OPTIMIZATION FUNCTION
----------------------------------------------------------------------------------*/
maximize Profits:
    sum {a in AIRPLANES, s in SLOTS} pricing[s]*TypeofTicketsperAirplane[a,s];

/*DECISION VARIABLES
----------------------------------------------------------------------------------*/
s.t. constraint1 {a in AIRPLANES}:
    sum {s in SLOTS} TypeofTicketsperAirplane[a,s]  <= totalAirplaneSeats[a];
s.t. constarint2 {a in AIRPLANES}:
    sum {s in SLOTS} baggage[s]*TypeofTicketsperAirplane[a,s] <= capacity[a];
s.t. constraint3 {a in AIRPLANES, s in TYPE2}:
    TypeofTicketsperAirplane[a,s] >= 20;
s.t. constraint4 {a in AIRPLANES, s in TYPE3}:
    TypeofTicketsperAirplane[a,s] >= 10;
s.t. constraint5:
    sum {a in AIRPLANES, s in TYPE1} TypeofTicketsperAirplane[a,s] >= 0.6*(sum {a in AIRPLANES, s in SLOTS} TypeofTicketsperAirplane[a,s]);
solve;
display TypeofTicketsperAirplane;
end;
