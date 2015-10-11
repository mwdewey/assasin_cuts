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
		if (player.isAttack && FlxG.collide(player, ogre)) ogre.takeDamage(player.damage);	
	}
}