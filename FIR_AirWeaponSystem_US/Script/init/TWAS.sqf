/*TWAS Script by Firewill */

_array = _this select 0;
_unit = _array select 0;
_attacker = _array select 1;
_damage = _array select 2;

_unit_pilot = (driver _unit);
_attacker_pilot = (driver _attacker);
_weaponClass = currentWeapon _attacker;

_unit_name = name _unit_pilot;
_attacker_name = name _attacker_pilot;

_unitside = side _unit_pilot;

[_unitside,"HQ"] sidechat format ["TWAS CENTRAL : %1 's Aircraft is Hit by %2 's Aircraft / WEP : %3",_unit_name,_attacker_name,_weaponClass];

_unit vehiclechat format ["TWAS MSG : %1 's Aircraft is Hit by %2 's Aircraft / WEP : %3",_unit_name,_attacker_name,_weaponClass];
_unit say "FIR_TWAS_Hit";

_attacker vehiclechat format ["TWAS MSG : %1 's Aircraft is Hit by %2 's Aircraft / WEP : %3",_unit_name,_attacker_name,_weaponClass];
_attacker say "FIR_TWAS_Hit_Attacker";

