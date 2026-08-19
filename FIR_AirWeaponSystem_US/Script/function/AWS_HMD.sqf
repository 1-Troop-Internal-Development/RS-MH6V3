_plane = _this select 0;
_usermfd = _this select 1;
_pilot = driver _plane;
_planetype = typeof _plane;

_hmd = _plane getVariable "AWS_HMD";

_helmet = headgear _pilot;

_is_hmd = getNumber (configFile >> "CfgWeapons" >> _helmet >> "fir_hmd_helmet");

if ((_is_hmd == 1) or headgear _pilot == "H_PilotHelmetFighter_B" or headgear _pilot == "H_PilotHelmetFighter_O" or headgear _pilot == "H_PilotHelmetFighter_I") then
{
	if (_hmd == "no") then
	{
		_plane setUserMFDvalue [_usermfd,1];		
		_plane setVariable ["AWS_HMD","yes",true];
	}
	else
	{
		_plane setUserMFDvalue [_usermfd,0];		
		_plane setVariable ["AWS_HMD","no",true];
	};
}
else
{
_plane vehicleChat "my helmet is not HMD helmet..";
};
