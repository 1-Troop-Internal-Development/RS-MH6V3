//MQ-81U CBARS AUTO refueling script by Firewill
//only for MQ-81U CBARS for now.

private _tanker = _this select 0;
private _list = attachedObjects _tanker;
private _CBARS = _list select 0;
private _client_list = "";
private _client_CBARS = "";
private _tanker_pilot = driver _tanker;

private _plane = "";
private _plane_pilot = "";
private _exit = false;
private _dual_attach = false;
private _configPath = "";
private _skip = false;
private _probe_ok = false;
private _ARS = false;
private _boost = false;
private _exitType = "anim";

private _offset_probe = [];
private _offset_aircraft = [];
private _offset_original = [];

//check MQ-81U Connected first.
private _UAV = getConnectedUAV player;

//if not UAV
if (_UAV isEqualTo objNull) then
{
	_plane = vehicle player;
	_plane_pilot = driver _plane;
}
else
{
// if UAV and MQ-81U only
	if (_UAV iskindof "FIR_MQ81U")then
	{
		_plane = _UAV;	
		_plane_pilot = player;		
	}
	else
	{
		_exit = true;
	};

};

if (_exit) exitWith {vehicle player sidechat "this isn't the UAV you're looking for."};

_planetype = typeof _plane;
//some specific aircraft check.

if (_planetype iskindof "FIR_FA181E") then
{
		_client_list = attachedObjects _plane;
		_client_CBARS = _client_list select 0;		
		_offset_probe = [-0.8,-27.8,-4.5];
		_offset_aircraft = [-0.8,-32,-3.1];
		_offset_original = [0,4,-1.5];
		_dual_attach = true;
		_exitType = "var";		
}
else
{
	if (_planetype iskindof "VTOL_01_base_F") then
	{
		_offset_aircraft = [-1.1,-38.1,2.5];
		_exitType = "var";		
		_plane setVariable ["FIR_ARS_Probe_Extend","yes",true];
	}
	else
	{
		if (_planetype iskindof "FIR_MQ81U") then
		{
			_client_list = attachedObjects _plane;
			_client_CBARS = _client_list select 0;		
			_offset_probe = [-2.2,-27.8,-4.5];
			_offset_aircraft = [-2.2,-27.8,-4];
			_offset_original = [0,0.25,-0.45];		
			_dual_attach = true;	
			_exitType = "var";		
			_plane setVariable ["FIR_ARS_Probe_Extend","yes",true];			
		}
		else
		{
			_skip = true;		
		};
	};
};

if (_skip) then
{
	if (isClass(configFile >> "CfgVehicles" >> typeOf _plane >> "ARSData")) then 
	{
		_configPath = configFile >> "CfgVehicles" >> typeOf _plane >> "ARSData";
		_offset_aircraft = getArray (_configPath >> "ARS_CBARS_Offset");
		_exitType = "var";				
		_ARS = true;
	}
	else
	{
		_offset_aircraft = _plane selectionposition "refuel_probe";
		_ARS = false;			
		_exitType = "anim";				
	};
};

_drogueused = _tanker getVariable ["FIR_ARS_Drogue_Used", "no"];
_probeextend = _plane getVariable ["FIR_ARS_Probe_Extend", "no"];

_rnd = floor(random 9999);
_plane_pilot sideChat format ["REQUEST THE REFUEL, CBARS ACCESS CODE : ROMEO-FOXTROT %1.",_rnd];

sleep 2;
//if aircraft don't have offset. mean not supported aircraft.
if (_offset_aircraft isEqualTo [0,0,0]) exitWith { _tanker_pilot sideChat "SYSTEM : ACCESS DENIED. CHECK YOUR AIRCRAFT COMPATIBILITY."; };
sleep 0.5;
if ((_exitType =="anim" and _plane animationPhase "fuel_probe" < 0.5) or (_exitType =="var" and _probeextend == "no") or (_drogueused == "yes")) exitWith { _tanker_pilot sideChat "SYSTEM : ACCESS DENIED. CLIENT OR CBARS IS NOT READY FOR ACCESS."; };
sleep 0.5;
//drogue system is now available to use, drogue extend and client aircraft now ready for refueling such as extend probe.
if (_drogueused == "no" and _CBARS animationPhase "probe_rolled_hide" == 0 and (_plane animationPhase "fuel_probe" > 0.5 or _probeextend == "yes" or _probe_ok)) then 
{ 
	_CBARS animateSource ["probe_hide",1,true];
	
	_tanker setVariable ["FIR_ARS_Drogue_Used","yes",true];
};
sleep 0.5;

_tanker_pilot sideChat format ["SYSTEM : ACCESS CODE - ROMEO-FOXTROT %1 CONFIRMED. INITIATE THE REFUELING SYSTEM",_rnd];
sleep 0.5;


while {(alive _tanker) and (alive _plane) and (_plane animationPhase "fuel_probe" > 0.5 or _probeextend == "yes" or _probe_ok)} do 
{
	_CBARS animateSource ["probe_hide",1,true];	
	_offset_aircraft_pos = _plane ModelToWorld _offset_aircraft;		
	_refuel_drogue = _CBARS selectionposition "point_connect";	
	_refuel_drogue_pos = _CBARS ModelToWorld _refuel_drogue;	
	_distance = _offset_aircraft_pos distance _refuel_drogue_pos;
	hintsilent format ["DISTANCE TO CBARS : %1 m",_distance];
	
	if( _distance <= 45)  exitWith { 
		_tanker_pilot sideChat "SYSTEM : COMMENCE REFUELING";
	};
	sleep 0.5;
};

//dual attach mean some aircraft like MQ-81U and F/A-181E is using own attached object for refueling so can be attach to CBARS both.
if (_dual_attach) then
{
		_client_CBARS attachTo [_tanker,_offset_probe];
		_plane attachTo [_tanker, _offset_aircraft];		
}
else
{
	if (_ARS) then
	{
		_plane attachTo [_tanker, _offset_aircraft];		
	}
	else
	{
		if (_planetype iskindof "VTOL_01_base_F") then
		{
			_plane attachTo [_tanker, _offset_aircraft];				
		}
		else
		{
			_plane attachTo [_CBARS, [(0 - ((_plane selectionPosition "refuel_probe") select 0)), (0 - ((_plane selectionPosition "refuel_probe") select 1)), (0 - ((_plane selectionPosition "refuel_probe") select 2))], "point_connect"];	
			_boost = true;		
		};
	};
};

while {(alive _tanker) and (alive _plane) and (_plane animationphase "fuel_probe" > 0.5 or _probeextend == "yes" or _probe_ok)} do 
{
	_Fuel_client = fuel _plane;
	_Fuel_tanker = fuel _tanker;
	If (_Fuel_tanker < 0.2) exitWith 	{_tanker_pilot sideChat "SYSTEM ERROR : NOT ENOUGH FUEL IN CBARS. ABORTING";};	
	_plane setfuel (_Fuel_client + 0.02);
	If (_Fuel_client >= 0.96) exitWith {};
	sleep 1;
};

_tanker_pilot sideChat "SYSTEM : REFUELING OPERATION COMPLETED.";

_Fuel_tanker = fuel _tanker;
_tanker setfuel (_Fuel_tanker - 0.1);

hintsilent format ["remaining fuel in CBARS : %1",fuel _tanker];

sleep 1;

if (_dual_attach) then
{
	detach _client_CBARS;
	detach _plane;
	_client_CBARS attachto [_plane,_offset_original];
}
else
{
	detach _plane;
};

// boost speed for default aircraft because speed will 0 after refueled.
if (_boost) then
{
	_vel = velocity _plane;
	_dir = direction _plane;
	_plane setVelocity [
		(_vel select 0) + (sin _dir * 100), 
		(_vel select 1) + (cos _dir * 100), 
		(_vel select 2)
	];
};

_CBARS animateSource ["probe_hide",0,true];
_tanker setVariable ["FIR_ARS_Drogue_Used", "no",true];

exit;