private ["_vehicleActionsRemoved","_startLogged","_vehicle","_inVehicle"];
waitUntil {!isNil "dayz_animalCheck"};
_startLogged = false;
while{true} do {
	sleep 3;
	if (vehicle player != player && vehicle player isKindOf "Air") then {
	if (_inVehicle && {_vehicle isKindOf "MV22","MV22_DZ"}) then {
   if (isEngineOn _vehicle) then {[_vehicle,0] call mv22_pack;};
   if (mv22_fold < 0) then {
	 themv22 = _vehicle;
	 if !(isEngineOn themv22) then {
	   mv22_fold = themv22 addAction ["Fold","custom\VehicleFunctions\mv22\fold.sqf","",5,false,true];
	   mv22_unfold = themv22 addAction ["UnFold","custom\VehicleFunctions\mv22\unfold.sqf","",5,false,true];
	 };
   };
   if (isEngineOn themv22) then {
	 themv22 removeAction mv22_fold;
	 mv22_fold = -1;
	 themv22 removeAction mv22_unfold;
	 mv22_unfold = -1;
   };
} else {
	if (!isNil "themv22") then {
	   themv22 removeAction mv22_fold;
	   mv22_fold = -1;
	   themv22 removeAction mv22_unfold;
	   mv22_unfold = -1;
   };
};
				//_xtype = [themv22,0] execvm "\ca\air2\mv22\scripts\pack.sqf"
			};
			if (mv22_gotosidegunner <0) then {
				mv22_gotosidegunner = themv22 addAction ["Get in Sidegunner Position","custom\VehicleFunctions\mv22\movetosidegunner.sqf",themv22,6,false,false,"","(player in (crew themv22)) && (player != driver themv22) && (alive themv22) && (themv22 getVariable [""sidegundeployed"", 0] == 0)"];
			};
			if (mv22_gotoreargunner <0) then {
				mv22_gotoreargunner = themv22 addAction ["Get in Reargunner Position","custom\VehicleFunctions\mv22\movetoreargunner.sqf",themv22,6,false,false,"","(player in (crew themv22)) && (player != driver themv22) && (alive themv22) && (themv22 getVariable [""reargundeployed"", 0] == 0)"];
			};
			if (mv22_openramp <0) then {
				mv22_openramp = themv22 addAction ["Open Rear Gunner Ramp","custom\VehicleFunctions\mv22\openramp.sqf",themv22,5,false,false,"","(player==driver themv22) && (themv22 animationphase ""ramp_bottom"" == 0)"];
			};
			if (mv22_closeramp <0) then {
				mv22_closeramp = themv22 addAction ["Close Rear Gunner Ramp","custom\VehicleFunctions\mv22\closeramp.sqf",themv22,5,false,false,"","(player==driver themv22) && (themv22 animationphase ""ramp_bottom"" == 1)"];
			};
			if (mv22_opendoor <0) then {
				mv22_opendoor = themv22 addAction ["Open Gunner Door","custom\VehicleFunctions\mv22\opendoor.sqf",themv22,5,false,false,"","(player==driver themv22) && (themv22 animationphase ""door1_bottom"" == 0)"];
			};
			if (mv22_closedoor <0) then {
				mv22_closedoor = themv22 addAction ["Close Gunner Door","custom\VehicleFunctions\mv22\closedoor.sqf",themv22,5,false,false,"","(player==driver themv22) && (themv22 animationphase ""door1_bottom"" == 1)"];
			};
		};
		
	} else {
		if (_vehicleActionsRemoved == 0) then {
			themv22 removeAction mv22_fold;
			themv22 removeAction mv22_unfold;
			themv22 removeAction mv22_openramp;
			themv22 removeAction mv22_closeramp;
			themv22 removeAction mv22_opendoor;
			themv22 removeAction mv22_closedoor;
			themv22 removeAction mv22_gotosidegunner;
			themv22 removeAction mv22_gotoreargunner;
			mv22_fold = -1;
			mv22_unfold = -1;
			mv22_openramp = -1;
			mv22_closeramp = -1;
			mv22_opendoor = -1;
			mv22_closedoor = -1;
			mv22_gotosidegunner = -1;
			mv22_gotoreargunner = -1;
			thec130 removeAction c130_openramp;
			thec130 removeAction c130_closeramp;
			thec130 removeAction c130_openrdoor;
			thec130 removeAction c130_closerdoor;
			c130_openramp = -1;
			c130_closeramp = -1;
			c130_openrdoor = -1;
			c130_closerdoor = -1;
			theuh1y removeAction uh1y_fold;
			theuh1y removeAction uh1y_unfold;
			uh1y_fold = -1;
			uh1y_unfold = -1;
			thecessna removeAction cessna_smokeon;
			thecessna removeAction cessna_smokeoff;
			cessna_smokeon = -1;
			cessna_smokeoff = -1;
			_vehicleActionsRemoved = 1;
		};
	};
	if (!(_startLogged)) then {
		_startLogged = true;
		diag_log "#################### Airvehicle functions loading complete!";
	};
};