package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import openfl.Assets;
import flixel.FlxBasic;

using flixel.util.FlxSpriteUtil;

class GameState1 extends FlxState
	{
		
	var floorGroup:FlxGroup;
	var obsticalGroup:FlxGroup;
	var floorList:List<StaticObject>;
	var enemyGroup:FlxGroup;
	var townPeopleGroup:FlxGroup;
	var projectileGroup:FlxGroup;
	var doorGroup:FlxGroup;
	var doorCollidableGroup:FlxGroup;
	
	var tileMap:FlxTilemap;
		
	var hairDresser:HairDresser;
	var s1:StaticObject;
	var s2:StaticObject;
	var s3:StaticObject;
	var ogre:Ogre;
	var ui:UI;
	
	var tempSprite:FlxSprite;

	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
    {
        super.create();
		
		hairDresser = new HairDresser();
		ui = new UI();
		
		// set time to play
		ui.TIMER_LENGTH = 60;
		
		// prevScore is score at start of level
		Reg.prevScore = Reg.score;
		
		floorGroup = new FlxGroup();
		for (i in 0...100) floorGroup.add(new StaticObject(i * 64, FlxG.height - 64, "assets/images/GroundTile.png"));
		
		obsticalGroup = new FlxGroup();
		for (i in 0...25) obsticalGroup.add(new StaticObject(i * 400, 500, "assets/images/GroundTile.png"));
		
		tempSprite = new FlxSprite();
		tempSprite.loadGraphic("assets/images/Muro Sunset.png", false, 1024, 768);
		tempSprite.scrollFactor.set();
		
		enemyGroup = new FlxGroup();
		for (i in 0...25) {
			//var n_enemy:Enemy2 = new Enemy2(i * 400, 500 - 192);
			enemyGroup.add(new Enemy2(i * 400, 500 - 192).spriteGroup);
		}
		
		
		projectileGroup = new FlxGroup();
		
		doorGroup = new FlxGroup();
		doorCollidableGroup = new FlxGroup();
		for (i in 0...25) {
			var d:Door = new Door(i * 400, FlxG.height - 64 - 128);
			doorGroup.add(d);
			doorCollidableGroup.add(d.hitBox);
		}
		
		townPeopleGroup = new FlxGroup();
		for (i in 0...25) townPeopleGroup.add((new TownPerson(i * 400-200, 500 - 192)).spriteGroup);
		
 
		
		add(tempSprite);
		add(new Background());
		add(projectileGroup);
		add(floorGroup);
		add(obsticalGroup);
		add(enemyGroup);
		add(doorGroup);
		add(doorCollidableGroup);
		add(townPeopleGroup);
		
		//add(tileMap);
		
		add(hairDresser.spriteGroup);
		add(ui);
    }
	
	override public function update():Void
	{
		super.update();
		
		// check if on ground
		hairDresser.isOnGround = false;
		FlxG.overlap(hairDresser, obsticalGroup, goundDetect);
		FlxG.collide(hairDresser, floorGroup, goundDetect);
		//FlxG.overlap(hairDresser, tileMap,goundDetect);
		
		// move character
		FlxG.collide(hairDresser, obsticalGroup);
		FlxG.collide(hairDresser, floorGroup);
		//FlxG.collide(hairDresser, tileMap);
		
		// update ref
		Reg.ref_x = FlxG.camera.scroll.x;
		Reg.ref_y = FlxG.camera.scroll.y;
		
		// check overlapable obejcts
		FlxG.overlap(hairDresser, townPeopleGroup, townspersonDetect);
		FlxG.overlap(projectileGroup, enemyGroup, projectileDetect);
		FlxG.overlap(hairDresser,doorGroup,doorDetect);
		
		
		if (FlxG.keys.justPressed.R) FlxG.switchState(new RestartState(new CutScene1()));
		else if (FlxG.keys.justPressed.F5) FlxG.switchState(new CutScene2());

		
		if (hairDresser.charged) {
			if(hairDresser.face_left)
				projectileGroup.add(new Projectile(hairDresser.x,hairDresser.y,hairDresser.x-200,hairDresser.y));
			else
				projectileGroup.add(new Projectile(hairDresser.x,hairDresser.y,hairDresser.x+200,hairDresser.y));
		}
		
		// update score
		// if score changed, update with new value
		if (Reg.score != ui.hairCount) ui.updateHairCount(Reg.score);
		
		// if time runs out, switch to next stage
		if (ui.getRemainingTime() <= 0) {
			FlxG.camera.fade(FlxColor.BLACK, .5, false,
			function() {
			FlxG.switchState(new CutScene2());
			});
			
		}
		
	}
	
	// player and solid ground interaction
	// detects if player is on ground
	private function goundDetect(Object1:FlxObject, Object2:FlxObject):Void {
		hairDresser.isOnGround = true;
	}
	
	// player and townsperson interaction
	private function townspersonDetect(Object1:FlxObject, Object2:FlxObject):Void {
		if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.E) {
			if(Type.getClass(Object2) == TownPerson){
				var townPersonObject:TownPerson = cast Object2;
				if (!townPersonObject.isCut) townPersonObject.cutHair();
			}
		}
	}
	
	// player and enemy interaction --- melee
	
	// projectile and enemy interaction
	private function projectileDetect(Object1:FlxObject, Object2:FlxObject):Void {
		var p:Projectile = cast Object1;
		var e:Enemy1 = cast Object2;
		
		e.makeGraphic(64, 128, FlxColor.CRIMSON);
		
		p.destroy();
		
	}
	
	// hairDresser and door interaction
	private function doorDetect(Object1:FlxObject, Object2:FlxObject):Void {
		var p:HairDresser = cast Object1;
		var d:Door = cast Object2;
		
		// check collision with inner hitbox if door is closed
		if (!d.isOpen) FlxG.collide(p,d.hitBox);
		
		if (FlxG.keys.justPressed.SPACE) {
			if (d.isOpen) {
				d.closeDoor();
			}
			else d.openDoor();
		}
		
		
		
	}
	
}