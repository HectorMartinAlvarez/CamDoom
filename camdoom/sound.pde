// This file is part of CamDoom - https://github.com/HectorMartinAlvarez/CamDoom
//
// CamDoom is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// CamDoom is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with CamDoom. If not, see <http://www.gnu.org/licenses/>.

void increaseVolumeForMusic() {
	volumeMusic = volumeMusic < 1? volumeMusic + 0.2 : 0;
	if (volumeMusic > 1) volumeMusic = 1;

	adjustVolumeForMusic();
}

void increaseVolumeForEffects() {
	volumeEffects = volumeEffects < 1? volumeEffects + 0.2 : 0;
	if (volumeEffects > 1) volumeEffects = 1;

	adjustVolumeForEffects();
}

void adjustVolumeForMusic() {
	if (volumeMusic >= 0 && volumeMusic <= 1) {
		e1m1Music.amp(volumeMusic);
	}
}

void adjustVolumeForEffects() {
	if (volumeEffects >= 0 && volumeEffects <= 1) {
		confirmSound.amp(volumeEffects);
		selectSound.amp(volumeEffects);
		exitSound.amp(volumeEffects);
		shootSound.amp(volumeEffects);
		prepareAmmoSound.amp(volumeEffects);
		painSound.amp(volumeEffects);
		deathSound.amp(volumeEffects);
	}
}
