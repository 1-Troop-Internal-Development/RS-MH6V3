[h1]MH-6V3 Little Bird[/h1][hr][/hr]
[code]A gameplay-focused AH-6M Little Bird enhancement for Arma 3.

Little Bird V3 is a re-scripted continuation of Little Bird 2.0 by Vasquez. It expands the RHS MELB AH-6M with improved crew controls, weapon options, IZLID/IR systems, ACRE tools, Hydra ripple fire, logistics support, and mission-friendly customization.[/code]

[h1]!! Vanilla (Without ACE) Is In Beta !![/h1]

[h2]Based On Little Bird V2[/h2]
[code]
Little Bird V2 Workshop:
https://steamcommunity.com/sharedfiles/filedetails/?id=2787531417
[/code]

[hr][/hr]
[h2]Aircraft Features[/h2]
[list]
[*]Custom AH-6M Little Bird configuration.
[*]Pilot/co-pilot pylon ownership synchronization.
[*]Updated default pylons and editor options.
[*]Livery customization.
[*]ACE interaction support.
[*]Vanilla scroll-wheel fallback support.
[*]Joystick-friendly UserActions.
[/list]

[hr][/hr]
[h2]IZLID & IR Illumination[/h2]
[list]
[*]Fixed forward IZLID.
[*]Handheld IZLID directed by pilot view.
[*]Seat-specific Handheld IZLID origins and limits.
[*]Wide, narrow, and dynamic IR illuminator modes.
[*]Adjustable client-side IR illuminator brightness.
[*]Independent fixed and Handheld IZLID behavior.
[/list]

[code]
IR Illuminator Brightness - Addon Option
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
[*]Crew radio management UI.
[*]View and tune inventory or rack radios.
[*]ACRE actions are hidden when ACRE is unavailable.
[/list]

[code]
ACRE Status UI - Addon Option
ACRE Status UI Delayed Hide - Addon Option
ACRE Status UI X/Y Position - Addon Options
Cycle Selected ACRE Radio - Keybind / UserAction
Increase/Decrease Radio Volume - Keybind / UserAction
[/code]

[hr][/hr]
[h2]Weapons & Pylons[/h2]
[list]
[*]Dedicated RS M134 pylon weapon and magazine.
[*]RS M134 default AH-6M loadout support.
[*]LO and HI fire-rate modes.
[*]GAU-19 support.
[*]M247 HEAT Hydra support.
[*]7-round M260 and 19-round M261 HEAT magazines.
[*]Default and HEAT pylon presets.
[/list]

[code]
RS M134 Pylon Title - M134D-H (RS)
RS M134 Short Title - RS M134
[/code]

[h2]Weapon Vibration[/h2]
[list]
[*]Gun vibration for RS M134 and GAU-19.
[*]Stronger GAU-19 vibration.
[*]Aircraft vibration that can affect aim while firing.
[*]Rocket and missile launch impact vibration.
[*]Client addon option to enable or disable weapon vibration.
[/list]

[hr][/hr]
[h2]Hydra Rocket Ripple[/h2]
Quick Launch fires configured Hydra pylons without manually selecting rockets. The previously selected weapon is restored afterward.

[list]
[*]Single Pylon Priority mode.
[*]Cycling Sequence mode.
[*]Custom sequence support.
[*]Saved sequence required before Quick Launch fires.
[/list]

[code]
Example: Pylon 1 > Pylon 2 > Pylon 2 > Pylon 3

Quick Launch Hydra - Keybind / UserAction
Hydra Rocket Ripple Configuration - Keybind / UserAction / ACE
Toggle Hydra Ripple Master Arm - Keybind / UserAction
[/code]

[hr][/hr]
[h2]Logistics & Service[/h2]
[list]
[*]Aircraft service actions.
[*]Fuel drain controls.
[*]Livery tools.
[*]Package install/removal.
[*]Rotor assembly/disassembly.
[*]Camera reset.
[*]C-130 positioning support when available.
[*]MH-6 FRIES fast-rope support through Hatchet-style interactions.
[/list]

[hr][/hr]
[h2]FRIES Fast Rope[/h2]
[list]
[*]MH-6 only.
[*]Grab Ropes & Attach to FRIES interaction.
[*]Deploy Fast Ropes interaction.
[*]Left and right Fast Rope interactions.
[*]Ropes stow when cut.
[/list]

[hr][/hr]
[h2]ACE Interaction[/h2]
[list]
[*]IZLID and illuminator controls.
[*]Hydra ripple configuration.
[*]ACRE Radio Management when ACRE is loaded.
[*]Aircraft livery tools.
[*]Pylon and aircraft service actions.
[*]FRIES prepare, deploy, and fast-rope interactions when fast roping is available.
[/list]

[h2]Vanilla Interaction[/h2]
[list]
[*]Scroll-wheel Logistics Management when ACE interaction is unavailable.
[*]Logistics Management UI.
[*]Hydra Sequence UI from the AH-6 pilot slot.
[*]Separate crew-slot Reset Cameras action.
[/list]

[hr][/hr]
[h2]Addon Options[/h2]
[h3]Camera & Effects[/h3]
[list]
[*]Aircraft Weapon Vibration.
[/list]

[h3]IZLID & Illumination[/h3]
[list]
[*]IR Illuminator Brightness.
[/list]

[h3]ACRE Status UI[/h3]
[list]
[*]ACRE Status UI.
[*]ACRE Status UI Delayed Hide.
[*]ACRE Status UI X/Y Position.
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

[hr][/hr]
[h2]Mission Maker Notes[/h2]
[list]
[*]Default AH-6M loadout uses the RS M134.
[*]HEAT preset uses RS M134 guns and M247 HEAT Hydras.
[*]Hydra Quick Launch requires a saved ripple sequence.
[*]Weapon vibration is client-side.
[*]FRIES fast rope applies to the MH-6 only.
[*]ACRE features require ACRE.
[*]ACE interaction features require ACE.
[/list]

[hr][/hr]
[h2]Dependencies[/h2]
[list]
[*]CBA.
[*]ACE for ACE interaction features.
[*]ACE Fastroping for FRIES fast-rope actions.
[*]ACRE for ACRE radio features.
[*]RHS USAF / RHS MELB content.
[/list]

[h2]Disclaimer[/h2]
Gameplay-focused crew workflow and aircraft enhancement. Not a full avionics simulation.

[hr][/hr]
[h1]Support Discord[/h1]
https://discord.gg/HcwP6daZ9G

[h1]License[/h1]
Reupload in private packs if you wish. Do not publicly reupload the mod as a copy.

[h1]Unit[/h1]
https://1troop.net
