private ["_mv22_lastgun","_MV22"];
if (isDedicated) exitWith {};

_MV22 = _this select 3;

cutText ["","BLACK OUT",1];
fnc_usec_damageHandler = {};
player removeAllEventHandlers "handleDamage";
player addEventHandler ["handleDamage", {false}];
player allowDamage false;
sleep 1;
unassignVehicle player;
player action ["getout", vehicle player];
waitUntil {vehicle player == player};
while {vehicle player != _MV22} do {
	player setPosATL [((getPosATL _MV22) select 0) + 0.65,((getPosATL _MV22) select 1) + 3.80,((getPosATL _MV22) select 0) -1.5];
	player assignAsCargo _MV22;
	[player] orderGetIn true;
	player moveInCargo _MV22;
};
waitUntil {vehicle player == _MV22};
player action [ "eject", (vehicle player)];
waitUntil {vehicle player == player};
fnc_usec_damageHandler = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandler.sqf";
player addEventHandler ["handleDamage", {true}];
player removeAllEventHandlers "handleDamage";
player allowDamage true;
cutText ["","BLACK IN",1];
player spawn BIS_fnc_halo;
player setvelocity [0,0,0];
player setDir 0;
