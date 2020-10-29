/*  All Entrances */
set Entrances;

/* East entrance Main */
set EastEntrance;

/* North Entrance Secondary*/
set NorthEntrance;

/* West Entrance Secondary*/
set WestEntrance;

/*  All Resources => vending machines, turnstiles, employees */
set Resources;

/* vending machines , turnstiles */
set Resources2;

/*  turnstiles */
set ResourceTurnstiles;

/*  Cost of each resource */
param ResourcesCost {j in Resources};
/*  Average time reduction of each resource */
param ResourcesTimeReduction {j in Resources};
/*  Current waiting time of each entrance */
param AverageWaitingTime {i in Entrances};

/*  Robots*/
set Robots;

/* Robots that only can be on east side R3 R5 R6*/
set RobotsOnlyEast;

/* Robots that only can be on west side R2 R4*/
set RobotsOnlyWest;

/*  Galleries */
set Galleries;

/*  Subset of galleries on the west */
set GalleriesWest;

/*  Subset of galleries on the east */
set GalleriesEast;

/* Galleries C D */
set GalleriesCD;

/* Galleries A B */
set GalleriesAB;

/*  Max energy of each robot*/
param Max_energy {r in Robots} ;

/*  Time for each robot to make a presentation */
param PresentationTime {r in Robots};

/*  Energy units each robot requires for item presented */
param EnergyTime {r in Robots};

/*  Number of items per gallery */
param GalleryItems {g in Galleries};

/*  Time required to present all items in a gallery */
param cost {r in Robots , g in Galleries} := GalleryItems[g] * PresentationTime[r];

/*  Decision  variables for the assignment resources to each entrances and assignment of robots to each gallery*/
var ResourcesAssignment {i in Entrances, j in Resources} integer, >=0;
var RobotAssignment {r in Robots , g in Galleries} integer, >=0;

/*  Objective function set to minimize the sum of the total time for the robots to present the items and the average waiting time per visitor */
minimize Time : sum{r in Robots, g in Galleries} cost[r,g] * RobotAssignment[r,g] + (sum {i in Entrances} (AverageWaitingTime[i] - sum{j in Resources} ResourcesTimeReduction[j] * ResourcesAssignment[i,j]))/3;


/*-------------------Constraints-------------------*/

/*Constraints for the assignment of the resources*/

/* The total investment for purchasing vending machines, turnstiles and hiring employees for all entrances should not be larger than 1000€ per day */
s.t. TotalInvestment1000 : sum {i in Entrances, j in Resources} (ResourcesCost[j] * ResourcesAssignment[i,j]) <=1000;

/* The main entrance should not require an expenditure greater than 10 % over the expenditure of  North secondary entrance */
s.t. MainExpenditure10North : (1.1 * sum{i in NorthEntrance, j in Resources} ResourcesAssignment[i,j] * ResourcesCost[j]) - sum{i in EastEntrance,j in Resources} ResourcesAssignment[i,j] * ResourcesCost[j] >=0;

/*  the main entrance should not require an expenditure greater than 10 % over the expenditure of  West secondary entrance */
s.t. MainExpenditure10West : (1.1 * sum{i in WestEntrance,j in Resources} ResourcesAssignment[i,j] * ResourcesCost[j]) - sum{i in EastEntrance,j in Resources} ResourcesAssignment[i,j] * ResourcesCost[j] >=0;

/* Sum of the number of vending machines and turnstiles of North entrance shall be less than the sum of the number of vending machines and turnstiles of the main entrance */
s.t. MainMoreVendingTurnstilesNorth : sum{i in EastEntrance, j in Resources2 } ResourcesAssignment[i,j] - sum{i in NorthEntrance, j in Resources2} ResourcesAssignment[i,j] >=1;

/* Sum of the number of vending machines and turnstiles of West entrance shall be less than the sum of the number of vending machines and turnstiles of the main entrance */
s.t. MainMoreVendingTurnstilesWest : sum{i in EastEntrance, j in Resources2} ResourcesAssignment[i,j] - sum{i in WestEntrance, j in Resources2} ResourcesAssignment[i,j] >=1;

/* The number of turnstiles in the north entrance shall be less than in the west entrance */
s.t. WestMoreTurnstilesNorth : sum {i in WestEntrance, j in ResourceTurnstiles} ResourcesAssignment[i,j] - sum {i in NorthEntrance, j in ResourceTurnstiles}ResourcesAssignment[i,j] >=1;

/* There shall be at least two vending machines, two turnstiles and two employees in the main entrance */
s.t. MainEntranceMinEachResource {i in EastEntrance, j in Resources}: ResourcesAssignment[i,j] >=2;

/* There shall be at least 1 vending machines, 1 turnstiles and 1 employees in the North entrance */
s.t. NorthEntranceMinEachResource {i in NorthEntrance, j in Resources}: ResourcesAssignment[i,j] >=1;

/* There shall be at least 1 vending machines, 1 turnstiles and 1 employees in the West entrance */
s.t. WestEntranceMin1Employees {i in WestEntrance, j in Resources}: ResourcesAssignment[i,j] >=1;

/* The reduction in the average waiting time is larger in the main entrance than in the North entrance */
s.t. MainMoreTimeReductionNorth : sum {i in EastEntrance, j in Resources } ResourcesAssignment[i,j] * ResourcesTimeReduction[j]- sum { i in NorthEntrance, j in Resources } ResourcesAssignment[i,j] * ResourcesTimeReduction[j] >=1;

/* The reduction in the average waiting time is larger in the main entrance than in the West entrance */
s.t. MainMoreTimeReductionWest : sum {i in EastEntrance, j in Resources } ResourcesAssignment[i,j] * ResourcesTimeReduction[j]- sum { i in WestEntrance, j in Resources } ResourcesAssignment[i,j] * ResourcesTimeReduction[j] >=1;

/*Constraints for the assignment of the robots */

/* Only one robot per gallery is allowed, every gallery should have at least one robot */
s.t. GalleryRobot {g in Galleries}: sum {r in Robots} RobotAssignment[r,g] = 1;

/* Each robot shall be assigned to at least two galleries */
s.t. Min_RobotGallery {r in Robots}: sum {g in Galleries} RobotAssignment[r,g] >= 2;

/* Each robot shall not be assigned to more than three galleries */
s.t. Max_RobotGallery {r in Robots}: sum {g in Galleries} RobotAssignment[r,g] <=  3;

/* Robots R3, R5 and R6 can not be assigned to any of the halls in the west side of the museum. */
s.t. RobotsR1R3R5OnlyEast {r in RobotsOnlyEast, g in GalleriesWest } : RobotAssignment[r,g] =0;

/* Robots R2 and R4 can not be assigned to any of the galleries in the east side. */
s.t. RobotsR2R4OnlyWest {r in RobotsOnlyWest, g in GalleriesEast } : RobotAssignment[r,g] =0;

/* Only robots assigned to either gallery A, B or both, can be assigned to the halls C, D or both.*/
s.t. CD_allowed {r in Robots}: sum {g in GalleriesCD} RobotAssignment[r,g] - sum {g in GalleriesAB} 2*RobotAssignment[r,g]<= 0;

/* Only robots that can support the amount of energy required to present all items in a gallery shall be assigned to it */
s.t. EnoughEnergy {r in Robots}: sum{g in Galleries} RobotAssignment[r,g] * EnergyTime[r] * GalleryItems[g] <= Max_energy[r];

/* It is required that presentations in the west side at least take 10 %longer than presentations in the east side.*/
s.t. WestLargerThanEast : (1.1 * sum{i in Robots , j in GalleriesEast} GalleryItems[j]*PresentationTime[i] * RobotAssignment[i,j])-(sum{r in Robots , g in GalleriesWest} GalleryItems[g]*PresentationTime[r] * RobotAssignment[r,g]) <=0;


solve;
display ResourcesAssignment;
display RobotAssignment;
end;
