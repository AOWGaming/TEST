private ["_MV22","_reargun"];
if (isDedicated) exitWith {};

_MV22 = _this select 3;
if (_MV22 getVariable ["reargundeployed",0] == 1) exitWith {
	cutText ["Sorry, Reargun is already manned","PLAIN",0];
};
_MV22 setVariable ["reargundeployed",1,true];

_MV22 removeAction mv22_gotoreargunner;
mv22_gotoreargunner = -1;

_MV22 animate ["ramp_top",1]; //open the top part of the ramp
_MV22 animate ["ramp_bottom",1]; //open the bottom part of the ramp

sleep 0.5;

_reargun = "M2StaticMG" createVehicle [0,0,0]; 
_reargun setVariable ["Sarge",1,true]; 
_reargun attachTo [_MV22, [-0.3, -5, -2]];
_reargun setDir 180;
_reargun setPos getPos _reargun;

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
	player setPos (getPos _reargun);
	player assignAsGunner _reargun;
	[player] orderGetIn true;
	player moveInGunner _reargun;
};
fnc_usec_damageHandler = compile preprocessFileLineNumbers "\z\addons\dayz_code\compile\fn_damageHandler.sqf";
player addEventHandler ["handleDamage", {true}];
player removeAllEventHandlers "handleDamage";
player allowDamage true;
cutText ["","BLACK IN",1];
sleep 3;
mv22_movefromreartocargoposition = _reargun addAction ["Get in Backseat position","custom\mv22\movetocargo.sqf",_MV22,6,false,false,"",""];
mv22_ejecthalofromrearposition =  _reargun addAction ["HALO Jump","custom\mv22\exithalo.sqf",_MV22,2,false,false,"",""];

waitUntil {sleep 1; count (crew _reargun) <= 0};
deleteVehicle _reargun;
sleep 0.5;
_MV22 animate ["ramp_bottom",0];
_MV22 animate ["ramp_top",0];
sleep 1;
_MV22 setVariable ["reargundeployed",0,true];
