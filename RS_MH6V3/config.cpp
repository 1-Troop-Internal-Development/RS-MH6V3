class CfgPatches
{
	class RS_MH6V3
	{
		units[] = {"RHS_MELB_AH6M"};
		weapons[] =
		{
			"RS_MH6V3_weap_FFARLauncher_HEAT",
			"RS_MH6V3_weap_FFARLauncher_M274"
		};
		requiredVersion = 1.96;
		requiredAddons[] =
		{
			"cba_main",
			"rhsusf_main",
			"A3_Data_F",
			"A3_Weapons_F",
			"rhsusf_c_melb",
			"rhsusf_c_airweapons",
			"rhsusf_c_heavyweapons"
		};
		magazines[] =
		{
			"RS_MH6V3_mag_Hydra_HEAT_7",
			"RS_MH6V3_mag_Hydra_HEAT_19",
			"RS_MH6V3_mag_Hydra_M274_7",
			"RS_MH6V3_mag_Hydra_M274_19",
			"RS_MH6V3_mag_m134_pylon_3000"
		};
		ammo[] =
		{
			"RS_MH6V3_ammo_Hydra_HEAT",
			"RS_MH6V3_ammo_Hydra_M274",
			"RS_MH6V3_ammo_Hydra_M274_SmokeCloud"
		};
	};
};

class CfgFunctions
{
	class RS_MH6V3
	{
		class ace
		{
			file = "\DEVGRU\RS_MH6V3\functions\ace";
			class initAceActions
			{
				postInit = 1;
			};
		};
		class camera
		{
			file = "\DEVGRU\RS_MH6V3\functions\camera";
			class handleMinigunFired {};
			class initMinigunShake
			{
				postInit = 1;
			};
			class initResetCameraEvents
			{
				postInit = 1;
			};
			class resetCameras {};
			class flirHandler {};
		};
		class fastrope
		{
			file = "\DEVGRU\RS_MH6V3\functions\fastrope";
			class canDeployRopes {};
			class canFastRope {};
			class canPrepareFRIES {};
			class canShowDeployRopes {};
			class canShowFastRope {};
			class deployRopes {};
			class drawFastRopePrompts {};
			class fastRope {};
			class getFastRopePoints {};
			class initFastRope
			{
				postInit = 1;
			};
			class isACEFastRopingAvailable {};
			class isFastRopeConfigured {};
			class isHatchetFrameworkAvailable {};
			class onRopesCut {};
			class prepareFRIES {};
		};
		class acre
		{
			file = "\DEVGRU\RS_MH6V3\functions\acre";
			class isACREAvailable {};
			class getACRERadioInfo {};
			class getACRERadioLists {};
			class initACRERadioStatus
			{
				postInit = 1;
			};
			class initACRERadioVolume
			{
				postInit = 1;
			};
			class adjustACRERadioVolume {};
			class applyACRERadioTune {};
			class cycleACRERadioSelection {};
			class openACRERadioProgrammer {};
			class populateACRERadioProgrammer {};
			class publishACRERadioSnapshot {};
			class receiveACRERadioSnapshot {};
			class tuneACRERadio {};
			class tuneACRERadioFromOther {};
			class updateACRERadioStatus {};
		};
		class livery
		{
			file = "\DEVGRU\RS_MH6V3\functions\livery";
			class applyLivery {};
			class applySelectedLivery {};
			class getAvailableLiveries {};
			class openLiveryMenu {};
			class populateLiveryMenu {};
		};
		class input
		{
			file = "\DEVGRU\RS_MH6V3\functions\input";
			class initKeybinds
			{
				postInit = 1;
			};
		};
		class settings
		{
			file = "\DEVGRU\RS_MH6V3\functions\settings";
			class initSettings
			{
				postInit = 1;
			};
		};
		class ui
		{
			file = "\DEVGRU\RS_MH6V3\functions\ui";
			class showTrueAFMHitters
			{
				postInit = 1;
			};
		};
		class izlid
		{
			file = "\DEVGRU\RS_MH6V3\functions\izlid";
			class canUseIZLID {};
			class findIZLIDLaserSource {};
			class handleIZLIDPowerState {};
			class holdIZLID {};
			class renderIZLID {};
			class setIZLIDMode {};
			class setIZLIDState {};
			class trackIZLIDVehicle {};
			class togglePilotIZLID {};
			class toggleIZLIDMode {};
			class toggleIZLID {};
			class updateIZLIDIlluminators {};
			class updatePilotIZLIDDirection {};
			class updateIZLIDTriggerCone {};
		};
		class itn
		{
			file = "\DEVGRU\RS_MH6V3\functions\izlid\itn";
			class cleanupIlluminator {};
			class updateIlluminator {};
		};
		class pylons
		{
			file = "\DEVGRU\RS_MH6V3\functions\pylons";
			class syncPylonOwner {};
		};
		class weapons
		{
			file = "\DEVGRU\RS_MH6V3\functions\weapons";
			class applyQuickFirePylonMenu {};
			class getHydraPylonData {};
			class handleM274HydraImpact {};
			class openQuickFirePylonMenu {};
			class playM274ImpactEffect {};
			class populateQuickFirePylonMenu {};
			class cycleCrosshairTexture {};
			class quickLaunchHydra {};
			class setCrosshairVisible {};
			class showExternalWeaponControl {};
			class toggleQuickFireArm {};
			class updateQuickFirePylonMenu {};
		};
		class laircm
		{
			file = "\DEVGRU\RS_MH6V3\functions\laircm";
			class handleIncomingMissile {};
			class initLAIRCM
			{
				postInit = 1;
			};
			class initLAIRCMVehicle {};
			class applyLAIRCMMode {};
			class renderLAIRCMDebug {};
			class laircmDeflect {};
			class laircmVisual {};
		};
	};
};

class CfgUserActions
{
	class RS_MH6V3_toggleIZLID
	{
		displayName = "Toggle IZLID";
		tooltip = "Toggle the AH-6M IZLID marking laser.";
		onActivate = "[] call RS_MH6V3_fnc_toggleIZLID";
		onDeactivate = "";
		onAnalog = "";
		analogChangeThreshold = 0.01;
		modifierBlocking = 1;
	};
	class RS_MH6V3_holdIZLID
	{
		displayName = "Hold IZLID";
		tooltip = "Keep the AH-6M IZLID on while this key is held.";
		onActivate = "[true] call RS_MH6V3_fnc_holdIZLID";
		onDeactivate = "[false] call RS_MH6V3_fnc_holdIZLID";
		onAnalog = "";
		analogChangeThreshold = 0.01;
		modifierBlocking = 1;
	};
	class RS_MH6V3_toggleIZLIDMode
	{
		displayName = "Cycle IZLID Mode";
		tooltip = "Cycle between IZLID output and wide, narrow, or dynamic illuminator cone modes.";
		onActivate = "[] call RS_MH6V3_fnc_toggleIZLIDMode";
		onDeactivate = "";
		onAnalog = "";
		analogChangeThreshold = 0.01;
		modifierBlocking = 1;
	};
	class RS_MH6V3_quickLaunchHydra
	{
		displayName = "Quick Launch Hydra";
		tooltip = "Fire one AH-6M Hydra without selecting rockets.";
		onActivate = "[] call RS_MH6V3_fnc_quickLaunchHydra";
		onDeactivate = "";
		onAnalog = "";
		analogChangeThreshold = 0.01;
		modifierBlocking = 1;
	};
	class RS_MH6V3_configureQuickFirePylons
	{
		displayName = "Hydra Rocket Ripple Configuration";
		tooltip = "Open the AH-6M Hydra rocket ripple configuration.";
		onActivate = "[] call RS_MH6V3_fnc_openQuickFirePylonMenu";
		onDeactivate = "";
		onAnalog = "";
		analogChangeThreshold = 0.01;
		modifierBlocking = 1;
	};
	class RS_MH6V3_togglePilotIZLID
	{
		displayName = "Toggle Handheld IZLID";
		tooltip = "Toggle the handheld IZLID directed by the active pilot's view.";
		onActivate = "[] call RS_MH6V3_fnc_togglePilotIZLID";
		onDeactivate = "";
		onAnalog = "";
		analogChangeThreshold = 0.01;
		modifierBlocking = 1;
	};
	class RS_MH6V3_toggleQuickFireArm
	{
		displayName = "Toggle Hydra Ripple Master Arm";
		tooltip = "Arm or safe the AH-6M Hydra rocket ripple key.";
		onActivate = "[] call RS_MH6V3_fnc_toggleQuickFireArm";
		onDeactivate = "";
		onAnalog = "";
		analogChangeThreshold = 0.01;
		modifierBlocking = 1;
	};
};

class UserActionGroups
{
	class RS_MH6V3
	{
		name = "[RS] MH-6V3";
		group[] =
		{
			"RS_MH6V3_toggleIZLID",
			"RS_MH6V3_holdIZLID",
			"RS_MH6V3_toggleIZLIDMode",
			"RS_MH6V3_togglePilotIZLID",
			"RS_MH6V3_quickLaunchHydra",
			"RS_MH6V3_configureQuickFirePylons",
			"RS_MH6V3_toggleQuickFireArm"
		};
	};
};

#include "ui.hpp"

class RscInGameUI
{
	class Rsc_MELB_Turret_UnitInfo;
	class RS_MH6V3_MELB_Turret_UnitInfo: Rsc_MELB_Turret_UnitInfo
	{
		onLoad = "['onLoad',_this,'RscUnitInfo','IGUI'] call (uinamespace getvariable 'BIS_fnc_initDisplay'); _this spawn RS_MH6V3_fnc_flirHandler";
	};
};

class CfgSounds
{
	class RS_MH6V3_FuelDrain
	{
		name = "RS_MH6V3_FuelDrain";
		sound[] = {"\DEVGRU\RS_MH6V3\sounds\FuelDrain.ogg", 2, 1, 35};
		titles[] = {};
	};
	class RS_MH6V3_ACRETune
	{
		name = "RS_MH6V3_ACRETune";
		sound[] = {"\DEVGRU\RS_MH6V3\sounds\ACRETune.ogg", 1.5, 1};
		titles[] = {};
	};
};
class SensorTemplatePassiveRadar;
class SensorTemplateAntiRadiation;
class SensorTemplateActiveRadar;
class SensorTemplateIR;
class SensorTemplateVisual;
class SensorTemplateMan;
class SensorTemplateLaser;
class SensorTemplateNV;
class SensorTemplateDataLink;
class DefaultVehicleSystemsDisplayManagerLeft
{
	class components;
};
class DefaultVehicleSystemsDisplayManagerRight
{
	class components;
};
class VehicleSystemsTemplateLeftPilot: DefaultVehicleSystemsDisplayManagerLeft
{
	class components;
};
class VehicleSystemsTemplateRightPilot: DefaultVehicleSystemsDisplayManagerRight
{
	class components;
};
class RHS_Effects_Helicopter_Hull_Destruction;
class cfgAmmo
{
	class B_127x99_SLAP;
	class rhs_ammo_Hydra_M151;
	class SmokeShell;
	class rhs_ammo_127x99_SLAP: B_127x99_SLAP
	{
		hit = 15;
		indirectHit = 5;
		indirectHitRange = 1;
		caliber = 2.80992;
		class CamShakeFire
		{
			power = 1;
			duration = 0.2;
			frequency = 20;
			distance = 8;
		};
		class CamShakePlayerFire
		{
			power = 1;
			duration = 0.1;
			frequency = 20;
			distance = 1;
		};
	};
	class RS_MH6V3_ammo_Hydra_HEAT: rhs_ammo_Hydra_M151
	{
		hit = 375;
		indirectHit = 32;
		indirectHitRange = 3;
		caliber = 18;
		explosive = 0.65;
		warheadName = "HEAT";
		typicalSpeed = 740;
	};
	class RS_MH6V3_ammo_Hydra_M274_SmokeCloud: SmokeShell
	{
		model = "\A3\Weapons_f\empty.p3d";
		timeToLive = 45;
		aiAmmoUsageFlags = 4;
		smokeColor[] = {1, 1, 1, 1};
		effectsSmoke = "SmokeShellWhiteEffect";
	};
	class RS_MH6V3_ammo_Hydra_M274: rhs_ammo_Hydra_M151
	{
		hit = 4;
		indirectHit = 4;
		indirectHitRange = 2.5;
		caliber = 1;
		explosive = 0.35;
		warheadName = "HE";
		typicalSpeed = 740;
		explosionEffects = "";
		CraterEffects = "";
		CraterWaterEffects = "";
		explosionEffectsRadius = 0;
		explosionSoundEffect = "";
		visibleFire = 0.05;
		audibleFire = 0.05;
		visibleFireTime = 0;
		class CamShakeExplode
		{
			power = 0.5;
			duration = 0.12;
			frequency = 20;
			distance = 20;
		};
	};
};
class cfgMagazines
{
	class 5000Rnd_762x51_Belt;
	class rhs_mag_M151_7;
	class rhs_mag_M151_19;
	class rhs_mag_M257_7;
	class rhs_mag_m134_pylon_3000;
	class RHS_FakeMagazine_MELB: 5000Rnd_762x51_Belt
	{
		count = 0;
		displaynameshort = "-";
		displayName = "-";
		descriptionShort = "-";
		tracersEvery = 0;
		weight = 0;
	};
	class RS_MH6V3_mag_Hydra_HEAT_7: rhs_mag_M151_7
	{
		displayName = "M247 HEAT Hydra (M260)";
		displayNameShort = "M247 HEAT";
		descriptionShort = "7-round M260 pod with RS MH-6V3 HEAT Hydra rockets. Reduced fragmentation radius with high direct-hit anti-armor damage.";
		ammo = "RS_MH6V3_ammo_Hydra_HEAT";
		pylonWeapon = "RS_MH6V3_weap_FFARLauncher_HEAT";
		hardpoints[] = {"RHS_HP_MELB","RHS_HP_MELB_L","RHS_HP_MELB_R"};
	};
	class RS_MH6V3_mag_Hydra_HEAT_19: rhs_mag_M151_19
	{
		displayName = "M247 HEAT Hydra (M261)";
		displayNameShort = "M247 HEAT";
		descriptionShort = "19-round M261 pod with RS MH-6V3 HEAT Hydra rockets. Reduced fragmentation radius with high direct-hit anti-armor damage.";
		ammo = "RS_MH6V3_ammo_Hydra_HEAT";
		pylonWeapon = "RS_MH6V3_weap_FFARLauncher_HEAT";
		hardpoints[] = {"RHS_HP_MELB","RHS_HP_MELB_L","RHS_HP_MELB_R"};
	};
	class RS_MH6V3_mag_Hydra_M274_7: rhs_mag_M257_7
	{
		displayName = "M274 Smoke Hydra (M260)";
		displayNameShort = "M274 Smoke";
		descriptionShort = "7-round M260 pod with RS MH-6V3 M274 smoke-screen Hydra rockets. Light fragmentation impact followed by smoke deployment.";
		count = 7;
		ammo = "RS_MH6V3_ammo_Hydra_M274";
		pylonWeapon = "RS_MH6V3_weap_FFARLauncher_M274";
		hardpoints[] = {"RHS_HP_MELB","RHS_HP_MELB_L","RHS_HP_MELB_R"};
	};
	class RS_MH6V3_mag_Hydra_M274_19: rhs_mag_M257_7
	{
		displayName = "M274 Smoke Hydra (M261)";
		displayNameShort = "M274 Smoke";
		descriptionShort = "19-round M261 pod with RS MH-6V3 M274 smoke-screen Hydra rockets. Light fragmentation impact followed by smoke deployment.";
		count = 19;
		ammo = "RS_MH6V3_ammo_Hydra_M274";
		pylonWeapon = "RS_MH6V3_weap_FFARLauncher_M274";
		hardpoints[] = {"RHS_HP_MELB","RHS_HP_MELB_L","RHS_HP_MELB_R"};
	};
	class RS_MH6V3_mag_m134_pylon_3000: rhs_mag_m134_pylon_3000
	{
		displayName = "M134D-H (RS)";
		displayNameShort = "RS M134";
		pylonWeapon = "RS_MH6V3_weap_m134_pylon";
		hardpoints[] = {"RHS_HP_MELB_M134","RHS_HP_MELB"};
	};
};
class cfgWeapons
{
	class MGun;
	class RocketPods;
	class Laserdesignator_mounted;
	class RHS_weap_m134_pylon: MGun
	{
		class LowROF;
		class HighROF;
		class close;
		class short;
		class medium;
		class far;
	};
	class RS_MH6V3_weap_m134_pylon: RHS_weap_m134_pylon
	{
		displayName = "M134D-H (RS)";
		magazines[] = {"RS_MH6V3_mag_m134_pylon_3000"};
		modes[] = {"LowROF","HighROF","close","short","medium","far"};
		class LowROF: LowROF
		{
			displayName = "LO";
			reloadTime = 0.03;
			multiplier = 1;
		};
		class HighROF: HighROF
		{
			displayName = "HI";
			reloadTime = 0.02;
			multiplier = 2;
		};
		class close: close {};
		class short: short {};
		class medium: medium {};
		class far: far {};
	};
	class rhs_weap_FFARLauncher: RocketPods
	{
		magazines[] =
		{
			"rhs_mag_M151_19",
			"rhs_mag_M151_19_green",
			"rhs_mag_M151_7",
			"rhs_mag_M151_7_green",
			"rhs_mag_M151_7_USAF_LAU131",
			"rhs_mag_M151_21_USAF_LAU131_3",
			"rhs_mag_FFAR_7_USAF",
			"rhs_mag_FFAR_21_USAF_LAU68_3",
			"rhs_mag_FFAR_19_USAF",
			"rhs_mag_FFAR_57_USAF_LAU61_3"
		};
		displayName = "Hydra (M151 HE)";
		magazineReloadTime = 0;
		modes[] = {"Far_AI","Single","Two"};
		cursor = "rocket";
		cursorAim = "EmptyCursor";
		cursorSize = 0;
		class Far_AI: RocketPods
		{
			displayName = "Hydra";
			burst = 1;
			reloadTime = 0.08;
			autoFire = 0;
			showToPlayer = 0;
			soundBurst = 0;
			dispersion = 0.011;
			minRange = 150;
			minRangeProbab = 0.6;
			midRange = 600;
			midRangeProbab = 0.9;
			maxRange = 2500;
			maxRangeProbab = 0.12;
		};
		class Burst: RocketPods
		{
			displayName = "ALL";
			burst = 1;
			salvo = 2;
			reloadTime = 0.08;
			soundContinuous = 0;
			autoFire = 1;
			aiDispersionCoefX = 1.5;
			aiDispersionCoefY = 1;
			dispersion = 0.012;
			textureType = "fullAuto";
			minRange = 1;
			minRangeProbab = 0.001;
			midRange = 2;
			midRangeProbab = 0.001;
			maxRange = 3;
			maxRangeProbab = 0.001;
			soundBurst = 0;
		};
		class Single: Burst
		{
			displayName = "1";
			autoFire = 0;
			salvo = 1;
			textureType = "semi";
		};
		class Two: Single
		{
			displayName = "2";
			salvo = 2;
			burst = 1;
		};
	};
	class RS_MH6V3_weap_FFARLauncher_HEAT: rhs_weap_FFARLauncher
	{
		displayName = "Hydra (M247 HEAT)";
		magazines[] =
		{
			"RS_MH6V3_mag_Hydra_HEAT_7",
			"RS_MH6V3_mag_Hydra_HEAT_19"
		};
	};
	class RS_MH6V3_weap_FFARLauncher_M274: rhs_weap_FFARLauncher
	{
		displayName = "Hydra (M274 Smoke)";
		magazines[] =
		{
			"RS_MH6V3_mag_Hydra_M274_7",
			"RS_MH6V3_mag_Hydra_M274_19"
		};
	};
	class rhs_weap_FFARLauncher_M229: rhs_weap_FFARLauncher
	{
		displayName = "Hydra (M229 HEPD)";
		magazines[] =
		{
			"rhs_mag_M229_19",
			"rhs_mag_M229_19_green",
			"rhs_mag_M229_7",
			"rhs_mag_M229_7_green"
		};
	};
	class rhs_weap_FFARLauncher_M257: rhs_weap_FFARLauncher
	{
		displayName = "Hydra (M257 ILLUM)";
		magazines[] =
		{
			"rhs_mag_M257_7",
			"rhs_mag_M257_7_green",
			"rhs_mag_M257_7_USAF_LAU131"
		};
		modes[] = {"Far_AI","Single"};
		class Far_AI: Far_AI
		{
			minRange = 3000;
			minRangeProbab = 0.6;
			midRange = 4000;
			midRangeProbab = 0.9;
			maxRange = 6000;
			maxRangeProbab = 0.6;
		};
	};
	class RHS_Laserdesignator_MELB: Laserdesignator_mounted
	{
		displayName = "Laser Designator";
		cursor = "EmptyCursor";
		cursorAim = "EmptyCursor";
		nameSound = "laserdesignator";
		minRange = 1;
		minRangeProbab = 0.01;
		midRange = 2;
		midRangeProbab = 0.01;
		maxRange = 3;
		maxRangeProbab = 0.01;
	};
};
class CfgVehicles
{
	class Lamps_base_F;
	class RS_MH6V3_IZLID_Illuminator: Lamps_base_F
	{
		scope = 1;
		scopeCurator = 1;
		displayName = "RS MH-6V3 IR Illuminator Wide";
		model = "\DEVGRU\RS_MH6V3\data\light.p3d";
		class Hitpoints {};
		class AnimationSources {};
		class Reflectors
		{
			class Light_1
			{
				irLight = 1;
				color[] = {4,4,4};
				ambient[] = {0,0,0};
				intensity = 4000000;
				size = 1;
				innerAngle = 6.8;
				outerAngle = 8;
				coneFadeCoef = 1;
				position = "light_pos";
				direction = "light_dir";
				hitpoint = "";
				selection = "";
				useFlare = 1;
				flareSize = 0.2;
				flareMaxDistance = 3000;
				class Attenuation
				{
					start = 1;
					constant = "3.14159*0.000305";
					linear = 0;
					quadratic = 1;
					hardLimitStart = 3000;
					hardLimitEnd = 3000;
				};
			};
		};
	};
	class RS_MH6V3_IZLID_Illuminator_Narrow: RS_MH6V3_IZLID_Illuminator
	{
		displayName = "RS MH-6V3 IR Illuminator Narrow";
		class Reflectors: Reflectors
		{
			class Light_1: Light_1
			{
				innerAngle = 2.55;
				outerAngle = 3;
			};
		};
	};
	class RS_MH6V3_IZLID_Illuminator_B90: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 3600000;};};};
	class RS_MH6V3_IZLID_Illuminator_B80: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 3200000;};};};
	class RS_MH6V3_IZLID_Illuminator_B70: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 2800000;};};};
	class RS_MH6V3_IZLID_Illuminator_B60: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 2400000;};};};
	class RS_MH6V3_IZLID_Illuminator_B50: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 2000000;};};};
	class RS_MH6V3_IZLID_Illuminator_B40: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 1600000;};};};
	class RS_MH6V3_IZLID_Illuminator_B30: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 1200000;};};};
	class RS_MH6V3_IZLID_Illuminator_B20: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 800000;};};};
	class RS_MH6V3_IZLID_Illuminator_B10: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 400000;};};};
	class RS_MH6V3_IZLID_Illuminator_B0: RS_MH6V3_IZLID_Illuminator {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 0;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B90: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 3600000;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B80: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 3200000;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B70: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 2800000;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B60: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 2400000;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B50: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 2000000;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B40: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 1600000;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B30: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 1200000;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B20: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 800000;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B10: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 400000;};};};
	class RS_MH6V3_IZLID_Illuminator_Narrow_B0: RS_MH6V3_IZLID_Illuminator_Narrow {class Reflectors: Reflectors {class Light_1: Light_1 {intensity = 0;};};};
	class Helicopter;
	class Helicopter_Base_F: Helicopter
	{
		class Turrets;
		class HitPoints;
	};
	class Helicopter_Base_H: Helicopter_Base_F
	{
		class EventHandlers;
		class Turrets: Turrets
		{
			class CopilotTurret;
		};
		class HitPoints: HitPoints
		{
			class HitHull;
			class HitFuel;
			class HitEngine;
			class HitAvionics;
			class HitVRotor;
			class HitHRotor;
			class HitGlass1;
			class HitGlass2;
			class HitGlass3;
			class HitGlass4;
			class HitGlass5;
			class HitGlass6;
		};
		class CargoTurret;
		class AnimationSources;
		class ViewOptics;
		class RotorLibHelicopterProperties;
		class Components;
	};
	class RHS_MELB_base: Helicopter_Base_H
	{
		author = "$STR_RHSUSF_AUTHOR_FULL";
		dlc = "RHS_USAF";
		scope = 0;
		side = 1;
		faction = "rhs_faction_socom";
		crew = "rhsusf_army_ucp_helipilot";
		model = "rhsusf\addons\rhsusf_melb\MELB.p3d";
		picture = "rhsusf\addons\rhsusf_melb\Data\ui\melb_h_6m_ca.paa";
		icon = "rhsusf\addons\rhsusf_melb\Data\ui\map_melb_h_6m_ca.paa";
		mapSize = 11;
		destrType = "DestructWreck";
		accuracy = 0.5;
		unitInfoType = "RscUnitInfoAir_NoRadar_MELB";
		unitInfoTypeRTD = "RHSUSF_RscUnitInfoAirRTDFullDigital_MELB";
		nameSound = "veh_helicopter";
		driverAction = "MELB_Pilot";
		driverInAction = "MELB_Pilot";
		getInAction = "ChopperLight_L_In_H";
		getOutAction = "GetOutLow";
		memoryPointsGetInDriver = "pos pilot";
		memoryPointsGetInDriverDir = "pos pilot dir";
		memoryPointsGetInDriverPrecise = "pos pilot";
		memoryPointsGetInCargo[] = {"pos cargo"};
		memoryPointsGetInCargoDir[] = {"pos cargo dir"};
		memoryPointsGetInCargoPrecise[] = {"pos cargo"};
		usePreciseGetInAction = 1;
		getInRadius = 1.5;
		cargoCompartments[] = {"compartment3"};
		cargoGetInAction[] = {"GetInLow"};
		cargoGetOutAction[] = {"GetOutLow"};
		cargoAction[] = {"passenger_flatground_generic04"};
		preciseGetInOut = 0;
		castCargoShadow = 1;
		getInProxyOrder[] = {9,1,2,3,4,5,6,7,8,10};
		extCameraPosition[] = {0,0.75,-10};
		driverCanSee = 31;
		transportSoldier = 6;
		hideWeaponsDriver = 1;
		hideWeaponsGunner = 1;
		hideWeaponsCargo = 1;
		threat[] = {0,0,0};
		radarType = 0;
		laserScanner = 1;
		nvScanner = 1;
		allowTabLock = 1;
		showAllTargets = 6;
		showCrewAim = 4;
		driverWeaponsInfoType = "RS_MH6V3_MELB_Turret_UnitInfo";
		irTarget = 1;
		irTargetSize = 0.7;
		visualTarget = 1;
		visualTargetSize = 0.8;
		radarTarget = 1;
		radarTargetSize = 0.8;
		receiveRemoteTargets = 1;
		reportRemoteTargets = 1;
		reportOwnPosition = 1;
		LockDetectionSystem = "2 +4 + 8 + 16";
		incomingMissileDetectionSystem = 16;
		weapons[] = {"rhs_weap_laserDesignator_AI","rhsusf_weap_LWIRCM"};
		magazines[] = {"rhs_laserfcsmag","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM"};
		hiddenSelections[] = {"camo1","d_SN"};
		hiddenSelectionsTextures[] = {"rhsusf\addons\rhsusf_melb\data\melb_ext_co.paa","rhsusf\addons\rhsusf_melb\data\decals\SN\blank_ca.paa"};
		class MFD{};
		class ViewOptics: ViewOptics
		{
			initAngleX = 0;
			minAngleX = -30;
			maxAngleX = 30;
			initAngleY = 0;
			minAngleY = -86;
			maxAngleY = 86;
			minFov = 0.25;
			maxFov = 1.25;
			initFov = 0.75;
		};
		memorypointcm[] = {"flare_launcher1"};
		memorypointcmdir[] = {"flare_launcher1_dir"};
		driveOnComponent[] = {"Skids"};
		fuelCapacity = 236;
		fuelConsumptionRate = 0.06;
		maxFordingDepth = 0.65;
		mainBladeRadius = 4.32;
		tailBladeRadius = 0.77;
		class RotorLibHelicopterProperties: RotorLibHelicopterProperties
		{
			RTDconfig = "DEVGRU\RS_MH6V3\RTD_MELB.xml";
			autoHoverCorrection[] = {0.28,2.88,0};
			defaultCollective = 0.5;
			throttleOffToIdle = 8;
			throttleIdleToOff = 6;
			throttleIdleToFull = 12;
			throttleFullToIdle = 6;
			maxTorque = 1200;
			stressDamagePerSec = 0.0033333332;
			maxHorizontalStabilizerLeftStress = 10000;
			maxHorizontalStabilizerRightStress = 10000;
			maxVerticalStabilizerStress = 10000;
			horizontalWingsAngleCollMin = 0;
			horizontalWingsAngleCollMax = 0;
			maxMainRotorStress = 45000;
			maxTailRotorStress = 20200;
			retreatBladeStallWarningSpeed = 77.222;
			rtd_center = "rtd_center";
		};
		startDuration = 10;
		washDownStrength = "0.7f";
		maxSpeed = 200;
		slingLoadMemoryPoint = "slingLoad0";
		slingLoadMaxCargoMass = 900;
		liftForceCoef = 1;
		cyclicAsideForceCoef = 1.65;
		cyclicForwardForceCoef = 0.4;
		backrotorforcecoef = 0.9;
		bodyFrictionCoef = 0.3;
		sensitivity = 2.5;
		maximumLoad = 1000;
		cost = 4000000;
		memoryPointSupply = "memsupply";
		supplyradius = 4;
		occludeSoundsWhenIn = 0.762341;
		obstructSoundsWhenIn = 0.616228;
		attenuationEffectType = "OpenHeliAttenuation";
		soundGeneralCollision1[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_default_int_1",1,1,100};
		soundGeneralCollision2[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_default_int_2",1,1,100};
		soundGeneralCollision3[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_default_int_3",1,1,100};
		soundCrashes[] = {"soundGeneralCollision1",0.33,"soundGeneralCollision2",0.33,"soundGeneralCollision3",0.33};
		soundLandCrashes[] = {"emptySound",0};
		soundBuildingCrash[] = {"soundGeneralCollision1",1,"soundGeneralCollision2",1,"soundGeneralCollision3",1};
		soundArmorCrash[] = {"soundGeneralCollision1",1,"soundGeneralCollision2",1,"soundGeneralCollision3",1};
		soundWoodCrash[] = {"soundGeneralCollision1",1,"soundGeneralCollision2",1,"soundGeneralCollision3",1};
		soundBushCollision1[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_1",1,1,100};
		soundBushCollision2[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_2",1,1,100};
		soundBushCollision3[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_bush_int_3",1,1,100};
		soundBushCrash[] = {"soundBushCollision1",0.33,"soundBushCollision2",0.33,"soundBushCollision3",0.33};
		soundWaterCollision1[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_1",1,1,100};
		soundWaterCollision2[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_coll_water_ext_2",1,1,100};
		soundWaterCrashes[] = {"soundWaterCollision1",0.5,"soundWaterCollision2",0.5};
		soundGetIn[] = {"A3\Sounds_F\vehicles\air\noises\heli_get_in2",0.56234133,1};
		soundGetOut[] = {"A3\Sounds_F\vehicles\air\noises\heli_get_out2",0.7943282,1,20};
		soundDammage[] = {"A3\Sounds_F\vehicles\crashes\helis\Heli_crash_default_ext_1",3.1622777,1};
		soundEngineOnInt[] = {"rhsusf\addons\rhsusf_melb\Sound\Int_Start",0.4,1};
		soundEngineOnExt[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Start",0.7943282,1,600};
		soundEngineOffInt[] = {"rhsusf\addons\rhsusf_melb\Sound\Int_Off",0.4,1};
		soundEngineOffExt[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Off",0.7943282,1,600};
		soundLocked[] = {"\A3\Sounds_F\weapons\Rockets\opfor_lock_1",1,1};
		soundIncommingMissile[] = {"\A3\Sounds_F\weapons\Rockets\opfor_lock_2",0.7,1};
		rotorDamageInt[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_rotor_int_open_1",1,1};
		rotorDamageOut[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_rotor_ext_1",2.5118864,1,150};
		rotorDamage[] = {"rotorDamageInt","rotorDamageOut"};
		tailDamageInt[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_tail",1,1};
		tailDamageOut[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_tail",1,1,300};
		tailDamage[] = {"tailDamageInt","tailDamageOut"};
		landingSoundInt0[] = {"A3\Sounds_F\vehicles\air\noises\landing_skids_int1_open",1,1,100};
		landingSoundInt1[] = {"A3\Sounds_F\vehicles\air\noises\landing_skids_int1_open",1,1,100};
		landingSoundInt[] = {"landingSoundInt0",0.5,"landingSoundInt1",0.5};
		landingSoundOut0[] = {"A3\Sounds_F\vehicles\air\noises\landing_skids_ext1",1.7782794,1,100};
		landingSoundOut1[] = {"A3\Sounds_F\vehicles\air\noises\landing_skids_ext1",1.7782794,1,100};
		landingSoundOut[] = {"landingSoundOut0",0.5,"landingSoundOut1",0.5};
		slingCargoAttach0[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineDownEndINT",1,1};
		slingCargoAttach1[] = {"A3\Sounds_F\vehicles\air\noises\SL_1hookLock",1,1,80};
		slingCargoAttach[] = {"slingCargoAttach0","slingCargoAttach1"};
		slingCargoDetach0[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineUpEndINT",1,1};
		slingCargoDetach1[] = {"A3\Sounds_F\vehicles\air\noises\SL_1hookUnlock",1,1,80};
		slingCargoDetach[] = {"slingCargoDetach0","slingCargoDetach1"};
		slingCargoDetachAir0[] = {"A3\Sounds_F\vehicles\air\noises\SL_unhook_air_int",1,1};
		slingCargoDetachAir1[] = {"A3\Sounds_F\vehicles\air\noises\SL_unhook_air_ext",1,1,80};
		slingCargoDetachAir[] = {"slingCargoDetach0","slingCargoDetach1"};
		slingCargoRopeBreak0[] = {"A3\Sounds_F\vehicles\air\noises\SL_rope_break_int",1,1};
		slingCargoRopeBreak1[] = {"A3\Sounds_F\vehicles\air\noises\SL_rope_break_ext",1,1,80};
		slingCargoRopeBreak[] = {"slingCargoDetach0","slingCargoDetach1"};
		class Sounds
		{
			class EngineExt
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Idle",1.2889254,1,400};
				frequency = "rotorSpeed*(1+rotorThrust/6)*0.9";
				volume = "camPos*((rotorSpeed-0.72)*4)";
			};
			class RotorExt
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Low",1.2589254,1,500};
				frequency = "1.3*(rotorSpeed factor [0.3, 0.7]) * (rotorSpeed factor [0.3, 1]) * (1 - rotorThrust/6)";
				volume = "camPos*(0 max (rotorSpeed-0.1))*(1 + rotorThrust)";
			};
			class RotorSwist
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Close",1.2,1,600};
				frequency = "rotorSpeed*(1+rotorThrust/6)*0.9";
				volume = "camPos * (gmeterZ factor[1.5, 2.5]) + (gmeterZ factor[0.5, -0.5]) * (rotorThrust factor [0.7, 0.9])";
			};
			class EngineInt
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Int_Idle",1,1};
				frequency = "rotorSpeed*(1+rotorThrust/6)*0.9";
				volume = "(1-camPos)*((rotorSpeed-0.75)*4)";
			};
			class RotorInt
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Int_Low",0.501187,1};
				frequency = "1*(rotorSpeed factor [0.3, 0.7]) * (rotorSpeed factor [0.3, 1]) * (1 - rotorThrust/6)";
				volume = "(1-camPos)*(0 max (rotorSpeed-0.1))*(1 + rotorThrust)*0.9";
			};
			class RotorBench
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Low",1.2589254,1,500};
				frequency = "1.3*(rotorSpeed factor [0.3, 0.7]) * (rotorSpeed factor [0.3, 1]) * (1 - rotorThrust/6)";
				volume = "(playerPos factor [3.9, 4]) * (1 - camPos) * (rotorSpeed factor [0.3, 1]) * (1 + rotorThrust) * 0.4";
				cone[] = {1.6,3.14,1.6,0.95};
			};
			class EngineBench
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Idle",1.2818383,1};
				frequency = "rotorSpeed*(1+rotorThrust/6)*0.9";
				volume = "(playerPos factor [3.9, 4]) * (1 - camPos) * (0 max (rotorSpeed-0.4))";
			};
			class WindBench
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\wind_open_out",0.56234133,1,50};
				frequency = 1;
				volume = "4 * (playerPos factor [3.9, 4]) * (1 - camPos) * ((speed factor[0, 30]) + (speed factor[0, -30]))";
			};
			class TransmissionDamageExt_phase1
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_ext_1",1,1,150};
				frequency = "0.66 + rotorSpeed / 3";
				volume = "camPos * (transmissionDamage factor [0.3, 0.35]) * (transmissionDamage factor [0.5, 0.45]) * (rotorSpeed factor [0.2, 0.5])";
			};
			class TransmissionDamageExt_phase2
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_ext_2",1,1,150};
				frequency = "0.66 + rotorSpeed / 3";
				volume = "camPos * (transmissionDamage factor [0.45, 0.5]) * (rotorSpeed factor [0.2, 0.5])";
			};
			class TransmissionDamageInt_phase1
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_int_1",1,1,150};
				frequency = "0.66 + rotorSpeed / 3";
				volume = "(1 - camPos) * (transmissionDamage factor [0.3, 0.35]) * (transmissionDamage factor [0.5, 0.45]) * (rotorSpeed factor [0.2, 0.5])";
			};
			class TransmissionDamageInt_phase2
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_int_2",1,1,150};
				frequency = "0.66 + rotorSpeed / 3";
				volume = "(1 - camPos) * (transmissionDamage factor [0.45, 0.5]) * (rotorSpeed factor [0.2, 0.5])";
			};
			class RotorNoiseExt
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Rotor_Fast",1.2818383,1,200};
				frequency = 1.5;
				volume = "(camPos*(rotorSpeed factor [0.6, 0.85]))";
				cone[] = {1.6,3.14,2,0.95};
			};
			class FarDistance
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Distance",2.0918384,1.1,1100};
				frequency = "rotorSpeed";
				volume = "2 * camPos * (0 max (rotorSpeed-0.4))";
			};
			class FarDistanceRotor
			{
				sound[] = {"rhsusf\addons\rhsusf_melb\Sound\tail_rotor",2.0918384,1,1000};
				frequency = "rotorSpeed";
				volume = "2 * camPos * (0 max (rotorSpeed-0.4))";
			};
			class damageAlarmInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_alarm_bluefor",0.31622776,1};
				frequency = 1;
				volume = "engineOn * (1 - camPos) * ( 1 - ((transmissionDamage factor [0.61, 0.60]) * (motorDamage factor [0.61, 0.60]) * (rotorDamage factor [0.51, 0.50]))) * (rotorSpeed factor [0.0, 0.001])";
			};
			class damageAlarmExt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_alarm_bluefor",0.2238721,1,20};
				frequency = 1;
				volume = "engineOn * camPos * ( 1 - ((transmissionDamage factor [0.61, 0.60]) * (motorDamage factor [0.61, 0.60]) * (rotorDamage factor [0.51, 0.50]))) * (rotorSpeed factor [0, 0.001])";
			};
			class rotorLowAlarmInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_alarm_rotor_low",0.31622776,1};
				frequency = 1;
				volume = "engineOn * (1 - camPos) * (rotorSpeed factor [0.9, 0.8999]) * (rotorSpeed factor [-0.5, 1]) * (speed factor [3, 3.01])";
			};
			class rotorLowAlarmExt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_alarm_rotor_low",0.2238721,1,20};
				frequency = 1;
				volume = "engineOn * camPos * (rotorSpeed factor [0.9, 0.8999]) * (rotorSpeed factor [-0.5, 1]) * (speed factor [3, 3.01])";
			};
			class scrubLandInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubLandInt_open",1,1,100};
				frequency = 1;
				volume = "2 * (1-camPos) * (scrubLand factor[0.02, 0.05])";
			};
			class scrubLandExt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubLandExt",1,1,100};
				frequency = 1;
				volume = "camPos * (scrubLand factor[0.02, 0.05])";
			};
			class scrubBuildingInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubBuildingInt",1,1,100};
				frequency = 1;
				volume = "2 * (1 - camPos) * (scrubBuilding factor[0.02, 0.05])";
			};
			class scrubBuildingExt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubBuildingExt",1,1,100};
				frequency = 1;
				volume = "camPos * (scrubBuilding factor[0.02, 0.05])";
			};
			class scrubTreeInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubTreeExt",1,1,100};
				frequency = 1;
				volume = "(1 - camPos) * ((scrubTree) factor [0, 0.01])";
			};
			class scrubTreeExt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubTreeExt",1,1,100};
				frequency = 1;
				volume = "camPos * ((scrubTree) factor [0, 0.01])";
			};
			class RainExt
			{
				sound[] = {"A3\Sounds_F\vehicles\noises\rain1_ext",1,1,100};
				frequency = 1;
				volume = "camPos * (rain - rotorSpeed/2) * 2";
			};
			class RainInt
			{
				sound[] = {"A3\Sounds_F\vehicles\noises\rain1_int_open",1,1,100};
				frequency = 1;
				volume = "(1-camPos)*(rain - rotorSpeed/2)*2";
			};
			class SlingLoadDownExt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineDownEXT",1,1,500};
				frequency = 1;
				volume = "camPos*(slingLoadActive factor [0,-1])";
			};
			class SlingLoadUpExt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineUpEXT",1,1,500};
				frequency = 1;
				volume = "camPos*(slingLoadActive factor [0,1])";
			};
			class SlingLoadDownInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineDownINT",1,1,500};
				frequency = 1;
				volume = "(1-camPos)*(slingLoadActive factor [0,-1])";
			};
			class SlingLoadUpInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineUpINT",1,1,500};
				frequency = 1;
				volume = "(1-camPos)*(slingLoadActive factor [0,1])";
			};
			class WindInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\wind_open_int",1,1,50};
				frequency = 1;
				volume = "(1-camPos)*(speed factor[5, 50])*(speed factor[5, 50])";
			};
			class WindLateralMovementInt
			{
				sound[] = {"A3\Sounds_F\vehicles\air\noises\wind_lateral_open_int",1,1,50};
				frequency = 1;
				volume = "(1-camPos)*lateralMovement*((speed factor [5,40]) + (speed factor [-5,-40]))";
			};
			class GStress
			{
				sound[] = {"A3\Sounds_F\vehicles\noises\vehicle_stress2b",0.11622776,1,50};
				frequency = 1;
				volume = "engineOn * (1-camPos) * ((gmeterZ factor[1.5, 2.5]) + (gmeterZ factor[0.5, -0.5]))";
			};
		};
		class SoundsExt
		{
			class SoundEvents{};
			class Sounds
			{
				class EngineExt
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Idle",1.2889254,1,400};
					frequency = "1.3*rotorSpeed";
					volume = "2 * camPos * (0 max (rotorSpeed-0.4))";
				};
				class RotorExt
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Low",1.2589254,1,500};
					frequency = "1.3*(rotorSpeed factor [0.3, 0.7]) * (rotorSpeed factor [0.3, 1]) * (1 - rotorThrust/6)";
					volume = "camPos * (rotorSpeed factor [0.3, 1]) * (1 + rotorThrust)";
				};
				class RotorSwist
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Close",1.2,1,600};
					frequency = "1.3*rotorspeed";
					volume = "camPos * (gmeterZ factor[1.5, 2.5]) + (gmeterZ factor[0.5, -0.5]) * (rotorThrust factor [0.7, 0.9])";
				};
				class EngineInt
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Int_Idle",1,1};
					frequency = "rotorSpeed";
					volume = "(1-camPos)*2*(0 max (rotorSpeed-0.4))";
				};
				class RotorInt
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Int_Low",1.2818383,1};
					frequency = "(rotorSpeed factor [0.3, 0.7]) * (rotorSpeed factor [0.3, 1]) * (1 - rotorThrust/6)";
					volume = "(1 - camPos) * (rotorSpeed factor [0.3, 0.7]) * (1 + rotorThrust) * 0.7";
				};
				class RotorBench
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Low",1.2589254,1,500};
					frequency = "1.3*(rotorSpeed factor [0.3, 0.7]) * (rotorSpeed factor [0.3, 1]) * (1 - rotorThrust/6)";
					volume = "(playerPos factor [3.9, 4]) * (1 - camPos) * (rotorSpeed factor [0.3, 1]) * (1 + rotorThrust) * 0.4";
					cone[] = {1.6,3.14,1.6,0.95};
				};
				class EngineBench
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Ext_Idle",1.2818383,1};
					frequency = "1.3*rotorSpeed";
					volume = "(playerPos factor [3.9, 4]) * (1 - camPos) * (0 max (rotorSpeed-0.4))";
				};
				class WindBench
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\wind_open_out",0.56234133,1,50};
					frequency = 1;
					volume = "4 * (playerPos factor [3.9, 4]) * (1 - camPos) * ((speed factor[0, 30]) + (speed factor[0, -30]))";
				};
				class TransmissionDamageExt_phase1
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_ext_1",1,1,150};
					frequency = "0.66 + rotorSpeed / 3";
					volume = "camPos * (transmissionDamage factor [0.3, 0.35]) * (transmissionDamage factor [0.5, 0.45]) * (rotorSpeed factor [0.2, 0.5])";
				};
				class TransmissionDamageExt_phase2
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_ext_2",1,1,150};
					frequency = "0.66 + rotorSpeed / 3";
					volume = "camPos * (transmissionDamage factor [0.45, 0.5]) * (rotorSpeed factor [0.2, 0.5])";
				};
				class TransmissionDamageInt_phase1
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_int_1",1,1,150};
					frequency = "0.66 + rotorSpeed / 3";
					volume = "(1 - camPos) * (transmissionDamage factor [0.3, 0.35]) * (transmissionDamage factor [0.5, 0.45]) * (rotorSpeed factor [0.2, 0.5])";
				};
				class TransmissionDamageInt_phase2
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_damage_transmission_int_2",1,1,150};
					frequency = "0.66 + rotorSpeed / 3";
					volume = "(1 - camPos) * (transmissionDamage factor [0.45, 0.5]) * (rotorSpeed factor [0.2, 0.5])";
				};
				class RotorNoiseExt
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Rotor_Fast",1.2818383,1,200};
					frequency = 1;
					volume = "(camPos*(rotorSpeed factor [0.6, 0.85]))";
					cone[] = {1.6,3.14,2,0.95};
				};
				class FarDistance
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\Distance",2.0918384,1.1,1100};
					frequency = "rotorSpeed";
					volume = "2 * camPos * (0 max (rotorSpeed-0.4))";
				};
				class FarDistanceRotor
				{
					sound[] = {"rhsusf\addons\rhsusf_melb\Sound\tail_rotor",2.0918384,1,1000};
					frequency = "rotorSpeed";
					volume = "2 * camPos * (0 max (rotorSpeed-0.4))";
				};
				class damageAlarmInt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_alarm_bluefor",0.31622776,1};
					frequency = 1;
					volume = "engineOn * (1 - camPos) * ( 1 - ((transmissionDamage factor [0.61, 0.60]) * (motorDamage factor [0.61, 0.60]) * (rotorDamage factor [0.51, 0.50]))) * (rotorSpeed factor [0.0, 0.001])";
				};
				class damageAlarmExt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_alarm_bluefor",0.2238721,1,20};
					frequency = 1;
					volume = "engineOn * camPos * ( 1 - ((transmissionDamage factor [0.61, 0.60]) * (motorDamage factor [0.61, 0.60]) * (rotorDamage factor [0.51, 0.50]))) * (rotorSpeed factor [0, 0.001])";
				};
				class rotorLowAlarmInt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_alarm_rotor_low",0.31622776,1};
					frequency = 1;
					volume = "engineOn * (1 - camPos) * (rotorSpeed factor [0.9, 0.8999]) * (rotorSpeed factor [-0.5, 1]) * (speed factor [3, 3.01])";
				};
				class rotorLowAlarmExt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\heli_alarm_rotor_low",0.2238721,1,20};
					frequency = 1;
					volume = "engineOn * camPos * (rotorSpeed factor [0.9, 0.8999]) * (rotorSpeed factor [-0.5, 1]) * (speed factor [3, 3.01])";
				};
				class scrubLandInt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubLandInt_open",1,1,100};
					frequency = 1;
					volume = "2 * (1-camPos) * (scrubLand factor[0.02, 0.05])";
				};
				class scrubLandExt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubLandExt",1,1,100};
					frequency = 1;
					volume = "camPos * (scrubLand factor[0.02, 0.05])";
				};
				class scrubBuildingInt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubBuildingInt",1,1,100};
					frequency = 1;
					volume = "2 * (1 - camPos) * (scrubBuilding factor[0.02, 0.05])";
				};
				class scrubBuildingExt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubBuildingExt",1,1,100};
					frequency = 1;
					volume = "camPos * (scrubBuilding factor[0.02, 0.05])";
				};
				class scrubTreeInt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubTreeExt",1,1,100};
					frequency = 1;
					volume = "(1 - camPos) * ((scrubTree) factor [0, 0.01])";
				};
				class scrubTreeExt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\scrubTreeExt",1,1,100};
					frequency = 1;
					volume = "camPos * ((scrubTree) factor [0, 0.01])";
				};
				class RainExt
				{
					sound[] = {"A3\Sounds_F\vehicles\noises\rain1_ext",1,1,100};
					frequency = 1;
					volume = "camPos * (rain - rotorSpeed/2) * 2";
				};
				class RainInt
				{
					sound[] = {"A3\Sounds_F\vehicles\noises\rain1_int_open",1,1,100};
					frequency = 1;
					volume = "(1-camPos)*(rain - rotorSpeed/2)*2";
				};
				class SlingLoadDownExt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineDownEXT",1,1,500};
					frequency = 1;
					volume = "camPos*(slingLoadActive factor [0,-1])";
				};
				class SlingLoadUpExt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineUpEXT",1,1,500};
					frequency = 1;
					volume = "camPos*(slingLoadActive factor [0,1])";
				};
				class SlingLoadDownInt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineDownINT",1,1,500};
					frequency = 1;
					volume = "(1-camPos)*(slingLoadActive factor [0,-1])";
				};
				class SlingLoadUpInt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\SL_engineUpINT",1,1,500};
					frequency = 1;
					volume = "(1-camPos)*(slingLoadActive factor [0,1])";
				};
				class WindInt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\wind_open_int",1.1220185,1,50};
					frequency = 1;
					volume = "(1-camPos)*(speed factor[5, 50])*(speed factor[5, 50])";
				};
				class WindLateralMovementInt
				{
					sound[] = {"A3\Sounds_F\vehicles\air\noises\wind_lateral_open_int",1.9952624,1,50};
					frequency = 1;
					volume = "(1-camPos)*lateralMovement*((speed factor [5,40]) + (speed factor [-5,-40]))";
				};
				class GStress
				{
					sound[] = {"A3\Sounds_F\vehicles\noises\vehicle_stress2b",0.11622776,1,50};
					frequency = 1;
					volume = "engineOn * (1-camPos) * ((gmeterZ factor[1.5, 2.5]) + (gmeterZ factor[0.5, -0.5]))";
				};
			};
		};
		class CargoTurret;
		class pilotCamera
		{
			class OpticsIn
			{
				class Wide
				{
					opticsDisplayName = "WIDE";
					initAngleX = 0;
					minAngleX = 0;
					maxAngleX = 0;
					initAngleY = 0;
					minAngleY = 0;
					maxAngleY = 0;
					initFov = 0.36;
					minFov = 0.36;
					maxFov = 0.36;
					visionMode[] = {"Normal","NVG","Ti"};
					thermalMode[] = {0,1};
					directionStabilized = 0;
					horizontallyStabilized = 0;
					gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_wf.p3d";
					opticsPPEffects[] = {"OpticsCHAbera3","OpticsBlur3"};
					gunnerOpticsEffect[] = {"TankCommanderOptics2"};
				};
				class Medium: Wide
				{
					opticsDisplayName = "MED";
					initFov = 0.24;
					minFov = 0.24;
					maxFov = 0.24;
					gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_w2.p3d";
				};
				class Narrow: Wide
				{
					opticsDisplayName = "NAR";
					initFov = 0.12;
					minFov = 0.12;
					maxFov = 0.12;
					gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_m.p3d";
				};
				class Narrow2: Wide
				{
					opticsDisplayName = "NAR 2";
					initFov = 0.035;
					minFov = 0.035;
					maxFov = 0.035;
					gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_n.p3d";
				};
				class Narrow3: Wide
				{
					opticsDisplayName = "NAR 3";
					initFov = 0.015;
					minFov = 0.015;
					maxFov = 0.015;
					gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_n2.p3d";
				};
				showMiniMapInOptics = 0;
				showUAVViewpInOptics = 0;
				showSlingLoadManagerInOptics = 1;
			};
			gunBeg = "commanderview";
			gunEnd = "laserstart";
			memoryPointGun = "commanderview";
			discretedistance[] = {100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2300,2400,2500,2600,2700,2800,2900,3000};
			discretedistanceinitindex = 3;
			weapons[] = {"rhs_weap_laserDesignator_AI","rhs_weap_fcs_ah64"};
			magazines[] = {"rhs_laserfcsmag","rhs_LaserMag_ai"};
			minTurn = -180;
			maxTurn = 180;
			initTurn = 0;
			minElev = -45;
			maxElev = 90;
			initElev = 0;
			maxXRotSpeed = 1;
			maxYRotSpeed = 1;
			pilotOpticsShowCursor = 1;
			controllable = 1;
		};
		memoryPointGunnerOptics = "commanderview";
		memoryPointDriverOptics = "light_dir";
		gunBeg = "commanderview";
		gunEnd = "laserstart";
		memoryPointGun = "commanderview";
		body = "obsTurret";
		gun = "obsGun";
		animationSourceBody = "obsTurret";
		animationSourceGun = "obsGun";
		turretInfoType = "RS_MH6V3_MELB_Turret_UnitInfo";
		usepip = 1;
		canUseScanners = 1;
		class Exhausts
		{
			class Exhaust01
			{
				position = "exhaust1";
				direction = "exhaust1_dir";
				effect = "ExhaustEffectHeli";
			};
		};
		armor = 35;
		armorStructural = 20;
		epeImpulseDamageCoef = 20;
		damageResistance = 0.01039;
		crewCrashProtection = 0.2;
		hullDamageCauseExplosion = 1;
		hullExplosionDelay[] = {10,20};
		class HitPoints: HitPoints
		{
			class HitFuel: HitFuel
			{
				armor = -130;
				armorComponent = "fuel_hit";
				name = "fuel_hit";
				visual = "-";
				radius = 0.125;
				minimalhit = -0.04;
				explosionShielding = 0.5;
				passThrough = 0;
			};
			class HitHull: HitHull
			{
				depends = "HitEngine";
				simulation = "RHS_Hull_Helicopter";
				armor = -120;
				minimalHit = -0.15;
				radius = 0.02;
				name = "hull_hit";
				armorComponent = "hull_hit";
				visual = "zbytek";
				passThrough = 1;
				class DestructionEffects: RHS_Effects_Helicopter_Hull_Destruction{};
			};
			class HitEngine: HitEngine
			{
				armorComponent = "engine_hit";
				name = "engine_hit";
				armor = -120;
				visual = "-";
				radius = 0.15;
				explosionShielding = 0.85;
				minimalhit = -0.05;
				passThrough = 0.3;
			};
			class HitAvionics: HitAvionics
			{
				name = "avionics_hit";
				armor = 2;
				visual = "-";
				radius = 0.05;
				explosionShielding = 0.5;
			};
			class HitVRotor: HitVRotor
			{
				visual = "tail rotor static";
				armor = 1;
				radius = 0.05;
				explosionShielding = 0.8;
			};
			class HitHRotor: HitHRotor
			{
				visual = "main rotor static";
				armor = 3;
				radius = 0.2;
				explosionShielding = 0.5;
			};
			class HitGlass1: HitGlass1
			{
				armor = 2;
				radius = 0.15;
				explosionShielding = 2;
			};
			class HitGlass2: HitGlass2
			{
				armor = 2;
				radius = 0.15;
				explosionShielding = 2;
			};
			class HitGlass3: HitGlass3
			{
				armor = 2;
				radius = 0.15;
				explosionShielding = 2;
			};
			class HitGlass4: HitGlass4
			{
				armor = 2;
				radius = 0.15;
				explosionShielding = 2;
			};
			class HitPylon1
			{
				armor = -30;
				name = "hit_pylon_1";
				passThrough = 0;
				minimalHit = -0.1;
				explosionShielding = 0.1;
				radius = 0.7;
				visual = "-";
				class DestructionEffects
				{
					ammoExplosionEffect = "";
					effectRadius = 1;
					ignoreFuel = 1;
					class RHS_Pylon_Flash
					{
						simulation = "particles";
						type = "RHS_ERA_Flash";
						position = "fx_pylon_1";
						intensity = 0.5;
						interval = 1;
						lifeTime = 0.006;
					};
					class RHS_Pylon_Sound
					{
						simulation = "sound";
						type = "RHS_ERA_Explosion_Sound";
						position = "fx_pylon_1";
						intensity = 1;
						interval = 1;
						lifeTime = 1;
					};
					class RHS_Pylon_Smoke
					{
						simulation = "particles";
						type = "RHS_ERA_Smoke";
						position = "fx_pylon_1";
						intensity = 0.1;
						interval = 1;
						lifeTime = 0.04;
					};
					class RHS_Pylon_Shard
					{
						simulation = "particles";
						type = "RHS_ERA_Shard";
						position = "fx_pylon_1";
						intensity = 1;
						interval = 1;
						lifeTime = 0.03;
					};
				};
			};
			class HitPylon2
			{
				armor = -30;
				name = "hit_pylon_2";
				passThrough = 0;
				minimalHit = -0.1;
				explosionShielding = 0.1;
				radius = 0.7;
				visual = "-";
				class DestructionEffects
				{
					ammoExplosionEffect = "";
					effectRadius = 1;
					ignoreFuel = 1;
					class RHS_Pylon_Flash
					{
						simulation = "particles";
						type = "RHS_ERA_Flash";
						position = "fx_pylon_2";
						intensity = 0.5;
						interval = 1;
						lifeTime = 0.006;
					};
					class RHS_Pylon_Sound
					{
						simulation = "sound";
						type = "RHS_ERA_Explosion_Sound";
						position = "fx_pylon_2";
						intensity = 1;
						interval = 1;
						lifeTime = 1;
					};
					class RHS_Pylon_Smoke
					{
						simulation = "particles";
						type = "RHS_ERA_Smoke";
						position = "fx_pylon_2";
						intensity = 0.1;
						interval = 1;
						lifeTime = 0.04;
					};
					class RHS_Pylon_Shard
					{
						simulation = "particles";
						type = "RHS_ERA_Shard";
						position = "fx_pylon_2";
						intensity = 1;
						interval = 1;
						lifeTime = 0.03;
					};
				};
			};
			class HitPylon3
			{
				armor = -30;
				name = "hit_pylon_3";
				passThrough = 0;
				minimalHit = -0.1;
				explosionShielding = 0.1;
				radius = 0.7;
				visual = "-";
				class DestructionEffects
				{
					ammoExplosionEffect = "";
					effectRadius = 1;
					ignoreFuel = 1;
					class RHS_Pylon_Flash
					{
						simulation = "particles";
						type = "RHS_ERA_Flash";
						position = "fx_pylon_3";
						intensity = 0.5;
						interval = 1;
						lifeTime = 0.006;
					};
					class RHS_Pylon_Sound
					{
						simulation = "sound";
						type = "RHS_ERA_Explosion_Sound";
						position = "fx_pylon_3";
						intensity = 1;
						interval = 1;
						lifeTime = 1;
					};
					class RHS_Pylon_Smoke
					{
						simulation = "particles";
						type = "RHS_ERA_Smoke";
						position = "fx_pylon_3";
						intensity = 0.1;
						interval = 1;
						lifeTime = 0.04;
					};
					class RHS_Pylon_Shard
					{
						simulation = "particles";
						type = "RHS_ERA_Shard";
						position = "fx_pylon_3";
						intensity = 1;
						interval = 1;
						lifeTime = 0.03;
					};
				};
			};
			class HitPylon4
			{
				armor = -30;
				name = "hit_pylon_4";
				passThrough = 0;
				minimalHit = -0.1;
				explosionShielding = 0.1;
				radius = 0.7;
				visual = "-";
				class DestructionEffects
				{
					ammoExplosionEffect = "";
					effectRadius = 1;
					ignoreFuel = 1;
					class RHS_Pylon_Flash
					{
						simulation = "particles";
						type = "RHS_ERA_Flash";
						position = "fx_pylon_4";
						intensity = 0.5;
						interval = 1;
						lifeTime = 0.006;
					};
					class RHS_Pylon_Sound
					{
						simulation = "sound";
						type = "RHS_ERA_Explosion_Sound";
						position = "fx_pylon_4";
						intensity = 1;
						interval = 1;
						lifeTime = 1;
					};
					class RHS_Pylon_Smoke
					{
						simulation = "particles";
						type = "RHS_ERA_Smoke";
						position = "fx_pylon_4";
						intensity = 0.1;
						interval = 1;
						lifeTime = 0.04;
					};
					class RHS_Pylon_Shard
					{
						simulation = "particles";
						type = "RHS_ERA_Shard";
						position = "fx_pylon_4";
						intensity = 1;
						interval = 1;
						lifeTime = 0.03;
					};
				};
			};
		};
		class Damage
		{
			tex[] = {};
			mat[] = {"rhsusf\addons\rhsusf_melb\data\melb_ext.rvmat","rhsusf\addons\rhsusf_melb\data\melb_ext_damage.rvmat","rhsusf\addons\rhsusf_melb\data\melb_ext_destruct.rvmat","rhsusf\addons\rhsusf_melb\data\melb_glass.rvmat","rhsusf\addons\rhsusf_melb\data\melb_glass_damage.rvmat","rhsusf\addons\rhsusf_melb\data\melb_glass_destruct.rvmat","rhsusf\addons\rhsusf_melb\data\melb_glass_in.rvmat","rhsusf\addons\rhsusf_melb\data\melb_glass_damage.rvmat","rhsusf\addons\rhsusf_melb\data\melb_glass_destruct.rvmat"};
		};
		class AnimationSources: AnimationSources
		{
			class AddBenches
			{
				source = "user";
				animPeriod = 1e-06;
				initPhase = 0;
			};
			class Addgunrack
			{
				source = "user";
				animPeriod = 1e-07;
				initPhase = 0;
			};
			class Addcrosshair
			{
				source = "user";
				animPeriod = 1e-06;
				initPhase = 0;
			};
			class Addfueltank
			{
				source = "user";
				animPeriod = 1e-06;
				initPhase = 0;
			};
			class AddBobhead
			{
				source = "user";
				animPeriod = 1e-06;
				initPhase = 0;
				displayName = "Bobblehead";
			};
			class hide_NoFear
			{
				source = "user";
				animPeriod = 1e-05;
				initPhase = 0;
				displayName = "No Fear Decal";
			};
			class hide_SGDM: hide_NoFear
			{
				displayName = "Six Guns Decal";
			};
			class hide_SN_nose: hide_NoFear
			{
				displayName = "Tail Number on nose";
			};
			class hide_clan: hide_NoFear
			{
				displayName = "Squad XML";
			};
			class HitGlass1
			{
				source = "Hit";
				hitpoint = "HitGlass1";
				raw = 1;
			};
			class HitGlass2: HitGlass1
			{
				hitpoint = "HitGlass2";
			};
			class HitGlass3: HitGlass1
			{
				hitpoint = "HitGlass3";
			};
			class HitGlass4: HitGlass1
			{
				hitpoint = "HitGlass4";
			};
			class HitGlass5: HitGlass1
			{
				hitpoint = "HitGlass5";
			};
			class HitGlass6: HitGlass1
			{
				hitpoint = "HitGlass6";
			};
			class MFD_Pilot
			{
				source = "user";
				animPeriod = 1;
				initPhase = 0;
			};
			class MFD_CoPilot: MFD_Pilot{};
			class pilotpip
			{
				source = "user";
				animperiod = 0.001;
				initPhase = 0;
			};
			class copilotpip: pilotpip{};
			class hit_pylon_1_source
			{
				source = "Hit";
				hitpoint = "HitPylon1";
			};
			class hit_pylon_2_source
			{
				source = "Hit";
				hitpoint = "HitPylon2";
			};
			class hit_pylon_3_source
			{
				source = "Hit";
				hitpoint = "HitPylon3";
			};
			class hit_pylon_4_source
			{
				source = "Hit";
				hitpoint = "HitPylon4";
			};
		};
		class UserActions
		{
			class MFD_Toggle
			{
				displayName = "Toggle Monitor";
				onlyforplayer = 1;
				position = "doplnovani";
				radius = 2;
				shortcut = "LandGearUp";
				condition = "((call rhsusf_fnc_findPlayer)==driver this) or ((call rhsusf_fnc_findPlayer)==gunner this) ";
				statement = "call RHS_MELB_fnc_MFD_toggle";
				showWindow = 0;
			};
			class RS_MH6V3_ResetCameras
			{
				displayName = "<t color='#7fd8ff'>Reset Cameras</t>";
				onlyforplayer = 1;
				position = "doplnovani";
				radius = 2;
				condition = "((call rhsusf_fnc_findPlayer)==driver this) or ((call rhsusf_fnc_findPlayer)==gunner this)";
				statement = "[this] call RS_MH6V3_fnc_resetCameras";
				showWindow = 0;
				priority = 9.8;
			};
			class SAFEMODE
			{
				displayName = "<t color='#00FF7F'>MASTERSAFE</t>";
				condition = "(call rhsusf_fnc_findPlayer) in this";
				statement = "(call rhsusf_fnc_findPlayer) action ['SwitchWeapon', this, (call rhsusf_fnc_findPlayer), 0];";
				position = "";
				radius = 10;
				priority = 10.5;
				onlyforplayer = 1;
				showWindow = 0;
				shortcut = "user13";
				hideOnUse = 1;
			};
		};
		class Attributes
		{
			class rhs_MELB_TailNumber
			{
				displayName = "Define Tail Number";
				tooltip = "Select tail number specific to this helicopter.";
				property = "rhs_MELB_TailNumber";
				control = "Combo";
				expression = "if(_value != 'NoChange')then{ [_this,'d_SN',_value] call RHS_MELB_fnc_tailNumber}";
				defaultValue = 0;
				typeName = "STRING";
				class values
				{
					class NoChange
					{
						name = "Default defined";
						value = "NoChange";
					};
					class blank_ca
					{
						name = "Empty";
						value = "blank_ca";
					};
					class MELB_SN_25385_ca
					{
						name = "25385";
						value = "MELB_SN_25385_ca";
					};
					class MELB_SN_25381_ca
					{
						name = "25381";
						value = "MELB_SN_25381_ca";
					};
					class MELB_SN_25378_ca
					{
						name = "25378";
						value = "MELB_SN_25378_ca";
					};
					class MELB_SN_25376_ca
					{
						name = "25376";
						value = "MELB_SN_25376_ca";
					};
					class MELB_SN_25374_ca
					{
						name = "25374";
						value = "MELB_SN_25374_ca";
					};
					class MELB_SN_25372_ca
					{
						name = "25372";
						value = "MELB_SN_25372_ca";
					};
					class MELB_SN_25366_ca
					{
						name = "25366";
						value = "MELB_SN_25366_ca";
					};
					class MELB_SN_25363_ca
					{
						name = "25363";
						value = "MELB_SN_25363_ca";
					};
					class MELB_SN_25361_ca
					{
						name = "25361";
						value = "MELB_SN_25361_ca";
					};
					class MELB_SN_25358_ca
					{
						name = "25358";
						value = "MELB_SN_25358_ca";
					};
					class MELB_SN_25355_ca
					{
						name = "25355";
						value = "MELB_SN_25355_ca";
					};
					class MELB_SN_25350_ca
					{
						name = "25350";
						value = "MELB_SN_25350_ca";
					};
					class MELB_SN_25349_ca
					{
						name = "25349";
						value = "MELB_SN_25349_ca";
					};
					class MELB_SN_25348_ca
					{
						name = "25348";
						value = "MELB_SN_25348_ca";
					};
					class MELB_SN_25346_ca
					{
						name = "25346";
						value = "MELB_SN_25346_ca";
					};
					class MELB_SN_24683_ca
					{
						name = "24683";
						value = "MELB_SN_24683_ca";
					};
					class MELB_SN_23654_ca
					{
						name = "23654";
						value = "MELB_SN_23654_ca";
					};
					class MELB_SN_23653_ca
					{
						name = "23653";
						value = "MELB_SN_23653_ca";
					};
					class MELB_SN_23652_ca
					{
						name = "23652";
						value = "MELB_SN_23652_ca";
					};
					class MELB_SN_23649_ca
					{
						name = "23649";
						value = "MELB_SN_23649_ca";
					};
					class MELB_SN_23636_ca
					{
						name = "23636";
						value = "MELB_SN_23636_ca";
					};
					class MELB_SN_23635_ca
					{
						name = "23635";
						value = "MELB_SN_23635_ca";
					};
					class MELB_SN_23632_ca
					{
						name = "23632";
						value = "MELB_SN_23632_ca";
					};
					class MELB_SN_23631_ca
					{
						name = "23631";
						value = "MELB_SN_23631_ca";
					};
				};
			};
			class rhs_MELB_NoFear
			{
				displayName = "No Fear";
				property = "MELB_NoFear";
				control = "CheckboxNumber";
				expression = "_this animate ['hide_NoFear',_value,true]";
				defaultValue = 0;
			};
			class rhs_MELB_SGDM: rhs_MELB_NoFear
			{
				displayName = "Six Guns";
				property = "MELB_SGDM";
				expression = "_this animate ['hide_SGDM',_value,true]";
			};
			class rhs_MELB_SN_Nose: rhs_MELB_NoFear
			{
				displayName = "Tail Number";
				property = "MELB_SN_Nose";
				expression = "_this animate ['hide_SN_nose',_value,true]";
			};
			class rhs_MELB_clan: rhs_MELB_NoFear
			{
				displayName = "Squad XML";
				property = "MELB_clan";
				expression = "_this animate ['hide_clan',_value,true]";
			};
			class MELB_ToggleBoy: rhs_MELB_NoFear
			{
				displayName = "Bobblehead";
				property = "MELB_ToggleBoy";
				expression = "_this animate ['AddBobhead',_value,true]";
			};
		};
		class Reflectors
		{
			class Light
			{
				color[] = {7000,7500,10000,1};
				ambient[] = {95,95,100,0};
				intensity = 50;
				size = 1;
				innerAngle = 10;
				outerAngle = 60;
				coneFadeCoef = 7;
				position = "Light_pos";
				direction = "Light_dir";
				hitpoint = "Light_hitpoint";
				selection = "Light";
				useFlare = 1;
				flareSize = 6;
				flareMaxDistance = 250;
				dayLight = 0;
				class Attenuation
				{
					start = 1;
					constant = 0;
					linear = 0;
					quadratic = 4;
				};
			};
		};
		class NVGMarkers
		{
			class IR_Position
			{
				color[] = {0.1,0.1,0.1};
				ambient[] = {0.01,0.01,0.01};
				brightness = 0.15;
				name = "IR_Position";
				drawLight = 1;
				drawLightSize = 0.01;
				drawLightCenterSize = 0.005;
				activeLight = 0;
				blinking = 0;
				dayLight = 0;
				onlyInNvg = 1;
				useFlare = 0;
			};
		};
		class Turrets: Turrets
		{
			class CopilotTurret: CopilotTurret
			{
				gunnerCompartments = "Compartment1";
				body = "obsTurret";
				gun = "obsGun";
				animationSourceBody = "obsTurret";
				animationSourceGun = "obsGun";
				turretInfoType = "Rsc_MELB_Turret_UnitInfo";
				stabilizedInAxes = 3;
				memoryPointGunnerOptics = "commanderview";
				minElev = -180;
				maxElev = 180;
				initElev = 0;
				minTurn = -180;
				maxTurn = 180;
				initTurn = 0;
				minFov = 0.25;
				maxFov = 0.9;
				initFov = 0.75;
				lodTurnedOut = 1100;
				lodTurned = 1100;
				memoryPointsGetInGunner = "pos gunner";
				memoryPointsGetInGunnerDir = "pos gunner dir";
				memoryPointsGetInGunnerPrecise = "pos gunner";
				gunBeg = "commanderview";
				gunEnd = "laserstart";
				memoryPointGun = "commanderview";
				discretedistance[] = {100,200,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,1900,2000,2100,2200,2300,2400,2500,2600,2700,2800,2900,3000};
				discretedistanceinitindex = 3;
				weapons[] = {"rhs_weap_laserDesignator_AI","rhs_weap_fcs_ah64"};
				magazines[] = {"rhs_laserfcsmag","rhs_LaserMag_ai"};
				soundServo[] = {"",0.01,1,30};
				inGunnerMayFire = 1;
				outGunnerMayFire = 1;
				primaryGunner = 1;
				gunnerAction = "MELB_Copilot";
				gunnerInAction = "MELB_Copilot";
				usePreciseGetInAction = 1;
				precisegetinout = 0;
				gunnerGetInAction = "Chopperlight_R_In_H";
				gunnergetOutAction = "GetOutLow";
				gunnerOpticsModel = "";
				TurretCanSee = "1+2+4+8";
				showAllTargets = 1;
				gunnerHasFlares = 1;
				usepip = 1;
				canUseScanners = 1;
				allowTabLock = 0;
				class ViewGunner
				{
					minAngleX = -65;
					maxAngleX = 85;
					initAngleX = 0;
					minAngleY = -150;
					maxAngleY = 150;
					initAngleY = 0;
					minFov = 0.25;
					maxFov = 0.9;
					initFov = 0.75;
				};
				class OpticsIn
				{
					class Wide
					{
						opticsDisplayName = "TRK COR";
						initAngleX = 0;
						minAngleX = -360;
						maxAngleX = 360;
						initAngleY = 0;
						minAngleY = -15;
						maxAngleY = 85;
						initFov = 0.3;
						minFov = 0.3;
						maxFov = 0.3;
						visionMode[] = {"Normal","NVG","Ti"};
						thermalMode[] = {0};
						directionStabilized = 1;
						horizontallyStabilized = 1;
						gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_wf.p3d";
						opticsPPEffects[] = {"OpticsCHAbera3","OpticsBlur3"};
						gunnerOpticsEffect[] = {"TankCommanderOptics2"};
					};
					class WideT: Wide
					{
						initFov = 0.2;
						minFov = 0.2;
						maxFov = 0.2;
						gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_w2.p3d";
					};
					class MediumT: WideT
					{
						initFov = 0.1;
						minFov = 0.1;
						maxFov = 0.1;
						gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_m.p3d";
					};
					class NarrowT: WideT
					{
						initFov = 0.022;
						minFov = 0.022;
						maxFov = 0.022;
						gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_n.p3d";
					};
					class NarrowT2: WideT
					{
						initFov = 0.0092;
						minFov = 0.0092;
						maxFov = 0.0092;
						gunnerOpticsModel = "rhsusf\addons\rhsusf_melb\data\optics\melb_flir_n2.p3d";
					};
				};
				class Components
				{
					class VehicleSystemsDisplayManagerComponentLeft: VehicleSystemsTemplateLeftPilot{};
					class VehicleSystemsDisplayManagerComponentRight: VehicleSystemsTemplateRightPilot{};
				};
				class Hitpoints{};
			};
		};
		class EventHandlers: EventHandlers
		{
			class RHS_MELB_EH
			{
				init = "_this call RS_MH6V3_fnc_syncPylonOwner; _this call RS_MH6V3_fnc_initLAIRCMVehicle; params ['_vehicle']; if (_vehicle isKindOf 'RHS_MELB_AH6M') then {_vehicle animate ['Addcrosshair', 1, true]}";
				getIn = "_this call RS_MH6V3_fnc_syncPylonOwner; params ['_vehicle']; [_vehicle] call RS_MH6V3_fnc_applyLAIRCMMode";
				getOut = "_this call RS_MH6V3_fnc_syncPylonOwner; params ['_vehicle']; [_vehicle] call RS_MH6V3_fnc_applyLAIRCMMode";
				engine = "params ['_vehicle', '_engineOn']; [_vehicle, _engineOn] call RS_MH6V3_fnc_handleIZLIDPowerState";
				fired = "_this call RS_MH6V3_fnc_handleMinigunFired";
				incomingMissile = "_this call RS_MH6V3_fnc_handleIncomingMissile";
				killed = "params ['_vehicle']; [_vehicle, false] call RS_MH6V3_fnc_handleIZLIDPowerState";
				controlsShifted = "params ['_vehicle', '_activeCopilot']; _vehicle setVariable ['RS_MH6V3_activeCopilot', _activeCopilot, true]; [_vehicle] call RS_MH6V3_fnc_syncPylonOwner";
				handleDamage = "_this call RHS_MELB_fnc_fallDamage";
				postInit = "params ['_vehicle']; if (_vehicle isKindOf 'RHS_MELB_AH6M') then {_vehicle animate ['Addcrosshair', 1, true]}; _this call rhs_fnc_reapplyTextures";
			};
		};
		class Components: Components
		{
			class SensorsManagerComponent
			{
				class Components
				{
					class IRSensorComponent: SensorTemplateIR
					{
						class AirTarget
						{
							minRange = 50;
							maxRange = 4000;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = 1;
						};
						class GroundTarget
						{
							minRange = 50;
							maxRange = 3000;
							objectDistanceLimitCoef = 1;
							viewDistanceLimitCoef = 1;
						};
						maxTrackableSpeed = 75;
						angleRangeHorizontal = 240;
						angleRangeVertical = 110;
						animDirection = "commanderview";
					};
					class VisualSensorComponent: SensorTemplateVisual
					{
						class AirTarget
						{
							minRange = 50;
							maxRange = 4000;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = 1;
						};
						class GroundTarget
						{
							minRange = 50;
							maxRange = 3000;
							objectDistanceLimitCoef = 1;
							viewDistanceLimitCoef = 1;
						};
						maxTrackableSpeed = 75;
						angleRangeHorizontal = 240;
						angleRangeVertical = 110;
						aimDown = 1;
						animDirection = "commanderview";
					};
					class ActiveRadarSensorComponent: SensorTemplateActiveRadar
					{
						class AirTarget
						{
							minRange = 7000;
							maxRange = 7000;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = -1;
						};
						class GroundTarget
						{
							minRange = 4000;
							maxRange = 4000;
							objectDistanceLimitCoef = -1;
							viewDistanceLimitCoef = -1;
						};
						angleRangeHorizontal = 240;
						angleRangeVertical = 110;
						groundNoiseDistanceCoef = -1;
						maxGroundNoiseDistance = -1;
						minSpeedThreshold = 0;
						maxSpeedThreshold = 0;
						aimDown = 35;
					};
					class DataLinkSensorComponent: SensorTemplateDataLink{};
					class PassiveRadarSensorComponent: SensorTemplatePassiveRadar{};
					class LaserSensorComponent: SensorTemplateLaser
					{
						angleRangeHorizontal = 360;
						angleRangeVertical = 120;
						aimDown = 30;
					};
					class NVSensorComponent: SensorTemplateNV
					{
						angleRangeHorizontal = 360;
						angleRangeVertical = 120;
						aimDown = 30;
					};
				};
			};
			class VehicleSystemsDisplayManagerComponentLeft: VehicleSystemsTemplateLeftPilot{};
			class VehicleSystemsDisplayManagerComponentRight: VehicleSystemsTemplateRightPilot{};
		};
	};
	class RHS_MELB_MH6M: RHS_MELB_base
	{
		ace_fastroping_enabled = 2;
		ace_fastroping_friesType = "ACE_friesAnchorBar";
		ace_fastroping_friesAttachmentPoint[] = {0.026611, 0.821605, -0.107002};
		ace_fastroping_onCut = "RS_MH6V3_fnc_onRopesCut";
		ace_fastroping_onPrepare = "ace_fastroping_fnc_onPrepareCommon";
		ace_fastroping_ropeOrigins[] =
		{
			{-1.23242, 0.794033, -0.0076561},
			{1.26709, 0.794001, -0.00635719}
		};
		class hct_cargo
		{
			class interaction
			{
				class RS_MH6V3_friesNotPrepared
				{
					condition = "_this call RS_MH6V3_fnc_canPrepareFRIES";
					class prepareFRIESLeft
					{
						positionType = "coordinates";
						position[] = {-1.1665, 0.796253, -0.108951};
						buttonDown = "_this call RS_MH6V3_fnc_prepareFRIES";
						label = "Grab Ropes & Attach to FRIES";
						radius = 0.3;
					};
					class prepareFRIESRight: prepareFRIESLeft
					{
						position[] = {1.1333, 0.792804, -0.107751};
					};
				};
				class RS_MH6V3_friesPrepared
				{
					condition = "_this call RS_MH6V3_fnc_canShowDeployRopes";
					class deployRopesLeft
					{
						positionType = "coordinates";
						position[] = {-1.1665, 0.796253, -0.108951};
						buttonDown = "_this call RS_MH6V3_fnc_deployRopes";
						label = "Deploy Fast Ropes";
						radius = 0.3;
					};
					class deployRopesRight: deployRopesLeft
					{
						position[] = {1.1333, 0.792804, -0.107751};
					};
				};
				class RS_MH6V3_ropesDeployed
				{
					condition = "_this call RS_MH6V3_fnc_canShowFastRope";
					class fastRopeLeft
					{
						positionType = "coordinates";
						position[] = {-1.23926, 0.791841, -0.109039};
						buttonDown = "_this call RS_MH6V3_fnc_fastRope";
						label = "Fast Rope";
						radius = 0.3;
					};
					class fastRopeRight: fastRopeLeft
					{
						position[] = {1.35791, 0.775916, -0.107684};
					};
				};
			};
		};
	};
	class RHS_MELB_AH6M: RHS_MELB_base
	{
		editorPreview = "rhsusf\addons\rhsusf_editorPreviews\data\rhs_MELB_AH6M.paa";
		scope = 2;
		forceInGarage = 1;
		author = "$STR_RHSUSF_AUTHOR_FULL";
		dlc = "RHS_USAF";
		picture = "rhsusf\addons\rhsusf_melb\Data\ui\melb_ah_6m_ca.paa";
		icon = "rhsusf\addons\rhsusf_melb\Data\ui\map_melb_ah_6m_l_ca.paa";
		displayName = "AH-6M Little Bird 1TRP";
		slingLoadMaxCargoMass = 0;
		fuelCapacity = 436;
		fuelConsumptionRate = 0.08;
		transportSoldier = 1;
		cargoProxyIndexes[] = {10};
		hideWeaponsCargo = 0;
		ejectDeadCargo = 1;
		cargoGetInAction[] = {"MELB_L_Rack_in"};
		cargoAction[] = {"MELB_L_Rack"};
		memoryPointsGetInCargo[] = {"pos rack"};
		memoryPointsGetInCargoDir[] = {"pos rack dir"};
		memoryPointsGetInCargoPrecise[] = {"pos rack"};
		usePreciseGetInAction = 1;
		availableForSupportTypes[] = {"CAS_Heli"};
		weapons[] = {"Laserdesignator_mounted","rhs_weap_MASTERSAFE","rhsusf_weap_LWIRCM"};
		magazines[] = {"Laserbatteries","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM","rhsusf_mag_LWIRCM"};
		hiddenSelections[] = {"camo1","d_SN","crosshair"};
		hiddenSelectionsTextures[] = {"rhsusf\addons\rhsusf_melb\data\melb_ext_co.paa","rhsusf\addons\rhsusf_melb\data\decals\SN\blank_ca.paa","\rhsusf\addons\rhsusf_melb\Data\optics\melb_crosshair_dot_ca.paa"};
		threat[] = {0.6,0.4,0.1};
		cost = 1000000;
		class Turrets: Turrets
		{
			class CopilotTurret: CopilotTurret{};
		};
		class AnimationSources: AnimationSources
		{
			class Addcrosshair
			{
				source = "user";
				animPeriod = 1;
				initPhase = 1;
			};
			class Addgunrack
			{
				source = "user";
				animPeriod = 1;
				initPhase = 1;
			};
			class Addfueltank
			{
				source = "user";
				animPeriod = 1;
				initPhase = 1;
			};
			class ExtLongL
			{
				source = "user";
				animPeriod = 1e-05;
				initPhase = 0;
			};
			class ExtLongR
			{
				source = "user";
				animPeriod = 1e-05;
				initPhase = 0;
			};
		};
		class Attributes: Attributes
		{
			class rhs_MELB_TailNumber: rhs_MELB_TailNumber{};
			class rhs_MELB_SGDM: rhs_MELB_SGDM{};
			class rhs_MELB_SN_Nose: rhs_MELB_SN_Nose{};
			class rhs_MELB_clan: rhs_MELB_clan{};
			class MELB_ToggleBoy: MELB_ToggleBoy{};
			class rhs_ExtLongL
			{
				displayName = "Extend left pylon";
				tooltip = "Extended weapon pylon on the port side \nSome clipping occurs with GAU-19";
				property = "ExtLongL";
				control = "CheckboxNumber";
				expression = "_this animateSource ['ExtLongL',_value,true]";
				defaultValue = "0";
			};
			class rhs_ExtLongR
			{
				displayName = "Extend right pylon";
				tooltip = "Extended weapon pylon on the starboard side";
				property = "ExtLongR";
				control = "CheckboxNumber";
				expression = "_this animateSource ['ExtLongR',_value,true]";
				defaultValue = "0";
			};
		};
		class UserActions: UserActions
		{
			class RS_MH6V3_HideCrosshair
			{
				displayName = "<t color='#7fd8ff'>Hide Crosshair</t>";
				onlyforplayer = 1;
				position = "doplnovani";
				radius = 2;
				condition = "(((call rhsusf_fnc_findPlayer)==driver this) or ((call rhsusf_fnc_findPlayer)==gunner this)) && {(this animationSourcePhase 'Addcrosshair') >= 0.5}";
				statement = "[this, false] call RS_MH6V3_fnc_setCrosshairVisible";
				showWindow = 0;
				priority = 9.7;
			};
			class RS_MH6V3_ShowCrosshair: RS_MH6V3_HideCrosshair
			{
				displayName = "<t color='#7fd8ff'>Show Crosshair</t>";
				condition = "(((call rhsusf_fnc_findPlayer)==driver this) or ((call rhsusf_fnc_findPlayer)==gunner this)) && {(this animationSourcePhase 'Addcrosshair') < 0.5}";
				statement = "[this, true] call RS_MH6V3_fnc_setCrosshairVisible";
			};
			class RS_MH6V3_CycleCrosshairTexture: RS_MH6V3_HideCrosshair
			{
				displayName = "<t color='#7fd8ff'>Cycle Crosshair</t>";
				condition = "((call rhsusf_fnc_findPlayer)==driver this) or ((call rhsusf_fnc_findPlayer)==gunner this)";
				statement = "[this] call RS_MH6V3_fnc_cycleCrosshairTexture";
				priority = 9.69;
			};
		};
		class Components: Components
		{
			class TransportPylonsComponent
			{
				UIPicture = "\rhsusf\addons\rhsusf_melb\data\loadouts\RHS_AH6M_EDEN_CA.paa";
				class pylons
				{
					class pylon1
					{
						hardpoints[] = {"RHS_HP_MELB","RHS_HP_MELB_L"};
						priority = 2;
						attachment = "rhs_mag_M151_7";
						maxweight = 1200;
						UIposition[] = {0.625,0.2};
						bay = -1;
						turret[] = {};
						hitpoint = "HitPylon1";
					};
					class pylon2: pylon1
					{
						hardpoints[] = {"RHS_HP_MELB_M134","RHS_HP_MELB"};
						UIposition[] = {0.562,0.3};
						priority = 1;
						attachment = "RS_MH6V3_mag_m134_pylon_3000";
						turret[] = {};
						hitpoint = "HitPylon2";
					};
					class pylon3: pylon2
					{
						UIposition[] = {0.103,0.3};
						mirroredMissilePos = 2;
						attachment = "RS_MH6V3_mag_m134_pylon_3000";
						turret[] = {};
						hitpoint = "HitPylon3";
					};
					class pylon4: pylon1
					{
						hardpoints[] = {"RHS_HP_MELB","RHS_HP_MELB_R"};
						UIposition[] = {0.04,0.2};
						mirroredMissilePos = 1;
						turret[] = {};
						hitpoint = "HitPylon4";
					};
				};
				class Presets
				{
					class Light
					{
						attachment[] = {"rhs_mag_M151_7","RS_MH6V3_mag_m134_pylon_3000","RS_MH6V3_mag_m134_pylon_3000","rhs_mag_M151_7"};
						displayname = "Light";
					};
					class Medium
					{
						attachment[] = {"rhsusf_mag_gau19_melb_left","","","rhs_mag_M151_19"};
						displayname = "Medium";
					};
					class HEAT
					{
						attachment[] = {"RS_MH6V3_mag_Hydra_HEAT_7","RS_MH6V3_mag_m134_pylon_3000","RS_MH6V3_mag_m134_pylon_3000","RS_MH6V3_mag_Hydra_HEAT_7"};
						displayname = "HEAT";
					};
					class Smoke
					{
						attachment[] = {"RS_MH6V3_mag_Hydra_M274_7","RS_MH6V3_mag_m134_pylon_3000","RS_MH6V3_mag_m134_pylon_3000","RS_MH6V3_mag_Hydra_M274_7"};
						displayname = "Smoke";
					};
					class Heavy
					{
						attachment[] = {"rhsusf_mag_gau19_melb_left","","","rhs_mag_AGM114K_2"};
						displayname = "Heavy";
					};
				};
			};
		};
	};
};
