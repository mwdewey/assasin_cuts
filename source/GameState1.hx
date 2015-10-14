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
	var wallGroup:FlxGroup;
	var floorList:List<StaticObject>;
	var enemyGroup:FlxGroup;
	var townPeopleGroup:FlxGroup;
	var projectileGroup:FlxGroup;
	var doorGroup:FlxGroup;
	var doorCollidableGroup:FlxGroup;
	var sceneGroup:FlxGroup;
	
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
		hairDresser.y = FlxG.height-hairDresser.height;
		hairDresser.x = 32;
		
		ui = new UI();
		// set time to play
		ui.setTimer(600);
		
		// prevScore is score at start of level
		// when reset occures, score is then prev score
		Reg.prevScore = Reg.score;
		
		floorGroup = new FlxGroup();
		wallGroup = new FlxGroup();
		doorGroup = new FlxGroup();
		doorCollidableGroup = new FlxGroup();
		townPeopleGroup = new FlxGroup();
		sceneGroup = new FlxGroup();
		
		for (i in 0...100) floorGroup.add(new StaticObject(i * 32, FlxG.height, AssetPaths.dirt_0__png));
		for (i in 0...21)  wallGroup.add(new StaticObject(0, -i * 32 + FlxG.height - 32, AssetPaths.wall_0__png));
		for (i in 0...12) floorGroup.add(new StaticObject(i * 32, FlxG.height - 32 * 7, AssetPaths.wall_0__png));
		for (i in 0...12) floorGroup.add(new StaticObject(i * 32+32*18, FlxG.height - 32 * 7, AssetPaths.wall_0__png));
		for (i in 0...12) floorGroup.add(new StaticObject(i * 32, FlxG.height - 32 * 14, AssetPaths.wall_0__png));
		for (i in 0...30) floorGroup.add(new StaticObject(i * 32, FlxG.height - 32 * 21, AssetPaths.wall_0__png));
		for (i in 0...2)  wallGroup.add(new StaticObject(32*11, i * 32 + FlxG.height -128 - 64, AssetPaths.wall_0__png));
		
		var d:Door = new Door(32*10, FlxG.height - 128); doorGroup.add(d); doorCollidableGroup.add(d.hitBox);
		
		//for (i in 0...25) townPeopleGroup.add((new TownPerson(i * 400-200, 500 - 192)).spriteGroup);
		
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