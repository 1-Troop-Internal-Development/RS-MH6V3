/*
ORIGINAL BY reyhard

window handling in m1025

EDIT BY SykoCrazy

Changes tail number on MELB
*/
params["_v","_t","_tex"];

private _n = (getArray (configfile >> "cfgVehicles" >> typeOf _v >> "hiddenSelections")) find _t;

_v setObjectTextureGlobal [_n, format['rhsusf\addons\rhsusf_melb\Data\decals\SN\%1.paa',_tex] ];