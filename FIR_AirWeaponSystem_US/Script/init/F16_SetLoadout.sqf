/*custom loadout function by Firewill

how to use
[this,"hardpoint1","hardpoint2","hardpoint3","hardpoint4","hardpoint5","hardpoint5A","hardpoint6","hardpoint7","hardpoint8","hardpoint9"] call FIR_Fnc_F16_SetLoadout;

example
[this,"aim9l","","","fueltank","ecmjammer","","fueltank","","","aim9l"] call FIR_Fnc_F16_SetLoadout;

support weapon classname list
hardpoint 1,2,8,9 = aim9l / aim9x / aim120 / aim9twas / aim120twas
hardpoint 3,7 = aim9l / aim9x / aim120 /aim9twas/aim120twas / gbu10 / gbu12x1 / gbu12x2 / gbu31 / gbu32 / gbu38x1 / gbu38x2 / gbu38x3 / agm65dx1 / agm65dx3 / agm65g / agm65l / agm88 / mk82x3 / cbu103 / hydrax1 / hydrax2 / hydrax3 / zuni
hardpoint 4,6 = fueltank / gbu10 / gbu12x1 / gbu12x2 / gbu12x3 / gbu31 / gbu32 / gbu38x1 / gbu38x2 / gbu38x3 / agm65dx1 / agm65g / agm65l / mk82x3 / cbu103 / hydrax1 / hydrax2 / hydrax3 / zuni
hardpoint 5 = ecmpod / twaspod
hardpoint 5a = htspod / lantirnpod

if you want don't add weapon in hardpoint, just leave empty.
*/

_f16 = _this select 0;
_hardpoint1 = _this select 1;
_hardpoint2 = _this select 2;
_hardpoint3 = _this select 3;
_hardpoint4 = _this select 4;
_hardpoint4A = _this select 4;
_hardpoint5 = _this select 5;
_hardpoint5A = _this select 6;
_hardpoint6 = _this select 7;
_hardpoint6A = _this select 7;
_hardpoint7 = _this select 8;
_hardpoint8 = _this select 9;
_hardpoint9 = _this select 10;



/* Delete Weapon and Ammo Before */
_f16 removeMagazines "FIR_M61A2_511rnd_M";
_f16 removeMagazines "FIR_AIM9L_1rnd_M";
_f16 removeMagazines "FIR_AIM9X_1rnd_M";
_f16 removeMagazines "FIR_AIM120_1rnd_M";
_f16 removeMagazines "FIR_GBU31_1rnd_M";
_f16 removeMagazines "FIR_GBU10_1rnd_M";
_f16 removeMagazines "FIR_GBU12_1rnd_M";
_f16 removeMagazines "FIR_AGM88_1rnd_M";
_f16 removeMagazines "FIR_AGM65D_1rnd_M";
_f16 removeMagazines "FIR_AGM65G_1rnd_M";
_f16 removeMagazines "FIR_AGM65L_1rnd_M";
_f16 removeMagazines "FIR_GBU32_1rnd_M";
_f16 removeMagazines "FIR_GBU38_1rnd_M";
_f16 removeMagazines "FIR_mk82_Snakeye_1rnd_M";
_f16 removeMagazines "FIR_CBU103_1rnd_M";
_f16 removeMagazines "FIR_AIM120_TWAS_1rnd_M";
_f16 removeMagazines "FIR_AIM9L_TWAS_1rnd_M";
_f16 removeMagazines "FIR_CBU89_1rnd_M";

_f16 removeMagazines "FIR_Hydra_7rnd_M";
_f16 removeMagazines "FIR_Zuni_4rnd_M";

_f16 removeMagazines "FIR_240rnd_CMFlare_Chaff_Magazine";

_f16 removeMagazines "FIR_Empty_1rnd_M";
_f16 removeMagazines "FIR_f16C_Fueltank_1rnd_M";
_f16 removeMagazines "FIR_f16C_Fueltank_2rnd_M";
_f16 removeMagazines "FIR_HTSPod_1rnd_M";
_f16 removeMagazines "FIR_ECMPod_1rnd_M";
_f16 removeMagazines "FIR_LantirnPod_1rnd_M";
_f16 removeMagazines "FIR_Triplepylon_1rnd_M";
_f16 removeMagazines "FIR_LAU88_1rnd_M";
_f16 removeMagazines "FIR_Hydra_7_Pod_1rnd_M";
_f16 removeMagazines "FIR_Zuni_5_Pod_1rnd_M";

_f16 removeweapon "FIR_M61A2";
_f16 removeweapon "FIR_CMLauncher";
_f16 removeweapon "FIR_AIM9L";
_f16 removeweapon "FIR_AIM9X";
_f16 removeweapon "FIR_AIM120";
_f16 removeweapon "FIR_GBU10";
_f16 removeweapon "FIR_GBU12";
_f16 removeweapon "FIR_GBU31";
_f16 removeweapon "FIR_AGM88";
_f16 removeweapon "FIR_AGM65";
_f16 removeweapon "FIR_GBU32";
_f16 removeweapon "FIR_GBU38";
_f16 removeweapon "FIR_mk82_Snakeye_Launcher";
_f16 removeweapon "FIR_CBU103";
_f16 removeweapon "FIR_CBU89";
_f16 removeweapon "FIR_RKT_Launcher";



_f16 addweapon "FIR_M61A2";
_f16 addweapon "FIR_CMLauncher";

/*_f16 addmagazine "FIR_M61A2_511rnd_M";*/
_f16 addmagazine "FIR_240rnd_CMFlare_Chaff_Magazine";


	Switch (_hardpoint5) Do
	{
		case "ecmpod":
		{
			_f16 addmagazine "FIR_ECMPod_1rnd_M";
			_f16 animate ["ECMJAMMER",1];
		};
		case "twaspod":
		{			
			_f16 addmagazine "FIR_TWASPod_1rnd_M";
			_f16 animate ["ECMJAMMER",0];
			_index = _f16 addMPEventHandler ["MPHit", {Null = [_this] execVM "FIR_F16\sqs\init\TWAS.sqf";}]; 
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 animate ["ECMJAMMER",0];
		};
	};


	Switch (_hardpoint5A) Do
	{
		case "htspod":
		{
			_f16 addmagazine "FIR_HTSPod_1rnd_M";
			_f16 animate ["Lantirn_Switch",0];
			_f16 animate ["HTS_Switch",1];
		};
		case "lantirnpod":
		{
			_f16 addmagazine "FIR_LantirnPod_1rnd_M";
			_f16 animate ["Lantirn_Switch",1];
			_f16 animate ["HTS_Switch",0];
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 animate ["Lantirn_Switch",0];
			_f16 animate ["HTS_Switch",0];
		};
	};


	Switch (_hardpoint1) Do
	{
		case "aim9l":
		{
			_f16 addmagazine "FIR_AIM9L_1rnd_M";
		};
		case "aim9x":
		{
			_f16 addmagazine "FIR_AIM9X_1rnd_M";
		};
		case "aim120":
		{
			_f16 addmagazine "FIR_AIM120_1rnd_M";
		};
		case "aim9twas":
		{
			_f16 addmagazine "FIR_AIM9L_TWAS_1rnd_M";
		};
		case "aim120twas":
		{
			_f16 addmagazine "FIR_AIM120_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};


	Switch (_hardpoint9) Do
	{
		case "aim9l":
		{
			_f16 addmagazine "FIR_AIM9L_1rnd_M";
		};
		case "aim9x":
		{
			_f16 addmagazine "FIR_AIM9X_1rnd_M";
		};
		case "aim120":
		{
			_f16 addmagazine "FIR_AIM120_1rnd_M";
		};
		case "aim9twas":
		{
			_f16 addmagazine "FIR_AIM9L_TWAS_1rnd_M";
		};
		case "aim120twas":
		{
			_f16 addmagazine "FIR_AIM120_TWAS_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};


	Switch (_hardpoint2) Do
	{
		case "aim9l":
		{
			_f16 addmagazine "FIR_AIM9L_1rnd_M";
		};
		case "aim9x":
		{
			_f16 addmagazine "FIR_AIM9X_1rnd_M";
		};
		case "aim120":
		{
			_f16 addmagazine "FIR_AIM120_1rnd_M";
		};
		case "aim9twas":
		{
			_f16 addmagazine "FIR_AIM9L_TWAS_1rnd_M";
		};
		case "aim120twas":
		{
			_f16 addmagazine "FIR_AIM120_TWAS_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};


	Switch (_hardpoint8) Do
	{
		case "aim9l":
		{
			_f16 addmagazine "FIR_AIM9L_1rnd_M";
		};
		case "aim9x":
		{
			_f16 addmagazine "FIR_AIM9X_1rnd_M";
		};
		case "aim120":
		{
			_f16 addmagazine "FIR_AIM120_1rnd_M";
		};		
		case "aim9twas":
		{
			_f16 addmagazine "FIR_AIM9L_TWAS_1rnd_M";
		};
		case "aim120twas":
		{
			_f16 addmagazine "FIR_AIM120_TWAS_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};

	Switch (_hardpoint7) Do
	{
		case "aim9l":
		{
			_f16 addmagazine "FIR_AIM9L_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "aim9x":
		{
			_f16 addmagazine "FIR_AIM9X_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "aim120":
		{
			_f16 addmagazine "FIR_AIM120_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "aim9twas":
		{
			_f16 addmagazine "FIR_AIM9L_TWAS_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "aim120twas":
		{
			_f16 addmagazine "FIR_AIM120_TWAS_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "hydrax1":
		{
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "hydrax2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "hydrax3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "zuni":
		{
			_f16 addmagazine "FIR_Zuni_5_Pod_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu10":
		{
			_f16 addmagazine "FIR_GBU10_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu12x1":
		{
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu12x2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
		};
		case "gbu31":
		{
			_f16 addmagazine "FIR_GBU31_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu32":
		{
			_f16 addmagazine "FIR_GBU32_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu38x1":
		{
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu38x2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "gbu38x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "agm65dx1":
		{
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "agm65dx3":
		{
			_f16 addmagazine "FIR_LAU88_1rnd_M";
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
		};
		case "agm65g":
		{
			_f16 addmagazine "FIR_AGM65G_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "agm65l":
		{
			_f16 addmagazine "FIR_AGM65L_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "agm88":
		{
			_f16 addmagazine "FIR_AGM88_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "mk82x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		};
		case "cbu103":
		{
			_f16 addmagazine "FIR_CBU103_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "cbu89":
		{
			_f16 addmagazine "FIR_CBU89_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};


	Switch (_hardpoint3) Do
	{
		case "aim9l":
		{
			_f16 addmagazine "FIR_AIM9L_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "aim9x":
		{
			_f16 addmagazine "FIR_AIM9X_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "aim120":
		{
			_f16 addmagazine "FIR_AIM120_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "aim9twas":
		{
			_f16 addmagazine "FIR_AIM9L_TWAS_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "aim120twas":
		{
			_f16 addmagazine "FIR_AIM120_TWAS_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "hydrax1":
		{
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "hydrax2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "hydrax3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "zuni":
		{
			_f16 addmagazine "FIR_Zuni_5_Pod_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu10":
		{
			_f16 addmagazine "FIR_GBU10_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu12x1":
		{
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu12x2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
		};
		case "gbu31":
		{
			_f16 addmagazine "FIR_GBU31_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu32":
		{
			_f16 addmagazine "FIR_GBU32_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu38x1":
		{
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "gbu38x2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "gbu38x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "agm65dx1":
		{
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "agm65dx3":
		{
			_f16 addmagazine "FIR_LAU88_1rnd_M";
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
		};
		case "agm65g":
		{
			_f16 addmagazine "FIR_AGM65G_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "agm65l":
		{
			_f16 addmagazine "FIR_AGM65L_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "agm88":
		{
			_f16 addmagazine "FIR_AGM88_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "mk82x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		};
		case "cbu103":
		{
			_f16 addmagazine "FIR_CBU103_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "cbu89":
		{
			_f16 addmagazine "FIR_CBU89_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};


	Switch (_hardpoint6) Do
	{
		case "fueltank":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu10":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu12x1":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu12x2":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
		};
		case "gbu12x3":
		{
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
		};
		case "gbu31":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu32":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu38x1":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu38x2":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "gbu38x3":
		{
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "agm65dx1":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "agm65g":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "agm65l":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "mk82x3":
		{
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		};
		case "cbu103":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "cbu89":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "hydrax1":
		{
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "hydrax2":
		{
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "hydrax3":
		{
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "zuni":
		{
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};

	Switch (_hardpoint4) Do
	{
		case "fueltank":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu10":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu12x1":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu12x2":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
		};
		case "gbu12x3":
		{
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
			_f16 addmagazine "FIR_GBU12_1rnd_M";
		};
		case "gbu31":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu32":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu38x1":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "gbu38x2":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "gbu38x3":
		{
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "agm65dx1":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "agm65g":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "agm65l":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "mk82x3":
		{
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
			_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		};
		case "cbu103":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "cbu89":
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
		case "hydrax1":
		{
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		case "hydrax2":
		{
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "hydrax3":
		{
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "zuni":
		{
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
			_f16 addmagazine "FIR_empty_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};

	Switch (_hardpoint6A) Do
	{
		case "fueltank":
		{
			_f16 addmagazine "FIR_f16C_Fueltank_1rnd_M";
		};
		case "gbu10":
		{
			_f16 addmagazine "FIR_GBU10_1rnd_M";
		};
		case "gbu12x1":
		{
			_f16 addmagazine "FIR_GBU12_1rnd_M";
		};
		case "gbu12x2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "gbu12x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "gbu31":
		{
			_f16 addmagazine "FIR_GBU31_1rnd_M";
		};
		case "gbu32":
		{
			_f16 addmagazine "FIR_GBU32_1rnd_M";
		};
		case "gbu38x1":
		{
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "gbu38x2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "gbu38x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "agm65dx1":
		{
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
		};
		case "agm65g":
		{
			_f16 addmagazine "FIR_AGM65G_1rnd_M";
		};
		case "agm65l":
		{
			_f16 addmagazine "FIR_AGM65L_1rnd_M";
		};
		case "mk82x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "cbu103":
		{
			_f16 addmagazine "FIR_CBU103_1rnd_M";
		};
		case "cbu89":
		{
			_f16 addmagazine "FIR_CBU89_1rnd_M";
		};
		case "hydrax1":
		{
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "hydrax2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "hydrax3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "zuni":
		{
			_f16 addmagazine "FIR_Zuni_5_Pod_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};


	Switch (_hardpoint4A) Do
	{
		case "fueltank":
		{
			_f16 addmagazine "FIR_f16C_Fueltank_1rnd_M";
		};
		case "gbu10":
		{
			_f16 addmagazine "FIR_GBU10_1rnd_M";
		};
		case "gbu12x1":
		{
			_f16 addmagazine "FIR_GBU12_1rnd_M";
		};
		case "gbu12x2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "gbu12x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "gbu31":
		{
			_f16 addmagazine "FIR_GBU31_1rnd_M";
		};
		case "gbu32":
		{
			_f16 addmagazine "FIR_GBU32_1rnd_M";
		};
		case "gbu38x1":
		{
			_f16 addmagazine "FIR_GBU38_1rnd_M";
		};
		case "gbu38x2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "gbu38x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "agm65dx1":
		{
			_f16 addmagazine "FIR_AGM65D_1rnd_M";
		};
		case "agm65g":
		{
			_f16 addmagazine "FIR_AGM65G_1rnd_M";
		};
		case "agm65l":
		{
			_f16 addmagazine "FIR_AGM65L_1rnd_M";
		};
		case "mk82x3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "cbu103":
		{
			_f16 addmagazine "FIR_CBU103_1rnd_M";
		};
		case "cbu89":
		{
			_f16 addmagazine "FIR_CBU89_1rnd_M";
		};
		case "hydrax1":
		{
			_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		};
		case "hydrax2":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "hydrax3":
		{
			_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		};
		case "zuni":
		{
			_f16 addmagazine "FIR_Zuni_5_Pod_1rnd_M";
		};
		default
		{
			_f16 addmagazine "FIR_Empty_1rnd_M";
		};
	};

_f16_magazine = magazines _f16;

_aim9count = {_x == "FIR_AIM9L_1rnd_M"} count magazines _f16;
_aim9xcount = {_x == "FIR_AIM9X_1rnd_M"} count magazines _f16;
_aim120count = {_x == "FIR_AIM120_1rnd_M"} count magazines _f16;
_gbu10count = {_x == "FIR_GBU10_1rnd_M"} count magazines _f16;
_gbu12count = {_x == "FIR_GBU12_1rnd_M"} count magazines _f16;
_gbu31count = {_x == "FIR_GBU31_1rnd_M"} count magazines _f16;
_gbu32count = {_x == "FIR_GBU32_1rnd_M"} count magazines _f16;
_gbu38count = {_x == "FIR_GBU38_1rnd_M"} count magazines _f16;
_agm88count = {_x == "FIR_AGM88_1rnd_M"} count magazines _f16;
_mk82secount = {_x == "FIR_mk82_Snakeye_1rnd_M"} count magazines _f16;
_cbu103count = {_x == "FIR_CBU103_1rnd_M"} count magazines _f16;
_cbu89count = {_x == "FIR_CBU89_1rnd_M"} count magazines _f16;
_agm65dcount = {_x == "FIR_AGM65D_1rnd_M"} count magazines _f16;
_agm65gcount = {_x == "FIR_AGM65G_1rnd_M"} count magazines _f16;
_agm65lcount = {_x == "FIR_AGM65L_1rnd_M"} count magazines _f16;
_twascount = {_x == "FIR_TWASPod_1rnd_M"} count magazines _f16;
_hydracount = {_x == "FIR_Hydra_7_Pod_1rnd_M"} count magazines _f16;
_zunicount = {_x == "FIR_Zuni_5_Pod_1rnd_M"} count magazines _f16;

if (_aim9count >= 1) then {_f16 addweapon "FIR_AIM9L";};
if (_aim9xcount >= 1) then {_f16 addweapon "FIR_AIM9X";};
if (_aim120count >= 1) then {_f16 addweapon "FIR_AIM120";};
if (_gbu10count >= 1) then {_f16 addweapon "FIR_GBU10";};
if (_gbu12count >= 1) then {_f16 addweapon "FIR_GBU12";};
if (_gbu31count >= 1) then {_f16 addweapon "FIR_GBU31";};
if (_gbu32count >= 1) then {_f16 addweapon "FIR_GBU32";};
if (_gbu38count >= 1) then {_f16 addweapon "FIR_GBU38";};
if (_AGM88count >= 1) then {_f16 addweapon "FIR_AGM88";};
if (_mk82secount >= 1) then {_f16 addweapon "FIR_mk82_Snakeye_Launcher";};
if (_cbu103count >= 1) then {_f16 addweapon "FIR_CBU103";};
if (_cbu89count >= 1) then {_f16 addweapon "FIR_CBU89";};
if ((_agm65dcount >= 1) or (_agm65gcount >= 1) or (_agm65lcount >= 1)) then {_f16 addweapon "FIR_AGM65";};

if (_twascount >= 1) then
{
_f16 addmagazine "FIR_M61A2_TWAS_511rnd_M";
}
else
{
_f16 addmagazine "FIR_M61A2_511rnd_M";
};

if ((_hydracount >= 1) or (_zunicount >= 1)) then
{
	_f16 addweapon "FIR_RKT_Launcher";
	for "_i" from 1 to _hydracount do
	{
		_f16 addmagazine "FIR_Hydra_7rnd_M";
	};
	for "_j" from 1 to _zunicount do
	{
		_f16 addmagazine "FIR_Zuni_4rnd_M";
	};
};

_fuelcount = {_x == "FIR_f16C_Fueltank_1rnd_M"} count magazines _f16;

Switch (_fuelcount) Do
{
	case 0:
	{
		_f16 setfuel 0.5;
		_f16 animate ["fuelswitch",0];
	};
	case 1:
	{
		_f16 setfuel 0.75;
		_f16 animate ["fuelswitch",1];
	};
	case 2:
	{
		_f16 setfuel 1.0;
		_f16 animate ["fuelswitch",1];
	};
};
