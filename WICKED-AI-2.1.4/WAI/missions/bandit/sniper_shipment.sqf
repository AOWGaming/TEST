if(isServer) then {

	private			["_complete","_crate_type","_mission","_vehicle","_position","_vehclass","_crate","_crate_c","_baserunover","_rndnum","_crate_s_a"];

	_position		= [30] call find_position;
	_mission		= [_position,"Hard","Sniper Shipment","MainBandit",true] call mission_init;

	diag_log 		format["WAI: [Mission:[Bandit] Sniper Shipment]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_wheeled call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) - 20,(_position select 1),0],[],0,"CAN_COLLIDE"];
	
	_crate_type 	= crates_large call BIS_fnc_selectRandom;
	_crate_c			= createVehicle [_crate_type,[(_position select 0) + 20,(_position select 1),0],[],0,"CAN_COLLIDE"];
	
	_crate_type 	= crates_medium call BIS_fnc_selectRandom;
	_crate_s_a 			= createVehicle [_crate_type,[(_position select 0) - 10,(_position select 1),0],[],0,"CAN_COLLIDE"];
	
	//Medical Tent
	_baserunover 	= createVehicle ["USMC_WarfareBFieldhHospital",[(_position select 0) - 40, (_position select 1),-0.2],[], 0, "CAN_COLLIDE"];
	_baserunover 	setVectorUp surfaceNormal position _baserunover;

	//Troops
	_rndnum = 4 + round (random 3);
	[[_position select 0,_position select 1,0],_rndnum,"hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],_rndnum,"hard","Random",4,"Random","Hero","Random","Hero",_mission] call spawn_group;
	
	[[_position select 0, _position select 1, 0],_rndnum,"easy","Random",4,"Random","Doctor","Random",["Hero",200],_mission] call spawn_group;
	
	[[(_position select 0),(_position select 1),0],[0,0,0],800,"UH60M_EP1_DZE",6,"Random","Random",4,"Random","Hero","Random","Hero",false,_mission] spawn heli_para;
	[[(_position select 0) + 50,(_position select 1),0],[50,50,0],800,"UH60M_EP1_DZE",6,"Random","Random",4,"Random","Hero","Random","Hero",false,_mission] spawn heli_para;
	 
	//Static Guns
	[[
		[(_position select 0) + 10, (_position select 1) + 10, 0],
		[(_position select 0) + 10, (_position select 1) - 10, 0]
	],"M2StaticMG","Medium","Hero","Hero",0,2,"Random","Random",_mission] call spawn_static;
	
	//Spawn vehicles
	_vehclass 		= "BAF_merlin_DZE";
	_vehicle		= [_vehclass,_position] call custom_publish;
	
	if(debug_mode) then {
		diag_log format["WAI: [Bandit] sniper_shipment spawned a Merlin at %1", _position];
	};
	
	//Condition
	_complete = [
		[_mission,_crate,_crate_c,_crate_s_a],	// mission number and crate
		["crate"], 			// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_vehicle], 		// cleanup objects
		"Some Hero's Seen Bandit's Stocking Up On Sniper Supplies!",		// mission announcement
		"Bandits have Got Away With The Supplies!",					// mission success
		"Hero's Have Stop Them From Getting The Supplies!"								// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,0,0,[80,crate_items_medical],0] call dynamic_crate;
		[_crate_c,0,0,[20,crate_weapons_c],[43,crate_items_c_a],[7,crate_tools],4] call dynamic_crate;
		//[_crate_s_a,0,0,[43,crate_items_c_a],0] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Bandit] Sniper Shipment]: Ended at %1",_position];
	
	b_missionrunning = false;
};