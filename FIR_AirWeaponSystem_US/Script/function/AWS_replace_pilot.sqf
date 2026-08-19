

private _f16 = _this select 0;
private _value = _this select 1;

private _f16type = typeof _f16;
private _pilot = driver _f16;

if (!local _f16) exitwith{};
if (!isClass(configFile >> "CfgPatches" >> "FIR_PilotCrewPack_US")) exitwith{};

private _configPath = configFile >> "CfgVehicles" >> _f16type >> "AWS_SPSKIN";
private _aws_sp_helmet = getText (_configPath >> "aws_sp_helmet");
private _aws_sp_uniform_type = getText (_configPath >> "aws_sp_uniform_type");
private _aws_sp_uniform_texture = getText (_configPath >> "aws_sp_uniform_texture");
private _aws_sp_uniform = getText (_configPath >> "aws_sp_uniform");
private _aws_sp_visor = getText (_configPath >> "aws_sp_visor");

private _replacepilotPath = configFile >> "CfgAWS_ReplacePilot" >> _value;
private _aws_rp_helmet = getText (_replacepilotPath >> "helmet");
private _aws_rp_visor = getText (_replacepilotPath >> "visor");

if (_value == "no") exitWith {};

removeAllWeapons _pilot;
removeAllItems _pilot;
removeAllAssignedItems _pilot;
removeUniform _pilot;
removeVest _pilot;
removeBackpack _pilot;
removeHeadgear _pilot;
removeGoggles _pilot;

if (_value isEqualTo "SP") then
{
	if (_aws_sp_helmet != "") then
	{
		_pilot addHeadgear _aws_sp_helmet;
	};
	if (_aws_sp_visor != "") then
	{
		_pilot addgoggles _aws_sp_visor;
	};	
}
else
{
	if (_aws_rp_helmet != "") then
	{
		_pilot addHeadgear _aws_rp_helmet;
	};
	if (_aws_rp_visor != "") then
	{
		_pilot addgoggles _aws_rp_visor;
	};	
};

if (_aws_sp_uniform_type == "model") then
{
	_pilot adduniform _aws_sp_uniform;					
}
else
{
    _pilot adduniform "FIR_Fighter_Pilot_Nomex3";		
    _pilot setObjectTextureGlobal [0,_aws_sp_uniform_texture];
};

_pilot addvest "fir_pilot_vest";
_pilot addweapon "hgun_P07_F";

_pilot linkItem "ItemMap";
_pilot linkItem "ItemCompass";
_pilot linkItem "ItemWatch";
_pilot linkItem "ItemRadio";

_pilot addItemToUniform "FirstAidKit";
for "_i" from 1 to 4 do {_pilot addItemToVest "16Rnd_9x21_Mag";};
_pilot addItemToVest "SmokeShellGreen";
_pilot addItemToVest "SmokeShellBlue";
_pilot addItemToVest "SmokeShellOrange";
for "_i" from 1 to 2 do {_pilot addItemToVest "Chemlight_blue";};
