private ["_MV22_current","_MV22_sidegunner","_MV22_reargunner","_gunnerSide","_gunnerRear"];
_MV22_current = _this select 3;
_MV22_sidegunner = nearestObject [_MV22_current, "M2HD_mini_TriPod"];
_MV22_reargunner = nearestObject [_MV22_current, "M2StaticMG"];
_gunnerSide = gunner _MV22_sidegunner;
_gunnerRear = gunner _MV22_reargunner;

if (!isNull _gunnerSide || !isNull _gunnerRear) exitWith {
	cutText["You cannot pack the Weapons when they are manned","PLAIN",0];
};

deleteVehicle _MV22_sidegunner;

sleep 0.1;

_MV22_current animate ["door1_bottom",0];

sleep 0.1;

deleteVehicle _MV22_reargunner;

sleep 0.1;

_MV22_current animate ["ramp_top",0];
_MV22_current animate ["ramp_bottom",0];

_MV22_current setVariable ["gunsdeployed", 0, true];
