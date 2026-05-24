class CfgPatches
{
	class RS_MH6V3_Flechette
	{
		units[] = {};
		weapons[] = {"RS_MH6V3_weap_FFARLauncher_M255"};
		requiredVersion = 1.96;
		requiredAddons[] =
		{
			"RS_MH6V3",
			"rhsusf_c_airweapons",
			"rhsusf_c_melb"
		};
		magazines[] =
		{
			"RS_MH6V3_mag_M255_7_100m",
			"RS_MH6V3_mag_M255_7_300m",
			"RS_MH6V3_mag_M255_7_600m",
			"RS_MH6V3_mag_M255_7_900m",
			"RS_MH6V3_mag_M255_7_ADAPT",
			"RS_MH6V3_mag_M255_LD_7_100m",
			"RS_MH6V3_mag_M255_LD_7_300m",
			"RS_MH6V3_mag_M255_LD_7_600m",
			"RS_MH6V3_mag_M255_LD_7_900m",
			"RS_MH6V3_mag_M255_LD_7_ADAPT"
		};
	};
};

class CfgFunctions
{
	class RS_MH6V3_Flechette
	{
		class weapons
		{
			file = "\DEVGRU\RS_MH6V3_Flechette\functions\weapons";
			class handleM255Fired {};
			class spawnM255DispersionSmoke {};
		};
	};
};

class CfgCloudlets
{
	class Default;
	class RS_MH6V3_M255_OrangePuff: Default
	{
		interval = 0.0025;
		circleRadius = 0;
		circleVelocity[] = {0,0,0};
		particleShape = "\A3\data_f\ParticleEffects\Universal\Universal";
		particleFSNtieth = 16;
		particleFSIndex = 7;
		particleFSFrameCount = 48;
		particleFSLoop = 0;
		angleVar = 1;
		animationName = "";
		particleType = "Billboard";
		timerPeriod = 1;
		lifeTime = 0.28;
		moveVelocity[] = {0,0,0};
		rotationVelocity = 1;
		weight = 1.275;
		volume = 1;
		rubbing = 0.08;
		size[] = {0.45,1.15,1.7};
		color[] = {{1,0.35,0.04,0.34},{1,0.28,0.02,0.2},{1,0.2,0.01,0}};
		animationSpeed[] = {1.5,0.5};
		randomDirectionPeriod = 0.08;
		randomDirectionIntensity = 0.08;
		onTimerScript = "";
		beforeDestroyScript = "";
		lifeTimeVar = 0.08;
		positionVar[] = {0.45,0.45,0.45};
		moveVelocityVar[] = {0.45,0.45,0.45};
		rotationVelocityVar = 4;
		sizeVar = 0.25;
		colorVar[] = {0.08,0.04,0.02,0.08};
		randomDirectionPeriodVar = 0.02;
		randomDirectionIntensityVar = 0.03;
	};
	class RS_MH6V3_M255_OrangeSparks: Default
	{
		interval = 0.001;
		circleRadius = 0;
		circleVelocity[] = {0,0,0};
		particleShape = "\A3\data_f\ParticleEffects\Universal\Universal";
		particleFSNtieth = 16;
		particleFSIndex = 13;
		particleFSFrameCount = 2;
		particleFSLoop = 0;
		angleVar = 1;
		animationName = "";
		particleType = "Billboard";
		timerPeriod = 1;
		lifeTime = 0.08;
		moveVelocity[] = {0,0,0};
		rotationVelocity = 1;
		weight = 1.275;
		volume = 1;
		rubbing = 0.01;
		size[] = {0.035,0.012};
		color[] = {{1,0.42,0.04,1},{1,0.18,0.01,0.55},{1,0.05,0,0}};
		animationSpeed[] = {1};
		randomDirectionPeriod = 0.01;
		randomDirectionIntensity = 0.12;
		onTimerScript = "";
		beforeDestroyScript = "";
		lifeTimeVar = 0.04;
		positionVar[] = {0.05,0.05,0.05};
		moveVelocityVar[] = {1.8,1.8,1.8};
		rotationVelocityVar = 8;
		sizeVar = 0.45;
		colorVar[] = {0.05,0.03,0.01,0.2};
		randomDirectionPeriodVar = 0.02;
		randomDirectionIntensityVar = 0.05;
	};
};

class RS_MH6V3_M255_FlechetteImpactEffect
{
	class OrangeSparks
	{
		simulation = "particles";
		type = "RS_MH6V3_M255_OrangeSparks";
		position[] = {0,0,0};
		intensity = 1;
		interval = 1;
		lifeTime = 0.04;
	};
};

class CfgAmmo
{
	class B_127x99_Ball;
	class rhs_ammo_Hydra_M151;
	class RS_MH6V3_ammo_M255_Flechette: B_127x99_Ball
	{
		hit = 10;
		indirectHit = 0;
		indirectHitRange = 0;
		caliber = 0.45;
		typicalSpeed = 1600;
		airFriction = -0.00005;
		timeToLive = 14;
		coefGravity = 0.15;
		tracerScale = 0;
		tracerStartTime = 0;
		tracerEndTime = 0;
		hitEffect = "RS_MH6V3_M255_FlechetteImpactEffect";
		hitEffects = "RS_MH6V3_M255_FlechetteImpactEffect";
		explosionEffects = "RS_MH6V3_M255_FlechetteImpactEffect";
		craterEffects = "";
		visibleFire = 4;
		audibleFire = 18;
		dangerRadiusBulletClose = 16;
		dangerRadiusHit = 24;
		suppressionRadiusBulletClose = 10;
		suppressionRadiusHit = 18;
	};
	class RS_MH6V3_ammo_M255_APERS_base: rhs_ammo_Hydra_M151
	{
		displayName = "Hydra M255 APERS";
		hit = 8;
		indirectHit = 3;
		indirectHitRange = 1.2;
		explosive = 0.15;
		cost = 400;
		aiAmmoUsageFlags = 448;
		visibleFire = 20;
		audibleFire = 90;
		dangerRadiusHit = 80;
		suppressionRadiusHit = 60;
		submunitionAmmo = "RS_MH6V3_ammo_M255_Flechette";
		submunitionConeType[] = {"randomcenter", 160};
		submunitionInitSpeed = 1500;
		triggerOnImpact = 1;
		deleteParentWhenTriggered = 1;
		explosionEffects = "";
		craterEffects = "";
	};
	class RS_MH6V3_ammo_M255_APERS_100m: RS_MH6V3_ammo_M255_APERS_base
	{
		triggerDistance = 100;
		submunitionConeAngle = 2.5;
	};
	class RS_MH6V3_ammo_M255_APERS_300m: RS_MH6V3_ammo_M255_APERS_base
	{
		triggerDistance = 300;
		submunitionConeAngle = 3.5;
	};
	class RS_MH6V3_ammo_M255_APERS_600m: RS_MH6V3_ammo_M255_APERS_base
	{
		triggerDistance = 600;
		submunitionConeAngle = 5;
	};
	class RS_MH6V3_ammo_M255_APERS_900m: RS_MH6V3_ammo_M255_APERS_base
	{
		triggerDistance = 900;
		submunitionConeAngle = 6.5;
	};
	class RS_MH6V3_ammo_M255_APERS_ADAPT: RS_MH6V3_ammo_M255_APERS_base
	{
		displayName = "Hydra M255 APERS Adaptive";
		triggerDistance = 99999;
		submunitionConeAngle = 4;
		RS_MH6V3_adaptiveFuze = 1;
		RS_MH6V3_adaptiveDistance = 75;
		RS_MH6V3_minTravelBeforeFuze = 125;
		RS_MH6V3_flechetteCount = 160;
	};
	class RS_MH6V3_ammo_M255_APERS_LD_base: RS_MH6V3_ammo_M255_APERS_base
	{
		displayName = "Hydra M255 APERS LD";
		submunitionConeType[] = {"randomcenter", 80};
	};
	class RS_MH6V3_ammo_M255_APERS_LD_100m: RS_MH6V3_ammo_M255_APERS_LD_base
	{
		triggerDistance = 100;
		submunitionConeAngle = 2.5;
	};
	class RS_MH6V3_ammo_M255_APERS_LD_300m: RS_MH6V3_ammo_M255_APERS_LD_base
	{
		triggerDistance = 300;
		submunitionConeAngle = 3.5;
	};
	class RS_MH6V3_ammo_M255_APERS_LD_600m: RS_MH6V3_ammo_M255_APERS_LD_base
	{
		triggerDistance = 600;
		submunitionConeAngle = 5;
	};
	class RS_MH6V3_ammo_M255_APERS_LD_900m: RS_MH6V3_ammo_M255_APERS_LD_base
	{
		triggerDistance = 900;
		submunitionConeAngle = 6.5;
	};
	class RS_MH6V3_ammo_M255_APERS_LD_ADAPT: RS_MH6V3_ammo_M255_APERS_LD_base
	{
		displayName = "Hydra M255 APERS LD Adaptive";
		triggerDistance = 99999;
		submunitionConeAngle = 4;
		RS_MH6V3_adaptiveFuze = 1;
		RS_MH6V3_adaptiveDistance = 75;
		RS_MH6V3_minTravelBeforeFuze = 125;
		RS_MH6V3_flechetteCount = 80;
	};
};

class CfgMagazines
{
	class rhs_mag_M151_7;
	class RS_MH6V3_mag_M255_7_100m: rhs_mag_M151_7
	{
		author = "DEVGRU";
		displayName = "Hydra M255 APERS HD - 7Rnd - Fuze 100m";
		displayNameShort = "M255 HD 100m";
		descriptionShort = "Hydra 70 M255 APERS high-density flechette rockets, 100 meter fuze";
		model = "\rhsusf\addons\rhsusf_airweapons\proxypylon\rhsusf_pylon_r_FFAR_7x";
		ammo = "RS_MH6V3_ammo_M255_APERS_100m";
		pylonWeapon = "RS_MH6V3_weap_FFARLauncher_M255";
		count = 7;
	};
	class RS_MH6V3_mag_M255_7_300m: RS_MH6V3_mag_M255_7_100m
	{
		displayName = "Hydra M255 APERS HD - 7Rnd - Fuze 300m";
		displayNameShort = "M255 HD 300m";
		descriptionShort = "Hydra 70 M255 APERS high-density flechette rockets, 300 meter fuze";
		ammo = "RS_MH6V3_ammo_M255_APERS_300m";
	};
	class RS_MH6V3_mag_M255_7_600m: RS_MH6V3_mag_M255_7_300m
	{
		displayName = "Hydra M255 APERS HD - 7Rnd - Fuze 600m";
		displayNameShort = "M255 HD 600m";
		descriptionShort = "Hydra 70 M255 APERS high-density flechette rockets, 600 meter fuze";
		ammo = "RS_MH6V3_ammo_M255_APERS_600m";
	};
	class RS_MH6V3_mag_M255_7_900m: RS_MH6V3_mag_M255_7_300m
	{
		displayName = "Hydra M255 APERS HD - 7Rnd - Fuze 900m";
		displayNameShort = "M255 HD 900m";
		descriptionShort = "Hydra 70 M255 APERS high-density flechette rockets, 900 meter fuze";
		ammo = "RS_MH6V3_ammo_M255_APERS_900m";
	};
	class RS_MH6V3_mag_M255_7_ADAPT: RS_MH6V3_mag_M255_7_100m
	{
		displayName = "Hydra M255 APERS HD - 7Rnd - Adaptive Fuze";
		displayNameShort = "M255 HD AUTO";
		descriptionShort = "Hydra 70 M255 APERS high-density flechette rockets, adaptive pre-impact fuze";
		ammo = "RS_MH6V3_ammo_M255_APERS_ADAPT";
	};
	class RS_MH6V3_mag_M255_LD_7_100m: RS_MH6V3_mag_M255_7_100m
	{
		displayName = "Hydra M255 APERS LD - 7Rnd - Fuze 100m";
		displayNameShort = "M255 LD 100m";
		descriptionShort = "Hydra 70 M255 APERS low-density flechette rockets, 100 meter fuze";
		ammo = "RS_MH6V3_ammo_M255_APERS_LD_100m";
	};
	class RS_MH6V3_mag_M255_LD_7_300m: RS_MH6V3_mag_M255_LD_7_100m
	{
		displayName = "Hydra M255 APERS LD - 7Rnd - Fuze 300m";
		displayNameShort = "M255 LD 300m";
		descriptionShort = "Hydra 70 M255 APERS low-density flechette rockets, 300 meter fuze";
		ammo = "RS_MH6V3_ammo_M255_APERS_LD_300m";
	};
	class RS_MH6V3_mag_M255_LD_7_600m: RS_MH6V3_mag_M255_LD_7_300m
	{
		displayName = "Hydra M255 APERS LD - 7Rnd - Fuze 600m";
		displayNameShort = "M255 LD 600m";
		descriptionShort = "Hydra 70 M255 APERS low-density flechette rockets, 600 meter fuze";
		ammo = "RS_MH6V3_ammo_M255_APERS_LD_600m";
	};
	class RS_MH6V3_mag_M255_LD_7_900m: RS_MH6V3_mag_M255_LD_7_300m
	{
		displayName = "Hydra M255 APERS LD - 7Rnd - Fuze 900m";
		displayNameShort = "M255 LD 900m";
		descriptionShort = "Hydra 70 M255 APERS low-density flechette rockets, 900 meter fuze";
		ammo = "RS_MH6V3_ammo_M255_APERS_LD_900m";
	};
	class RS_MH6V3_mag_M255_LD_7_ADAPT: RS_MH6V3_mag_M255_LD_7_100m
	{
		displayName = "Hydra M255 APERS LD - 7Rnd - Adaptive Fuze";
		displayNameShort = "M255 LD AUTO";
		descriptionShort = "Hydra 70 M255 APERS low-density flechette rockets, adaptive pre-impact fuze";
		ammo = "RS_MH6V3_ammo_M255_APERS_LD_ADAPT";
	};
};

class CfgWeapons
{
	class RocketPods;
	class rhs_weap_FFARLauncher: RocketPods;
	class RS_MH6V3_weap_FFARLauncher_M255: rhs_weap_FFARLauncher
	{
		author = "DEVGRU";
		displayName = "Hydra (M255 APERS)";
		magazines[] =
		{
			"RS_MH6V3_mag_M255_7_100m",
			"RS_MH6V3_mag_M255_7_300m",
			"RS_MH6V3_mag_M255_7_600m",
			"RS_MH6V3_mag_M255_7_900m",
			"RS_MH6V3_mag_M255_7_ADAPT",
			"RS_MH6V3_mag_M255_LD_7_100m",
			"RS_MH6V3_mag_M255_LD_7_300m",
			"RS_MH6V3_mag_M255_LD_7_600m",
			"RS_MH6V3_mag_M255_LD_7_900m",
			"RS_MH6V3_mag_M255_LD_7_ADAPT"
		};
		modes[] = {"Far_AI","Single","Two"};
		class Far_AI: Far_AI
		{
			minRange = 150;
			minRangeProbab = 0.65;
			midRange = 700;
			midRangeProbab = 0.85;
			maxRange = 1200;
			maxRangeProbab = 0.25;
		};
	};
};

class CfgVehicles
{
	class RHS_MELB_AH6M;
	class RHS_MELB_AH6M: RHS_MELB_AH6M
	{
		class EventHandlers
		{
			class RS_MH6V3_M255_EH
			{
				fired = "_this call RS_MH6V3_Flechette_fnc_handleM255Fired";
			};
		};
	};
};
