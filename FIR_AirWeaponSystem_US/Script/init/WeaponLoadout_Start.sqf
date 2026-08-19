/*Initial Weapon By Firewill*/

_f16 = _this select 0;
_armingtype = _this select 1;

_f16 removeMagazines "FIR_M61A2_511rnd_M";
_f16 removeMagazines "FIR_AIM9L_1rnd_M";
_f16 removeMagazines "FIR_AIM9L_2rnd_M";
_f16 removeMagazines "FIR_AIM120_1rnd_M";
_f16 removeMagazines "FIR_AIM120_2rnd_M";
_f16 removeMagazines "FIR_AIM120_4rnd_M";
_f16 removeMagazines "FIR_GBU31_1rnd_M";
_f16 removeMagazines "FIR_GBU31_2rnd_M";
_f16 removeMagazines "FIR_GBU31_4rnd_M";
_f16 removeMagazines "FIR_GBU12_1rnd_M";
_f16 removeMagazines "FIR_GBU12_2rnd_M";
_f16 removeMagazines "FIR_AGM88_1rnd_M";
_f16 removeMagazines "FIR_AGM88_2rnd_M";

_f16 removeMagazines "FIR_240rnd_CMFlare_Chaff_Magazine";

_f16 removeMagazines "FIR_Empty_1rnd_M";
_f16 removeMagazines "FIR_Empty_2rnd_M";
_f16 removeMagazines "FIR_Empty_4rnd_M";
_f16 removeMagazines "FIR_F16C_Fueltank_1rnd_M";
_f16 removeMagazines "FIR_F16C_Fueltank_2rnd_M";
_f16 removeMagazines "FIR_HTSPod_1rnd_M";
_f16 removeMagazines "FIR_ECMPod_1rnd_M";
_f16 removeMagazines "FIR_LantirnPod_1rnd_M";

_f16 removeweapon "FIR_M61A2";
_f16 removeweapon "FIR_CMLauncher";
_f16 removeweapon "FIR_AIM9L";
_f16 removeweapon "FIR_AIM120";
_f16 removeweapon "FIR_GBU12";
_f16 removeweapon "FIR_GBU31";
_f16 removeweapon "FIR_AGM88";


sleep 0.1;

_f16 addweapon "FIR_M61A2";
_f16 addweapon "FIR_CMLauncher";

_f16 addmagazine "FIR_M61A2_511rnd_M";
_f16 addmagazine "FIR_240rnd_CMFlare_Chaff_Magazine";

switch (_armingtype) do
{
    case "Type1Loadout":
    {
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_AIM9L_1rnd_M";
		_f16 addmagazine "fir_AIM9L_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "FIR_f16C_Fueltank_1rnd_M";
		_f16 addmagazine "FIR_f16C_Fueltank_1rnd_M";

		_f16 addweapon "FIR_M61A2";
		_f16 addweapon "FIR_CMLauncher";
		_f16 addweapon "FIR_AIM9L";
		_f16 addweapon "FIR_AIM120";
		
		_f16 animate ["ECMJAMMER",0];
		_f16 animate ["fuelswitch",1];
		
		_f16 setfuel 1;
   	};
    case "Type2Loadout":
    {
		_f16 addmagazine "FIR_ECMPod_1rnd_M";
		_f16 addmagazine "FIR_LantirnPod_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_AIM9L_1rnd_M";
		_f16 addmagazine "fir_AIM9L_1rnd_M";
		_f16 addmagazine "fir_GBU31_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_GBU31_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "FIR_f16C_Fueltank_1rnd_M";
		_f16 addmagazine "FIR_f16C_Fueltank_1rnd_M";

		_f16 addweapon "FIR_M61A2";
		_f16 addweapon "FIR_CMLauncher";
		_f16 addweapon "FIR_AIM9L";
		_f16 addweapon "FIR_AIM120";
		_f16 addweapon "FIR_GBU31";		

		_f16 animate ["ECMJAMMER",1];		
		_f16 animate ["fuelswitch",1];
		_f16 animate ["Lantirn_Switch",1];
		_f16 animate ["HTS_Switch",0];
		
		_f16 setfuel 1;
   	};
	case "Type3Loadout":
    {
		_f16 addmagazine "FIR_ECMPod_1rnd_M";
		_f16 addmagazine "FIR_HTSPod_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_AIM9L_1rnd_M";
		_f16 addmagazine "fir_AIM9L_1rnd_M";
		_f16 addmagazine "fir_AGM88_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_AGM88_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "fir_empty_1rnd_M";
		_f16 addmagazine "FIR_f16C_Fueltank_1rnd_M";
		_f16 addmagazine "FIR_f16C_Fueltank_1rnd_M";

		_f16 addweapon "FIR_M61A2";
		_f16 addweapon "FIR_CMLauncher";
		_f16 addweapon "FIR_AIM9L";
		_f16 addweapon "FIR_AIM120";
		_f16 addweapon "FIR_AGM88";				
		
		_f16 animate ["ECMJAMMER",1];
		_f16 animate ["fuelswitch",1];
		_f16 animate ["Lantirn_Switch",0];
		_f16 animate ["HTS_Switch",1];
		
		_f16 setfuel 1;
   	};
	case "Type4Loadout":
    {
		_f16 addmagazine "FIR_ECMPod_1rnd_M";
		_f16 addmagazine "FIR_LantirnPod_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_AIM120_1rnd_M";
		_f16 addmagazine "fir_AIM9L_1rnd_M";
		_f16 addmagazine "fir_AIM9L_1rnd_M";
		_f16 addmagazine "FIR_LAU88_1rnd_M";
		_f16 addmagazine "FIR_AGM65D_1rnd_M";
		_f16 addmagazine "FIR_AGM65D_1rnd_M";
		_f16 addmagazine "FIR_AGM65D_1rnd_M";
		_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		_f16 addmagazine "FIR_Hydra_7_Pod_1rnd_M";
		_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		_f16 addmagazine "FIR_mk82_Snakeye_1rnd_M";
		_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		_f16 addmagazine "FIR_Triplepylon_1rnd_M";
		
		_f16 addmagazine "FIR_Hydra_7rnd_M";
		_f16 addmagazine "FIR_Hydra_7rnd_M";
		_f16 addmagazine "FIR_Hydra_7rnd_M";

		_f16 addweapon "FIR_M61A2";
		_f16 addweapon "FIR_CMLauncher";
		_f16 addweapon "FIR_AIM9L";
		_f16 addweapon "FIR_AIM120";
		_f16 addweapon "FIR_AGM65";
		_f16 addweapon "FIR_mk82_Snakeye_Launcher";		
		_f16 addweapon "FIR_RKT_Launcher";				
		
		_f16 animate ["ECMJAMMER",1];
		_f16 animate ["fuelswitch",0];
		_f16 animate ["Lantirn_Switch",1];
		_f16 animate ["HTS_Switch",0];
		
		_f16 setfuel 0.5;
   	};
};


sleep 0.1;





