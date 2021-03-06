# CHANGELOG for CamDoom

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.4] - 2022-06-01

### Changed

- Adjustment in the trigger parameters of the player actions

## [2.0.3] - 2022-06-01

### Changed

- Adjustment in the trigger parameters of the player actions

## [2.0.2] - 2022-06-01

### Fixed

- Hide key controls

## [2.0.1] - 2022-06-01

### Fixed

- Fix reset slayer position for pause menu
- Fix cross hair color update
- Fix face detection

## [2.0.0] - 2022-05-31

### Added

- Added Items into the map
- Added Enemies into the map

### Fixed

- Restore position when restarting the game

## [1.8.3] - 2022-05-31

### Fixed

- Fix enemy faced direction
- Fix game ending

## [1.8.2] - 2022-05-31

### Fixed

- Fix attack and die sprites for enemies
- Fix shield vest display

## [1.8.1] - 2022-05-31

### Added

- Include sprites for enemies

### Fixed

- Fix global sprites and animations to be private
- Fix stroke visualization at sprites

## [1.8.0] - 2022-05-31

### Added

- Item detection
- Aiming at enemy in range detection

### Fixed

- Collision detection
- Stairs detection

## [1.7.2] - 2022-05-30

### Added

- Include old implementation of 3D shapes for items

### Changed

- Include good display for items
- Provide item detector

### Fixed

- Improve bouncing but it is not still DOOM
- Fix go back movement for key control

## [1.7.1] - 2022-05-30

### Fixed

- Fix bouncing movement when slayer has stopped
- Increase velocity for forward movement

## [1.7.0] - 2022-05-30

### Added

- Face Detection with FaceOSC
- Controls with face detection

## [1.6.2] - 2022-05-30

### Fixed

- Fix textures for map

## [1.6.1] - 2022-05-30

### Added

- Include sounds for enemies
- Include support for health and shield items (not tested)

### Fixed

- Fix damage control for enemies
- Fix color for crosshair gun when enemy has been detected
- Reduce delay for shotgun

## [1.6.0] - 2022-05-30

### Added

- Include utilities to manage health, shield, and damage
- Include support for enemies and items

### Fixed

- Fix reload time for shotgun, now is not so fast!
- Fix spawnpoint position for slayer

## [1.5.5] - 2022-05-30

### Added

- Provide bouncing movement for slayer

### Fixed

- Reformat code for character

## [1.5.4] - 2022-05-29

### Fixed

- Fix slayer movement

## [1.5.3] - 2022-05-29

### Added

- Provide blood effect for slayer pain

### Fixed

- Fix text aligment at Death screen
- Fix slayer's position when user has exited but played again

## [1.5.2] - 2022-05-29

### Added

- Include animations for shooting
- Include pain and death sounds
- Provide menu when slayer is death
- Include white crosshair gun

### Fixed

- Fix sprite of shotgun when no shooting
- Fix sprite of shotgun when shooting
- Fix status GUI to be compatible with new camera
- Fix menus to be compatible with new camera

## [1.5.1] - 2022-05-29

### Fixed

- Fix Slayer movement

## [1.5.0] - 2022-05-28

### Changed

- Change QueasyCam for PeasyCam

## [1.4.1] - 2022-05-28

### Added

- Sound effect when selecting an option
- Sound effect when confirming an option
- Special sound effect when exiting game

### Fixed

- Settings with sound management at options
- Fix error at background menu when window size has been changed

## [1.4.0] - 2022-05-28

### Added

- Customize main properties of window
- Provide main menu and pause menu

## [1.3.1] - 2022-05-27

### Fixed

- Fixed stairs
- Fixed map collision

## [1.3.0] - 2022-05-27

### Added

- Add Map01 - Entryway
- Include collision files

## [1.2.0] - 2022-05-27

### Added

- Add a rectangle shape for 3D shapes
- Include map tool to define CamDoom maps
- Basic implementation for main engine of the game
- Operation for collisions for 3D models loaded with a file

### Changed

- Include collisions for cube and rectangle
- Character would be defined as a heroe or an enemy

## [1.1.0] - 2022-05-09

### Added

- Add an operation which check if a shape has collisions with a character
- Include generalization of a 3D shape and shaders
- Example for both generalization of a 3D shape and shaders
- Empty class for character to avoid compilation errors

## [1.0.0] - 2022-05-09

### Added

- Initial release with basic configuration

[1.0.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/4d200b08d6a17109b672b9193a49068f4c0a7a96
[1.1.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/f40e5bb8848e8538e8a3a9430eda03e48b0a9352
[1.2.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/d4e95c3cf46a959efe560396d6b12df44ab3d88d
[1.3.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/ef1bab59cda2a820bf9ea3d8b34d616c8df33094
[1.3.1]: https://github.com/HectorMartinAlvarez/CamDoom/tree/24eba18fe14190edd987d20922ed4bf514a290b5
[1.4.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/761511afcd788a0c4dbcb86a139c91c5b54990fb
[1.4.1]: https://github.com/HectorMartinAlvarez/CamDoom/tree/8cb7d98fd43348409c011feb82e9eb1fdb8f16ac
[1.5.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/27321b556e7985b3daa6f591324c5a7df2ab9cd4
[1.5.1]: https://github.com/HectorMartinAlvarez/CamDoom/tree/158f5198d4f9cbf17492cd1c89e7a42d88929ce1
[1.5.2]: https://github.com/HectorMartinAlvarez/CamDoom/tree/1f8025eed5b6e7f5ba0fad9fd6e5cd768d82417b
[1.5.3]: https://github.com/HectorMartinAlvarez/CamDoom/tree/d86b8af79930fab8a6a2bccf2a9dbae7c70cf371
[1.5.4]: https://github.com/HectorMartinAlvarez/CamDoom/tree/a7a908136bffa6cf9d8571d9b59f7b9166f67fcc
[1.5.5]: https://github.com/HectorMartinAlvarez/CamDoom/tree/711c7ac5083e3cf5428ad6821b95105abe78641d
[1.6.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/f9c31253ffa512fb84609e3fb500336ae9ce3e8b
[1.6.1]: https://github.com/HectorMartinAlvarez/CamDoom/tree/088f2b28a4b2890a69a90c185f8bdae2899df2c1
[1.6.2]: https://github.com/HectorMartinAlvarez/CamDoom/tree/6e4c65b6e567b915a220577f1738636119fb3e98
[1.7.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/241499d0c6e6ebf9ab8731f018f7a57951bcd613
[1.7.1]: https://github.com/HectorMartinAlvarez/CamDoom/tree/2f94af31ce98a7b7aac3281c9f095b34f7272b87
[1.7.2]: https://github.com/HectorMartinAlvarez/CamDoom/tree/c4c0004374d2c7bb32e2871d091df23ddd54c848
[1.8.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/c4c0004374d2c7bb32e2871d091df23ddd54c848
[1.8.1]: https://github.com/HectorMartinAlvarez/CamDoom/tree/132045cc4837ba9533d858999e8a5df35327c022
[1.8.2]: https://github.com/HectorMartinAlvarez/CamDoom/tree/3a8a37c24dcd0cd6be0b9bbca0ba008450f8ff7d
[1.8.3]: https://github.com/HectorMartinAlvarez/CamDoom/tree/76e23d8ed372badd04881ef6ab973a9ae441678d
[2.0.0]: https://github.com/HectorMartinAlvarez/CamDoom/tree/dbe844385b90e6fd0b53f765e52597fc98d81b11
[2.0.1]: https://github.com/HectorMartinAlvarez/CamDoom/tree/d0353f130f30e9efa31690963ba9bc98c761ba32
[2.0.2]: https://github.com/HectorMartinAlvarez/CamDoom/tree/69b64e854d15a467dd8e66b550b9cefe32fc9b1e
[2.0.3]: https://github.com/HectorMartinAlvarez/CamDoom/tree/ee355a121886b7afd0ea33781ee7953749149fc1
[2.0.4]: https://github.com/HectorMartinAlvarez/CamDoom/tree/cc99a2afb9a85f6d3014cafaa61322def48e201d
