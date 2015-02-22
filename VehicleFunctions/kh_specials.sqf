diag_log "#################### KH_SPECIALS STARTED";
if (isDedicated || isServer) exitWith {};
waitUntil {!isNil "dayz_animalCheck"};
//Reset Osprey Variables and actions
themv22 = objNull;
mv22_openramp = -1;
mv22_closeramp = -1;
mv22_opendoor = -1;
mv22_closedoor = -1;
mv22_gotosidegunner = -1;
mv22_gotoreargunner = -1;

//Starting Air Vehicles action check
_nil = [] execVM "custom\VehicleFunctions\airvehiclefunctions.sqf";
	diag_log "#################### Airvehicle functions loading...";

