//==============================================//
//Mission Made By:(AOW)Recon                    //
//WAI Made By:                                  //
//Developer f3cuk                               //  
//Developer Jossy                               //
//Helping hand nerdalertdk                      //
//Sever Ip:162.255.138.42:2502                  //
//WebSite:www.AOWGaming.com                     //
//==============================================//
if(isServer) then {

	private 		["_complete","_crate_type","_mission","_position","_crate","_baserunover","_baserunover1","_baserunover2","_unitGroup","_directions","_girl","_crate_c"];

	_position		= [30] call find_position;
	_mission		= [_position,"Hard","Farmer ReSupply","MainHero",true] call mission_init;
	
	diag_log 		format["WAI: [Mission:[Hero] Farmer ReSupply]: Starting... %1",_position];

	//Setup the crate
	_crate_type 	= crates_wheeled call BIS_fnc_selectRandom;
	_crate 			= createVehicle [_crate_type,[(_position select 0) + 10,(_position select 1) + 5,0], [], 0, "CAN_COLLIDE"];
	
	_crate_type 	= crates_large call BIS_fnc_selectRandom;
	_crate_c 		= createVehicle [_crate_type,[(_position select 0) + 10,(_position select 1) - 15,0], [], 0, "CAN_COLLIDE"];

	//Medical Supply Camp
	_baserunover1 	= createVehicle ["Land_Farm_Cowshed_a",[(_position select 0) +15, (_position select 1) -20,0],[], 0, "CAN_COLLIDE"];
	_baserunover2 	= createVehicle ["SHouse",[(_position select 0) +35, (_position select 1) +10,0],[], 0, "CAN_COLLIDE"];
	_baserunover 	= [_baserunover1,_baserunover2];
	
	_directions = [90,270,0,180,0,180,270,90];
	
	{ _x setDir (_directions select _forEachIndex) } forEach _baserunover;
	{ _x setVectorUp surfaceNormal position  _x; } count _baserunover;

	//Troops
	_unitGroup = [[_position select 0,_position select 1,0],4,"Extreme","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	_unitGroup = [[_position select 0,_position select 1,0],4,"Extreme","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	_unitGroup = [[_position select 0,_position select 1,0],4,"Extreme","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	[[_position select 0,_position select 1,0],4,"Hard","Random",4,"Random","Bandit","Random","Bandit",_mission] call spawn_group;
	
	_girl = [[_position select 0, _position select 1,0],2,"Extreme","Unarmed",0,"Random","CIV_EuroWoman01_EP1","Random",["Bandit",0],_mission] call spawn_group;
   //_owner = [[_position select 0,_position select 1,0],1,"Extreme","Random",4,"Random","Haris_Press_EP1_DZ","Random",["Bandit",0],_mission] call spawn_group;

   //[[(_position select 0) + 100, _position select 1, 0],[(_position select 0) + 100, _position select 1, 0],50,2,"HMMWV_Armored","Random","Bandit","Bandit",_mission] call vehicle_patrol;
	

	//Condition
	_complete = [
		[_mission,_crate,_crate_c],				// mission number and crate
		["assassinate", _unitGroup],						// ["crate"], or ["kill"], or ["assassinate", _unitGroup],
		[_baserunover], 				// cleanup objects
		"Farmers are Restocking There Goods",	// mission announcement
		"They Were All Killed! Need Help From Heros",								// mission success
		"The Farmers Lived Heros Did You Job"							// mission fail
	] call mission_winorfail;

	if(_complete) then {
		[_crate,0,0,[40,crate_items_farm],0] call dynamic_crate;      
		[_crate_c,0,0,[70,crate_items_farm_c],0] call dynamic_crate;
	};

	diag_log format["WAI: [Mission:[Hero] Farmer ReSupply]: Ended at %1",_position];

	h_missionrunning = false;
};