//Command Guidance system based on nuxil's Tvs script. all credit goes to nuxil who created the original Tvs script.

private ["_state","_thermalmode"];
switch (_this select 1) do
{
	// exit missile camera
	case 1:	{closeDialog 0;};
	// N, toggle through thermal modes.
	case 49:
	{
		_state = vehicle player getvariable ["FIR_AWS_Nux_tvs_thermal",0];
		_state = _state + 1;
		if (_state > 5) then {_state = 0;};
		vehicle player setvariable ["FIR_AWS_Nux_tvs_thermal", _state];
		_thermalmode = "VIS MODE:DTV";
		switch (_state) do {
			case 0 : {false setCamUseTi 0;camUseNVG false;_thermalmode = "VIS MODE:DTV";};
			case 1 : {false setCamUseTi 0;camUseNVG true; _thermalmode = "VIS MODE:NV";};				
			case 2 : {true setCamUseTi 0;camUseNVG false;_thermalmode = "VIS MODE:WHOT";};
			case 3 : {true setCamUseTi 1;camUseNVG false;_thermalmode = "VIS MODE:BHOT";};
			case 4 : {true setCamUseTi 2;camUseNVG false;_thermalmode = "VIS MODE:GHOT/DGC";};
			case 5 : {true setCamUseTi 3;camUseNVG false;_thermalmode = "VIS MODE:BHOT/DGC";};
		};
		((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8565) ctrlSetText format["%1",_thermalmode];
		((uiNamespace getVariable 'FIR_AWS_Nux_tvs_Display') displayCtrl 8565) ctrlCommit 0;			
		
	};
};
