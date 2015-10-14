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
import sys.io.File;

using flixel.util.FlxSpriteUtil;

class GameState1 extends FlxState
	{
	
	var floorGroup:FlxTilemap;
	var wallGroup:FlxTilemap;
	var townPeopleGroup:FlxGroup;
	var doorGroup:FlxGroup;
	var doorCollidableGroup:FlxGroup;
	var sceneGroup:FlxTilemap;
		
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
		
		FlxG.camera.setBounds(0, 0, 100 * 32, 100 * 32, false);
		
		hairDresser = new HairDresser();
		hairDresser.y = FlxG.height-hairDresser.height;
		hairDresser.x = 32;
		
		ui = new UI();
		// set time to play
		ui.setTimer(600);
		
		// prevScore is score at start of level
		// when reset occures, score is then prev score
		Reg.prevScore = Reg.score;
		
		floorGroup = new FlxTilemap();
		wallGroup = new FlxTilemap();
		doorGroup = new FlxGroup();
		doorCollidableGroup = new FlxGroup();
		townPeopleGroup = new FlxGroup();
		sceneGroup = new FlxTilemap();
		var d:Door;
		
		// floor
        floorGroup.loadMap(Assets.getText("assets/data/level1_floor.csv"), "assets/images/Levels/tilemap.png", 32, 32);
		
		// other collidable that is not floor
		wallGroup.loadMap(Assets.getText("assets/data/level1_obstacle.csv"), "assets/images/Levels/tilemap.png", 32, 32);
		
		// doors
		var refs:Array<PositionRef> =  TileMapLoader.load(100, 100, 32, 32, "assets/data/level1_door.csv");
		for (ref in refs) {
			if(ref.index != -1){
				d = new Door(ref.x,ref.y); 
				doorGroup.add(d); 
				doorCollidableGroup.add(d.hitBox);
			}
		}
		
		// townspeople
		refs =  TileMapLoader.load(100, 100, 32, 32, "assets/data/level1_people.csv");
		for (ref in refs) {
			if(ref.index != -1){
				townPeopleGroup.add((new TownPerson(ref.x, ref.y)).spriteGroup);
			}
		}
		
		// scenery
		sceneGroup.loadMap(Assets.getText("assets/data/level1_grass.csv"), "assets/images/Levels/tilemap.png", 32, 32);
		
		
		
		
		add(new Background());
		add(floorGroup);
		add(sceneGroup);
		add(wallGroup);
		add(doorGroup);
		add(doorCollidableGroup);
		add(townPeopleGroup);
		
		add(hairDresser.spriteGroup);
		add(ui);
    }
	
	override public function update():Void
	{
		super.update();
		
		// check if on ground
		hairDresser.isOnGround = false;
		FlxG.collide(hairDresser, floorGroup, goundDetect);
		
		// move character
		FlxG.collide(hairDresser, wallGroup);
		FlxG.collide(hairDresser, floorGroup);
		
		// check overlapable obejcts
		FlxG.overlap(hairDresser, townPeopleGroup, townspersonDetect);
		FlxG.overlap(hairDresser, doorGroup, doorDetect);
		
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
	// hairDresser and door interaction
	private function doorDetect(Object1:FlxObject, Object2:FlxObject):Void {
		var p:HairDresser = cast Object1;
		var d:Door = cast Object2;
		
		// check collision with inner hitbox if door is closed
		if (!d.isOpen) FlxG.collide(p,d.hitBox);
		
		// do door interaction
		if (FlxG.keys.justPressed.SPACE) {
			if (d.isOpen) {
				d.closeDoor();
			}
			else d.openDoor();
		}
		
		
		
	}
	
}