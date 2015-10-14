package;

/**
 * ...
 * @author ...
 */
class SoundFactory
{
	static var sound:Sound;
	
	public static function getInstance():Sound{
		if (sound == null) {
			sound = new Sound();
		}
		return sound;
	}
}