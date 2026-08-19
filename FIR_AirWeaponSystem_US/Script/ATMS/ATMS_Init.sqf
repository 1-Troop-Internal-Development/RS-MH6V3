/*

*/
private _plane = param [0,objNull];
private _magazine_old = param [1, "FIR_M61A2_511rnd_M"];
private _magazine_new = param [2, "FIR_M61A2_TWAS_511rnd_M"];

private _pylonlist = GetPylonMagazines _plane;
private _pylon_count = count _pylonlist;
private _flag = 0;

for "_y" from 0 to _pylon_count-1 do
{
	private _mag = _pylonlist select _y;
	private _acmi = getNumber (configFile >> "CfgMagazines" >> _mag >> "AWS_ACMI");

	if (_acmi == 1) then
	{
		_flag = 1;
	};
}; 		

if (_flag == 1) then
{

	_plane removemagazines _magazine_old;
	_plane addmagazine _magazine_new;
};