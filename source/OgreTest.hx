package;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;

/**
 * ...
 * @author robert
 */
class OgreTest extends FlxState 
{
	var player:HairDresser;
	var ogre:Ogre;
	var floor:StaticObject;
	
	public function new() 
	{
		super();
	}
	
	override public function create() {
		super.create();
		
		floor = new StaticObject(0, FlxG.height-50, FlxG.width*2, 50);
		add(floor);
		player = new HairDresser();
		add(player);
		ogre = new Ogre(600, FlxG.height - 307, player);
		add(ogre);
	}
	
	override public function update() {
		super.update();
		
		FlxG.collide(player, floor);
		FlxG.collide(ogre, floor);
		
		//damage manager
		if (FlxG.keys.justPressed.SHIFT) {
			//when facing left, attack is successful when there is collision on left side of player
			if (player.face_left && FlxG.collide(ogre, player) && player.centerX > ogre.centerX) {
				player.isAttack = true;
				ogre.takeDamage(player.damage);
			}
			//also successful if collision on other side when facing right
			else if (!player.face_left && FlxG.collide(ogre, player) && player.centerX < ogre.centerX) {
				player.isAttack = true;
				ogre.takeDamage(player.damage);
			}
			
		}
	}
}