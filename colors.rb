require 'tk'

background = [
  {text: "Tiles", color: "4D564F"},
  {text: "Tile outline", color: "4D564F"},
  {text: "Background", color: "87948C"},
  {text: "?", color: "87948C"},
  {text: "?", color: "87948C"},
  {text: "Entity outline", color: "87948C"}
]
editor = [
  {text: "Regular grid lines", color: ""},
  {text: "?", color: ""},
  {text: "Fine grid lines", color: ""},
  {text: "Rectangular tile selection and crosshair", color: ""},
  {text: "Direction arrows for entity movement", color: ""},
  {text: "Door-switch connections", color: ""},
  {text: "Circular entity selection", color: ""},
  {text: "Cut mode outline", color: ""},
  {text: "Selected tile", color: ""},
  {text: "?", color: ""}
]
explosions = [
  {text: "Light thin particles", color: ""},
  {text: "Light dust", color: ""},
  {text: "Heavy dust", color: ""},
  {text: "Blood", color: ""}
]
fxDroneZap = [
  {text: "Ray 1", color: ""},
  {text: "Ray 2", color: ""}
]
fxFloorguardZap = [
  {text: "Ray 1", color: ""},
  {text: "Ray 2", color: ""}
]
fxNinja = [
  {text: "Jumping dust", color: ""},
  {text: "Falling dust", color: ""}
]
headbands = [
  {text: "Headband, standard", color: ""},
  {text: "?", color: ""},
  {text: "Headband, x type. \"Ready\" for player 1 in race mode.", color: ""},
  {text: "?", color: ""},
  {text: "Headband, y type", color: ""},
  {text: "?", color: ""},
  {text: "Headband, z type", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""}
]
menu = [
  {text: "General menu background.", color: ""},
  {text: "Leaderboard: Background. Editor: Side panel background (darkened later).", color: ""},
  {text: "Leaderboard: Other player's scores, your rank (see 14, 17). Also, race options text. Editor side panel: Unselected text.", color: ""},
  {text: "\"Color / Music\" and \"Social\" menu panels background.", color: ""},
  {text: "Main menu: Text, unselected (see 11). Help: Directional arrows.", color: ""},
  {text: "Uncompleted episode background (see 8). Profile: Uncompleted episode. Editor: Level name when not being played.", color: ""},
  {text: "?", color: ""},
  {text: "Completed episode background (see 6). Profile: Completed episode.", color: ""},
  {text: "Episode tabs background, unselected (see 13).", color: ""},
  {text: "Episode box outline (see 33).", color: ""},
  {text: "Main menu: Text, selected (see 5). Logo color. Cursor color.", color: ""},
  {text: "?", color: ""},
  {text: "Episode tabs background, selected (see 9).", color: ""},
  {text: "Leaderboards: Other player's names, your score (see 3, 17). Profile: Header text in side panel (see 15, 16).", color: ""},
  {text: "Profile: Numbers and some text (see 14, 16). Options: Unselected text, scrollbar triangles, upper dividing line. Credits: Regular text. Story: Upper dividing line.", color: ""},
  {text: "Profile: Remaining text and percentages (see 14, 15). Story: Text. Options: Selected text, little bar in scrollbar. Credits: Header text.", color: ""},
  {text: "Leaderboards: Other player's ranks, your name (see 3, 14). Also, messages that appear in the leaderboard (\"Server error\", \"Player 2 needed for score submission\", race options header, etc). Profile: Death count bars. Editor: Header text in side panel, messages when publishing, naming, etc.", color: ""},
  {text: "\"Color / Music\" and \"Social\" menus header text (see 30). The other text is the same, but more transparent.", color: ""},
  {text: "Replay inputs.", color: ""},
  {text: "Pause menu and editor panels text.", color: ""},
  {text: "Pause menu and editor panels background.", color: ""},
  {text: "Pause menu and editor panels outline.", color: ""},
  {text: "Outline for selected episode / level / panel. Separator between level name and info. Level loading spiral. Scroll bar and its triangle in level view and in the editor level list. Also \"Server error\" when loading userlevels.", color: ""},
  {text: "Uncompleted episode text (see 31).", color: ""},
  {text: "Bottom info text (key controls, \"paint tiles\" in editor, etc.).", color: ""},
  {text: "Leaderboard tabs background, unselected (see 27).", color: ""},
  {text: "Leaderboard tabs background, selected (see 26). Also leaderboard tabs text, selected (see 28).", color: ""},
  {text: "Leaderboard tabs text, unselected (see 27).", color: ""},
  {text: "Level name when playing.", color: ""},
  {text: "In \"Color / Music\" menu, the selected option; and in \"Social\" menu, the option name (see 18).", color: ""},
  {text: "Completed episode text (see 24).", color: ""},
  {text: "Tabs text (episodes and userlevels), unselected (see 34).", color: ""},
  {text: "Leaderboard entry selection box (see 10).", color: ""},
  {text: "Tabs text (episodes and userlevels), selected (see 32). Sub-tab text, selected (e.g. \"By Date\" in the userlevels) (see 38).", color: ""},
  {text: "Soundtrack name.", color: ""},
  {text: "Level information text (level name, author, success rate...). Also, upper big header text in every submenu.", color: ""},
  {text: "?", color: ""},
  {text: "Sub-tab text, unselected (e.g. \"By Date\" in the userlevels) (see 34).", color: ""},
  {text: "Text after level / episode completion (\"Your Global Rank\", level times, etc.).", color: ""},
  {text: "?", color: ""},
  {text: "Help menu header text.", color: ""},
  {text: "Help menu text.", color: ""}
]
timeBar = [
  {text: "Background of the bar with the time left.", color: ""},
  {text: "?", color: ""},
  {text: "Background of the rest of the bar.", color: ""},
  {text: "?", color: ""},
  {text: "Numbers.", color: ""},
  {text: "?", color: ""},
  {text: "Little triangle that separates both sections of the time bar.", color: ""},
  {text: "?", color: ""}
]
timeBarRace = [
  {text: "Text \"Player 2/3/4 press X\" in the menu.", color: ""},
  {text: "Text \"Player 2 ready\" in the menu.", color: ""},
  {text: "Text \"Player 1\" in the menu (the \"ready\" is controlled by #3 in headbands.tga).", color: ""},
  {text: "Text \"Player 3 ready\" in the menu.", color: ""},
  {text: "Text \"Player 4 ready\" in the menu.", color: ""},
  {text: "Player 2 timerbar outline.", color: ""},
  {text: "Player 2 timerbar background.", color: ""},
  {text: "Player 2 timerbar numbers.", color: ""},
  {text: "Player 3 timerbar outline.", color: ""},
  {text: "Player 3 timerbar background.", color: ""},
  {text: "Player 3 timerbar numbers.", color: ""},
  {text: "Player 1 timerbar outline.", color: ""},
  {text: "Player 1 timerbar background.", color: ""},
  {text: "Player 1 timerbar numbers.", color: ""},
  {text: "Player 4 timerbar outline.", color: ""},
  {text: "Player 4 timerbar background.", color: ""},
  {text: "Player 4 timebar numbers.", color: ""}
]
ninja = [
  {text: "Ninja 1.", color: ""},
  {text: "Ninja 2.", color: ""},
  {text: "Ninja 3.", color: ""},
  {text: "Ninja 4.", color: ""}
]

entityMine = [
  {text: "Mine exterior.", color: ""},
  {text: "Mine interior.", color: ""},
  {text: "Toggle mine (untoggled).", color: ""},
  {text: "Toggle mine (toggling).", color: ""}
]
entityGold = [
  {text: "Gold interior.", color: ""},
  {text: "Gold exterior.", color: ""},
  {text: "Gold shine.", color: ""}
]
entityDoorExit = [
  {text: "Closed exit door interior.", color: ""},
  {text: "Closed exit door border.", color: ""},
  {text: "Opened exit door interior.", color: ""},
  {text: "Opened exit door details.", color: ""},
  {text: "Opened exit door interior after challenge.", color: ""},
  {text: "Opened exit door details after challenge.", color: ""},
  {text: "[!?] text in episode view.", color: ""},
  {text: "[!?] text in level view.", color: ""}
]
entityDoorExitSwitch = [
  {text: "Exit switch border (untoggled).", color: ""},
  {text: "Exit switch border (toggled).", color: ""},
  {text: "Exit switch center.", color: ""},
  {text: "Exit switch background (untoggled).", color: ""},
  {text: "Exit switch background (toggled).", color: ""}
]
entityDoorRegular = [
  {text: "Regular door.", color: ""}
]
entityDoorLocked = [
  {text: "Locked door bar.", color: ""},
  {text: "Locked door center.", color: ""},
  {text: "Locked door switch button (untoggled).", color: ""},
  {text: "Locked door switch button (toggled).", color: ""},
  {text: "Locked door switch border (untoggled).", color: ""},
  {text: "Locked door switch border (toggled).", color: ""},
  {text: "Locked door switch background (untoggled).", color: ""},
  {text: "Locked door switch background (toggled).", color: ""}
]
entityDoorTrap = [
  {text: "Trap door bar.", color: ""},
  {text: "Trap door bulges.", color: ""},
  {text: "?", color: ""},
  {text: "?", color: ""},
  {text: "Trap door switch border (untoggled).", color: ""},
  {text: "Trap door switch border (toggled).", color: ""},
  {text: "Trap door switch background (untoggled).", color: ""},
  {text: "Trap door switch background (toggled).", color: ""}
]
entityLaunchPad = [
  {text: "Launchpad big pad.", color: ""},
  {text: "Launchpad small pad.", color: ""}
]
entityOneWayPlatform = [
  {text: "Oneway platform long platform.", color: ""},
  {text: "Oneway platform short platform.", color: ""}
]
entityDroneChaingun = [
  {text: "Chaingun drone background.", color: ""},
  {text: "Chaingun drone border, chaingun bullets.", color: ""}
]
entityDroneLaser = [
  {text: "Laser drone interior, firing. Also, laser 1.", color: ""},
  {text: "Laser drone laser 2.", color: ""},
  {text: "Laser drone border.", color: ""},
  {text: "Laser drone aiming line.", color: ""}
]
entityDroneZap = [
  {text: "Zap drone and micro drone background.", color: ""},
  {text: "Zap drone and micro drone border.", color: ""}
]
entityDroneChaser = [
  {text: "Chaser drone background.", color: ""},
  {text: "Chaser drone border.", color: ""}
]
entityFloorGuard = [
  {text: "Floorguard main color.", color: ""},
  {text: "Floorguard eye.", color: ""}
]
entityBounceBlock = [
  {text: "Bounceblock interior.", color: ""},
  {text: "Bounceblock border.", color: ""}
]
entityRocket = [
  {text: "Rocket turret center.", color: ""},
  {text: "Rocket turret border.", color: ""},
  {text: "Rocket color.", color: ""},
  {text: "Rocket fumes.", color: ""}
]
entityTurret = [
  {text: "Gauss turret interior.", color: ""},
  {text: "Gauss turret border.", color: ""},
  {text: "Gauss turret aiming cross.", color: ""},
  {text: "Gauss turret bullet.", color: ""},
  {text: "Gauss turret squiggly lines.", color: ""}
]
entityThwomp = [
  {text: "Thwump border.", color: ""},
  {text: "Thwump interior.", color: ""},
  {text: "Thwump ray.", color: ""}
]
entityEvilNinja = [
  {text: "Evil ninja spawn.", color: ""},
  {text: "Evil ninja.", color: ""}
]
entityDualLaser = [
  {text: "Laser turrets turret.", color: ""},
  {text: "Laser turrets laser.", color: ""}
]
entityBoostPad = [
  {text: "Boost pad (inactive).", color: ""},
  {text: "Boost pad (active).", color: ""}
]
entityBat = [
  {text: "Deathball inner circle.", color: ""},
  {text: "Deathball middle circle.", color: ""},
  {text: "Deathball outter circle.", color: ""}
]
entityEyeBat = [
  {text: "Mini background.", color: ""},
  {text: "Mini eye.", color: ""}
]
entityShoveThwomp = [
  {text: "Shove thwump interior.", color: ""},
  {text: "Shove thwump ray.", color: ""},
  {text: "Shove thwump armor.", color: ""}
]

$objects = {
  'background' => background,
  'editor' => editor,
  'explosions' => explosions,
  'fxDroneZap' => fxDroneZap,
  'fxFloorguardZap' => fxFloorguardZap,
  'fxNinja' => fxNinja,
  'headbands' => headbands,
  'menu' => menu,
  'timerBar' => timeBar,
  'timeBarRace' => timeBarRace,
  'ninja' => ninja,
  'entityMine' => entityMine,
  'entityGold' => entityGold,
  'entityDoorExit' => entityDoorExit,
  'entityDoorExitSwitch' => entityDoorExitSwitch,
  'entityDoorRegular' => entityDoorRegular,
  'entityDoorLocked' => entityDoorLocked,
  'entityDoorTrap' => entityDoorTrap,
  'entityLaunchPad' => entityLaunchPad,
  'entityOneWayPlatform' => entityOneWayPlatform,
  'entityDroneChaingun' => entityDroneChaingun,
  'entityDroneLaser' => entityDroneLaser,
  'entityDroneZap' => entityDroneZap,
  'entityDroneChaser' => entityDroneChaser,
  'entityFloorGuard' => entityFloorGuard,
  'entityBounceBlock' => entityBounceBlock,
  'entityRocket' => entityRocket,
  'entityTurret' => entityTurret,
  'entityThwomp' => entityThwomp,
  'entityEvilNinja' => entityEvilNinja,
  'entityDualLaser' => entityDualLaser,
  'entityBoostPad' => entityBoostPad,
  'entityBat' => entityBat,
  'entityEyeBat' => entityEyeBat,
  'entityShoveThwomp' => entityShoveThwomp
}
