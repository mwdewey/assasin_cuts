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
import flixel.ui.FlxBar;

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
	var ui:UI;
	var barHealth:FlxBar;
	
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
		ui = new UI();
		add(ui);
		barHealth = new FlxBar(0,0,FlxBar.FILL_LEFT_TO_RIGHT, 250,25);
		barHealth.createGradientBar([0xEE000000, 0xEE0C0C0], [0xFF00FF00, 0xFFFFFF00, 0xFFFF0000], 1, 180, true, 0xFF000000);
		updateBarPos();
		barHealth.y = 400;
		barHealth.percent = 100;
		add(barHealth);
		
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
		
		updateBarPos();
		
		if (FlxG.keys.justPressed.E) {
			if(player.face_left)
				projectileGroup.add(new Projectile(player.x,player.y,player.x-200,player.y));
			else
				projectileGroup.add(new Projectile(player.x,player.y,player.x+200,player.y));
		}
		
	}
	
	public function updateBarPos() {
		barHealth.x = (ogre.x + ogre.width / 2) - (barHealth.width/2);
	}
	
	public function updateHealthBar() : Void{
		//barHealth.health = healthe;
		barHealth.percent = (ogre.HP / ogre.startHP) * 100;
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
			updateHealthBar();
		}
	}
	
	// projectile and enemy interaction
	private function projectileDetect(Object1:FlxObject, Object2:FlxObject):Void {
		var p:Projectile = cast Object1;
		var ogre:Ogre = cast Object2;
		
		ogre.takeDamage(p.damage);
		updateHealthBar();
		
		p.destroy();
		
	}
}