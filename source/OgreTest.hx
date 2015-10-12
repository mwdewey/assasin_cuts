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
import flixel.FlxObject;

/**
 * ...
 * @author robert
 */
class OgreTest extends FlxState 
{
	var player:HairDresser;
	var ogre:Ogre;
	var floor:FlxGroup;
	var projectileGroup:FlxGroup;
	
	public function new() 
	{
		super();
	}
	
	override public function create() {
		super.create();
		
		floor = new FlxGroup();
		for(i in 0...100) floor.add(new StaticObject(i*64, FlxG.height-64, "assets/images/GroundTile.png"));
		add(floor);
		player = new HairDresser();
		add(player);
		ogre = new Ogre(600, FlxG.height - 320, player);
		add(ogre);
		projectileGroup = new FlxGroup();
		add(projectileGroup);
	}
	
	override public function update() {
		super.update();
		
		// check if on ground
		player.isOnGround = false;
		FlxG.overlap(player, floor, goundDetect);
		
		FlxG.collide(player, floor);
		FlxG.collide(ogre, floor);
		
		// check overlapable obejcts
		FlxG.overlap(player, ogre, enemyDetect);
		FlxG.overlap(projectileGroup, ogre, projectileDetect);
		
		if (FlxG.keys.justPressed.E) {
			projectileGroup.add(new Projectile(player.x,player.y,player.x+200,player.y));
		}
		
	}
	
	// player and solid ground interaction
	// detects if player is on ground
	private function goundDetect(Object1:FlxObject, Object2:FlxObject):Void {
		player.isOnGround = true;
	}
	
	// player and enemy interaction
	private function enemyDetect(Object1:FlxObject, Object2:FlxObject):Void {
		if (FlxG.keys.justPressed.F) {
			var player:HairDresser = cast Object1;
			var ogre:Ogre = cast Object2;
			
			ogre.takeDamage(player.damage);
		}
	}
	
	// projectile and enemy interaction
	private function projectileDetect(Object1:FlxObject, Object2:FlxObject):Void {
		var p:Projectile = cast Object1;
		var ogre:Ogre = cast Object2;
		
		ogre.takeDamage(p.damage);
		
		p.destroy();
		
	}
}