
private _plane = _this select 0;
private _value = _this select 1;
private _seater = _this select 2;

private _pilot = driver _plane;
private _wso = commander _plane;
private _planetype = typeof _plane;


if (not isClass(configFile >> "CfgVehicles" >> _planetype >> "AWS_SPSKIN")) exitWith {};

private _configPath = configFile >> "CfgVehicles" >> _planetype >> "AWS_SPSKIN";
private _aws_sp_helmet = getText (_configPath >> "aws_sp_helmet");
private _aws_sp_uniform_type = getText (_configPath >> "aws_sp_uniform_type");
private _aws_sp_uniform_texture = getText (_configPath >> "aws_sp_uniform_texture");
private _aws_sp_uniform = getText (_configPath >> "aws_sp_uniform");
private _aws_sp_visor = getText (_configPath >> "aws_sp_visor");

if (_value) then
{
	removeAllWeapons _pilot;
	removeAllItems _pilot;
	removeAllAssignedItems _pilot;
	removeUniform _pilot;
	removeVest _pilot;
	removeBackpack _pilot;
	removeHeadgear _pilot;
	removeGoggles _pilot;
	
	if (_aws_sp_helmet != "") then
	{
		_pilot addHeadgear _aws_sp_helmet;
	};
	if (_aws_sp_visor != "") then
	{
		_pilot addgoggles _aws_sp_visor;
	};	

	if (_aws_sp_uniform_type == "model") then
	{
		_pilot forceAddUniform _aws_sp_uniform;					
	}
	else
	{
		_pilot forceAddUniform "FIR_Fighter_Pilot_Nomex3";		
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
		
	if (_seater == "dual") then
	{
		removeAllWeapons _wso;
		removeAllItems _wso;
		removeAllAssignedItems _wso;
		removeUniform _wso;
		removeVest _wso;
		removeBackpack _wso;
		removeHeadgear _wso;
		removeGoggles _wso;


		if (_aws_sp_helmet != "") then
		{
			_wso addHeadgear _aws_sp_helmet;
		};
		if (_aws_sp_visor != "") then
		{
			_wso addgoggles _aws_sp_visor;
		};			

		if (_aws_sp_uniform_type == "model") then
		{
			_wso forceAddUniform _aws_sp_uniform;					
		}
		else
		{
			_wso forceAddUniform "FIR_Fighter_Pilot_Nomex3";		
			_wso setObjectTextureGlobal [0,_aws_sp_uniform_texture];
		};

		_wso addvest "fir_pilot_vest";
		_wso addweapon "hgun_P07_F";

		_wso linkItem "ItemMap";
		_wso linkItem "ItemCompass";
		_wso linkItem "ItemWatch";
		_wso linkItem "ItemRadio";

		_wso addItemToUniform "FirstAidKit";
		for "_i" from 1 to 4 do {_wso addItemToVest "16Rnd_9x21_Mag";};
		_wso addItemToVest "SmokeShellGreen";
		_wso addItemToVest "SmokeShellBlue";
		_wso addItemToVest "SmokeShellOrange";
		for "_i" from 1 to 2 do {_wso addItemToVest "Chemlight_blue";};
	};
}
else
{

};

