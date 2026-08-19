[] spawn
{
	while {true} do
	{
		//waitUntil {inputAction "User18" > 0};  
		if (inputAction "User18" > 0) then
		{
			_handle = [player] execVM "FIR_AirWeaponSystem_US\Script\function\msg\msg_open.sqf";		
		};
		if (inputAction "User17" > 0) then
		{
			_handle = [player] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\PDU\PDU_Open.sqf";		
		};		
    };
};