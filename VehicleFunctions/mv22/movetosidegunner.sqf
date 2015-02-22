private ["_MV22","_sidegun"];
if (isDedicated) exitWith {};

_MV22 = _this select 3;
if (_MV22 getVariable ["sidegundeployed",0] == 1) exitWith {
	cutText ["Sorry, Sidegun is already manned","PLAIN",0];
};
_MV22 setVariable ["sidegundeployed",1,true];

_MV22 removeAction mv22_gotosidegunner;
mv22_gotosidegunner = -1;

_MV22 animate ["door1_top",1]; //open the top part of the ramp
_MV22 animate ["door1_bottom",1]; //open the bottom part of the ramp

sleep 0.5;

_sidegun = "M2HD_mini_TriPod" createVehicle [0,0,0];
_sidegun setVariable ["Sarge",1,true]; 
_sidegun attachTo [_MV22, [0.65, 3.30, -1.5]];
_sidegun setDir 90;
_sidegun setPos getPos _sidegun;

sleep 0.5;

cutText ["","BLACK OUT",1];
fnc_usec_damageHandler = {};
player removeAllEventHandlers "handleDamage";
player addEventHandler ["handleDamage", {false}];
player allowDamage false;
sleep 1;
unassignVehicle player;
player action ["getout", vehicle player];
waitUntil {vehicle player == player};
while {vehicle player == player} do {
	player setPos (getPos _sidegun);
	player assignAsGunner _sidegun;
	[player] orderGetIn true;
	player moveInGunner _sidegun;
};
fnc_usec_damageHandler = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandler.sqf";
player addEventHandler ["handleDamage", {true}];
player removeAllEventHandlers "handleDamage";
player allowDamage true;
cutText ["","BLACK IN",1];
sleep 3;
mv22_movefromsidetocargoposition = _sidegun addAction ["Get in Backseat position","custom\mv22\movetocargo.sqf",_MV22,6,false,false,"",""];
mv22_ejecthalofromsideposition =  _sidegun addAction ["HALO Jump","custom\mv22\exithalo.sqf",_MV22,2,false,false,"",""];

waitUntil {sleep 1; count (crew _sidegun) <= 0};
deleteVehicle _sidegun;
sleep 0.5;
_MV22 animate ["door1_bottom",0];
_MV22 animate ["door1_top",0];
sleep 1;
_MV22 setVariable ["sidegundeployed",0,true];
