package;

/**
 * ...
 * @author ...
 */
class SoundFactory
{
	var sound:Sound;
	
	public static function getInstance():Sound{
		if (this.sound == null) {
			this.sound = new Sound();
		}
		return this.sound;
	}
}