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

class CDoomTimer {
	float duration;
	boolean hasFinished;

	CDoomTimer() {
		this.duration = 0;
		this.hasFinished = false;
	}

	void setTime(float seconds) {
		this.duration = seconds;
		this.hasFinished = false;
	}

	void resume() {
		this.hasFinished = false;
	}

	void pause() {
		this.hasFinished = true;
	}

	void run() {
		if (!this.hasFinished) {
			this.hasFinished = !(this.duration > 0);

			if (!this.hasFinished) {
				this.duration = this.duration - 0.5;
				this.hasFinished = false;
			}
		}
	}

	void stop() {
		this.duration = 0;
		this.hasFinished = true;
	}
}
