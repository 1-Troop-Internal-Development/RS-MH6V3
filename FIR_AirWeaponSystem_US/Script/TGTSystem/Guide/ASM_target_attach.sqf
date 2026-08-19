private _missile = _this select 0;
private _ammoname = _this select 1;
private _side = _this select 2;
private _gunner = _this select 3;
private _plane = _this select 4;
private _crew = "";

private _model = getText (Configfile >> "CfgAmmo" >> _ammoname >> "FIR_AWS_ASM_model_type");

private _missile_pos = getposASL _missile;
private _missile_dir = getDir _missile;

private _decoy = createVehicle [_model,_missile_pos, [], 0, "FLY"];
_decoy setdir _missile_dir;

_decoy attachTo [_missile, [0,0,0]];

switch (_side) do
{
    case west:
    {
		_crew = "B_UAV_AI";
    };
    case east:
    {
		_crew = "O_UAV_AI";
    };
    case resistance:
    {
		_crew = "I_UAV_AI";
    };		
};

_grp = createGroup [_side,true];
_ap = _grp createUnit [ _crew, _missile_pos, [], 0, "FORM"];
_ap moveInDriver _decoy;

_decoy engineOn true;
_decoy setVehicleTiPars [1,1,1];

_missie_alive_check = [_missile,_decoy,_gunner,_plane] execVM "\FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\ASM_missile_check.sqf";
_ecmhandle = _decoy addEventHandler ["incomingMissile", {[_this] execVM "FIR_AirWeaponSystem_US\Script\TGTSystem\Guide\ASM_missile_ecm.sqf"}];


