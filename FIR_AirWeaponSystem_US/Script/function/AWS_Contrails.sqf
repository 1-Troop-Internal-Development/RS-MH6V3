private ["_f16","_FX_smoke_source","_alt"];

_f16= _this select 0;
{if (_x iskindof "#particlesource") then {deleteVehicle _x}} forEach (_f16 nearObjects 10);

waitUntil {getpos _f16 select 2 >= 1500};
_alt = 1;
_FX_smoke_source = "#particlesource" createVehicle (getpos _f16);
_FX_smoke_source setParticleClass "FIR_ContrailEffect";
_FX_smoke_source attachto [_f16,[0,0,0],"contrail_axis"];
	
while {alive _f16} do
{
	if (getpos _f16 select 2 < 1500 and _alt == 1) then 
	{
		deleteVehicle _FX_smoke_source;
		_alt = 0;
	}
	else
	{
		if (getpos _f16 select 2 >= 1500 and _alt == 0) then
		{
			_alt = 1;
			_FX_smoke_source = "#particlesource" createVehicle (getpos _f16);
			_FX_smoke_source setParticleClass "FIR_ContrailEffect";
			_FX_smoke_source attachto [_f16,[0,0,0],"contrail_axis"];	
		};
	};

	
};

deleteVehicle _FX_smoke_source;

Exit;
