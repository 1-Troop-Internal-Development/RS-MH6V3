[h1]MH-6V3 Little Bird[/h1][hr][/hr]
[code]A gameplay-focused AH-6M Little Bird enhancement for Arma 3.

Little Bird V3 is a re-scripted continuation of Little Bird V2. It expands the RHS MELB AH-6M with improved crew controls, weapon options, IZLID/IR systems, ACRE radio tools, configurable Hydra ripple fire, and mission-friendly customization.

The goal is practical crew usability and immersion rather than a full avionics simulation.[/code]

[hr][/hr][h2]Based on Little Bird V2[/h2]
[code]
Little Bird V2 Workshop:
https://steamcommunity.com/sharedfiles/filedetails/?id=2787531417
[/code]

[h2]Aircraft Features[/h2]
[list]
[*]Custom AH-6M Little Bird configuration.
[*]Improved pilot and co-pilot workflow.
[*]Pilot/co-pilot pylon ownership synchronization.
[*]Updated default pylons and expanded editor options.
[*]ACE interactions for aircraft systems.
[*]Livery and visual customization.
[*]Joystick-friendly CfgUserActions.
[/list]

[h2]IZLID & IR Illumination[/h2]
[list]
[*]Fixed forward IZLID marking laser.
[*]Handheld IZLID directed by the active pilot's view.
[*]Seat-specific Handheld IZLID origins and horizontal limits.
[*]Wide, narrow, and dynamic IR illuminator modes.
[*]Adjustable client-side IR illuminator brightness.
[*]Toggle, hold, and mode-cycle controls through keybinds, UserActions, and ACE.
[/list]

The fixed and Handheld IZLIDs operate independently. Activating the Handheld IZLID disables the fixed beam to prevent duplicate output.

[code]
IR Illuminator Brightness - Client Addon Option
Toggle IZLID - Keybind / UserAction / ACE
Hold IZLID - Keybind / UserAction
Cycle IZLID Mode - Keybind / UserAction / ACE
Toggle Handheld IZLID - Keybind / UserAction / ACE
[/code]

[h2]ACRE Radio Management[/h2]
[list]
[*]Pilot/co-pilot ACRE status overlay.
[*]Configurable overlay visibility, position, and delayed hide.
[*]Cycle selected aircraft radio.
[*]Increase or decrease selected radio volume.
[*]Seated ACE Radio Management interface.
[*]View and tune crew inventory or rack radios.
[*]Remote crew radio tune support.
[*]Automatic removal of ACRE actions when ACRE is unavailable.
[/list]

The status overlay responds to radio transmissions rather than aircraft intercom speech.

[code]
ACRE Status UI - Client Addon Option
ACRE Status UI Delayed Hide - Client Addon Option
ACRE Status UI X/Y Position - Client Addon Options
Cycle Selected ACRE Radio - Keybind / UserAction
Increase/Decrease Radio Volume - Keybind / UserAction
[/code]

[h2]M134D-H RS Variant[/h2]
[list]
[*]Dedicated RS pylon magazine and weapon class.
[*]RS M134 used by the default AH-6M loadout.
[*]Distinct LO and HI fire-rate modes.
[*]Higher sustained output than the original configuration.
[/list]

[code]
RS M134 Pylon Title - M134D-H (RS)
RS M134 Short Title - RS M134
LO - Lower output fire-rate mode
HI - Higher output fire-rate mode
[/code]

[h2]Aircraft Weapon Vibration[/h2]
[list]
[*]Interior vibration while the RS M134 or GAU-19 is firing.
[*]GAU-19 vibration is stronger than M134 vibration.
[*]Irregular circular camera movement slightly disrupts gun aim.
[*]Reduced custom camera shake when abrupt aircraft motion is detected.
[*]Heavy one-shot impact for rocket and missile launches.
[*]Missile launch impact is stronger than rocket launch impact.
[*]Client addon option to enable or disable all weapon vibration.
[*]Event-driven implementation runs only while an effect is active.
[/list]

[h2]Hydras & Pylon Options[/h2]
[list]
[*]Expanded Hydra and weapon pylon options.
[*]M247 HEAT Hydra for anti-vehicle use.
[*]7-round M260 and 19-round M261 HEAT magazines.
[*]Reduced HEAT fragmentation radius with higher direct-hit armor damage.
[*]Default and HEAT pylon presets using the RS M134.
[/list]

[h2]Hydra Rocket Ripple[/h2]
Quick Launch fires a configured Hydra pylon without requiring the pilot to manually select rockets. The previously selected weapon is restored afterward.

[h3]Single Pylon Priority[/h3]
Uses the first available configured pylon until empty, then advances to the next.

[h3]Cycling Sequence[/h3]
Advances one configured step per trigger pull. A pylon may appear multiple times to create a custom firing pattern.

[code]
Example: Pylon 1 > Pylon 2 > Pylon 2 > Pylon 3
[/code]

A saved sequence is required before Quick Launch can fire.

[code]
Quick Launch Hydra - Keybind / UserAction
Hydra Rocket Ripple Configuration - Keybind / UserAction / ACE
Toggle Hydra Ripple Master Arm - Keybind / UserAction
[/code]

[h2]ACE Features[/h2]
[list]
[*]IZLID and illuminator controls.
[*]Handheld IZLID control.
[*]Hydra ripple configuration.
[*]ACRE Radio Management when ACRE is loaded.
[*]Aircraft livery tools.
[*]Pylon and aircraft service actions.
[/list]

[h2]Addon Options[/h2]
[h3]Camera & Effects[/h3]
[list]
[*]Aircraft Weapon Vibration enabled/disabled.
[/list]

[h3]IZLID & Illumination[/h3]
[list]
[*]IR Illuminator Brightness.
[/list]

[h3]ACRE Status UI[/h3]
[list]
[*]ACRE Status UI enabled/disabled.
[*]ACRE Status UI delayed or instant hide.
[*]ACRE Status UI horizontal and vertical position.
[/list]

[h2]UserActions[/h2]
[list]
[*]Toggle IZLID.
[*]Hold IZLID.
[*]Cycle IZLID Mode.
[*]Toggle Handheld IZLID.
[*]Quick Launch Hydra.
[*]Hydra Rocket Ripple Configuration.
[*]Toggle Hydra Ripple Master Arm.
[*]Cycle Selected ACRE Radio.
[*]Increase/Decrease Selected ACRE Radio Volume.
[/list]

[code]
Addon / Keybind Group: [RS] MH-6V3
[/code]

[h2]Mission Maker Notes[/h2]
[list]
[*]The default AH-6M loadout uses the RS M134 variant.
[*]The HEAT preset uses RS M134 guns and M247 HEAT Hydras.
[*]Hydra Quick Launch requires a saved ripple sequence.
[*]ACRE actions validate aircraft and crew context.
[*]ACRE interactions are hidden when ACRE is not loaded.
[*]Weapon vibration is a client-side preference.
[/list]

[h2]Dependencies[/h2]
[list]
[*]CBA.
[*]ACE for ACE interaction features.
[*]ACRE for ACRE radio features.
[*]RHS USAF / RHS MELB content.
[/list]

[h2]Disclaimer[/h2]
This mod prioritizes gameplay usability, crew workflow, and immersion. It is not intended to be a complete avionics simulation.

[h1]Support Discord[/h1]
https://discord.gg/HcwP6daZ9G

[h1]License[/h1]
Reupload in private packs if you wish. Do not publicly reupload the mod as a copy.

[h1]Unit[/h1]
Looking for a realism Arma unit? Visit 1 Troop:

https://1troop.net
