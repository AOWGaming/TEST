private ["_MV22_current","_MV22_reargunner","_MV22_sidegunner"];
_MV22_current = _this select 3;
_MV22_current setVariable ["gunsdeployed", 2, true];

_MV22_current animate ["ramp_top",1]; //open the top part of the ramp
_MV22_current animate ["ramp_bottom",1]; //open the bottom part of the ramp

sleep 0.5;

_MV22_reargunner = "M2StaticMG" createVehicle [0,0,0]; 
_MV22_reargunner setVariable ["Sarge",1,true]; 
_MV22_reargunner attachTo [_MV22_current, [-0.3, -5, -2]];
_MV22_reargunner setDir 180;
_MV22_reargunner setPos getPos _MV22_reargunner;

sleep 0.5;

_MV22_current animate ["door1_bottom",1];

sleep 0.5;

_MV22_sidegunner = "M2HD_mini_TriPod" createVehicle [0,0,0];
_MV22_sidegunner setVariable ["Sarge",1,true]; 
_MV22_sidegunner attachTo [_MV22_current, [0.65, 3.30, -1.5]];
_MV22_sidegunner setDir 90;
_MV22_sidegunner setPos getPos _MV22_sidegunner;

sleep 0.5;

_MV22_current setVariable ["gunsdeployed", 1, true];

waitUntil {sleep 1; !alive _MV22_current};

deleteVehicle _MV22_sidegunner;
deleteVehicle _MV22_reargunner;
