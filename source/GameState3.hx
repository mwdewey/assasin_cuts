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
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Robert
 */
class GameState3 extends FlxState 
{
	var player:HairDresser;
	var ogre:Ogre;
	var enemies:FlxGroup;
	//var enemies_1:FlxGroup;
	
	var floor:FlxGroup;
	
	var pProjectiles:FlxGroup;
	var eProjectiles:FlxGroup;
	
	var ui:UI;
	var barHealth:FlxBar;
	
	var background:FlxSprite;
	
	
	public function new() 
	{
		super();
	}
	
	override public function create() {
		super.create();
		
		background = new FlxSprite();
		background.loadGraphic("assets/images/Muro Sunset.png", false, 1024, 768);
		background.scrollFactor.set();
		add(background);
		
		floor = new FlxGroup();
		for(i in 0...20) floor.add(new StaticObject(i*64, FlxG.height-64, "assets/images/GroundTile.png"));
		add(floor);
		
		player = new HairDresser();
		add(player.spriteGroup);
		
		ogre = new Ogre(600, FlxG.height - 210, player);
		add(ogre);
		
		enemies = new FlxGroup();
		for (i in 0...2) enemies.add(new Enemy2(20+(i*400), FlxG.height - 160));
		add(enemies);
		
		/*enemies_1 = new FlxGroup();
		for (i in 0...2) enemies_1.add(new Enemy1(820+(i*400), FlxG.height - 160));
		add(enemies_1);*/
		
		pProjectiles = new FlxGroup();
		add(pProjectiles);
		
		eProjectiles = new FlxGroup();
		add(eProjectiles);
		
		ui = new UI();
		add(ui);
		
		barHealth = new FlxBar(0,0,FlxBar.FILL_LEFT_TO_RIGHT, 250,25);
		barHealth.createGradientBar([0xEE000000, 0xEE0C0C0], [0xFF00FF00, 0xFFFFFF00, 0xFFFF0000], 1, 180, true, 0xFF000000);
		updateBarPos();
		barHealth.y = ogre.y - 30;
		barHealth.percent = 100;
		add(barHealth);
		
		FlxG.sound.playMusic(AssetPaths.Level3__wav, 1, true);
	}

	override public function update() {
		
		if (FlxG.keys.justPressed.R) FlxG.switchState(new RestartState(new CutScene3()));
		else if (FlxG.keys.justPressed.F5) FlxG.switchState(new EndState());
		
		// check if on ground
		player.isOnGround = false;
		FlxG.overlap(player, floor, goundDetect);
		
		//check collisions
		FlxG.collide(player, floor);
		
		// Ogre attacks when it and player overlap
		if (ogre.isMove) FlxG.overlap(player, ogre, enemyDetect);
		//Ogre takes damage when overlaps with pProjectile
		FlxG.overlap(pProjectiles, ogre, pProjectileDetect);
		//player takes damage when overlaps with eProjectile
		FlxG.overlap(eProjectiles, player, eProjectileDetect);
		
		updateBarPos();
		ui.updateHealthBar(player.HP);
		
		//player's projectile attack
		if (player.charged) {
			if(player.face_left)
				pProjectiles.add(new Projectile(player.x,player.y,player.x-200,player.y));
			else
				pProjectiles.add(new Projectile(player.x,player.y,player.x+200,player.y));
		}
		
		//Enemy2's projectile attack
		for (obj in enemies) {
			
			var enemy:Enemy2 = cast obj;
			
			if (enemy.isThrowing) {
				eProjectiles.add(new Projectile2(enemy.x, enemy.y, player));
				enemy.isThrowing = false;
			}
		}
		
		//Enemy1's bullet attack
		/*for (obj in enemies_1) {
			
			var enemy_1:Enemy1 = cast obj;
			
			if (enemy_1.isFiring) {
				eProjectiles.add(new Bullet(enemy_1.x, enemy_1.y, player));
				enemy_1.isFiring = false;
			}
		}*/
		
		super.update();
	}
	
	public function updateBarPos() {
		barHealth.x = (ogre.x + ogre.width / 2) - (barHealth.width/2);
	}
	
	public function updateHealthBar() : Void{
		barHealth.health = ogre.HP;
		barHealth.percent = (ogre.HP / ogre.startHP) * 100;
	}
	
	// player and solid ground interaction
	// detects if player is on ground
	private function goundDetect(Object1:FlxObject, Object2:FlxObject):Void {
		player.isOnGround = true;
	}
	
	// player and enemy interaction
	private function enemyDetect(Object1:FlxObject, Object2:FlxObject):Void {
		if (player.isAttack) {
			trace("yes?");
			ogre.takeDamage(player.damage);
			updateHealthBar();
			ogreDeath();
			player.isAttack = false;
		}
		ogre.startAttack();
	}
	
	// projectile and enemy interaction
	private function pProjectileDetect(Object1:FlxObject, Object2:FlxObject):Void {
		var p:Projectile = cast Object1;
		var ogre:Ogre = cast Object2;
		
		ogre.takeDamage(p.damage);
		updateHealthBar();
		ogreDeath();
		
		p.destroy();
	}
	
	// projectile and player interaction
	private function eProjectileDetect(Object1:FlxObject, Object2:FlxObject):Void {
		var p:Projectile2 = cast Object1;
		var player:HairDresser = cast Object2;
		
		player.takeDamage(p.damage);
		playerDeath();
		
		p.destroy();
	}
	
	//if this damage brings HP at or below zero, destroy it
	public function ogreDeath():Void {
		if (ogre.HP <= 0) {
			FlxSpriteUtil.fadeOut(ogre, 0.5, false, ogreDestroy);
			FlxSpriteUtil.fadeOut(barHealth, 0.5, false, barDestroy);
		}
	}
	
	public function playerDeath():Void {
		if (player.HP <= 0) {
			player.kill();
			
			FlxG.switchState(new RestartState(new CutScene3()));
		}
	}
	
	//destroy ogre
	public function ogreDestroy(t:FlxTween):Void {
		ogre.kill();
	}
	//destroy barHealth
	public function barDestroy(t:FlxTween):Void {
		barHealth.destroy();
	}
	
}