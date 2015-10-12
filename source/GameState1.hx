package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.tile.FlxTilemap;
import openfl.Assets;

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
		
		floorGroup = new FlxGroup();
		for (i in 0...100) floorGroup.add(new StaticObject(i * 64, FlxG.height - 64, "assets/images/GroundTile.png"));
		
		obsticalGroup = new FlxGroup();
		for (i in 0...25) obsticalGroup.add(new StaticObject(i * 400, 500, "assets/images/GroundTile.png"));
		
		tempSprite = new FlxSprite();
		tempSprite.loadGraphic("assets/images/Muro Sunset.png", false, 1024, 768);
		tempSprite.scrollFactor.set();
		
		enemyGroup = new FlxGroup();
		for (i in 0...25) enemyGroup.add(new Enemy1(i * 400, 500 - 192));
		
		projectileGroup = new FlxGroup();
		
		doorGroup = new FlxGroup();
		doorCollidableGroup = new FlxGroup();
		for (i in 0...25) {
			var d:Door = new Door(i * 400, FlxG.height - 64 - 128 );
			doorGroup.add(d);
			doorCollidableGroup.add(d.hitBox);
		}
		
		townPeopleGroup = new FlxGroup();
		for (i in 0...25) townPeopleGroup.add((new TownPerson(i * 400-200, 500 - 192)).spriteGroup);
		
		
		tileMap = new FlxTilemap();
        var mapData:String = Assets.getText("assets/data/Widebrook Stage..csv");
        var mapTilePath:String = "assets/images/Walls.png";
        tileMap.loadMap(mapData, mapTilePath, 64,64);
 
		
		add(tempSprite);
		add(new Background());
		/*add(floorGroup);
		add(obsticalGroup);
		add(enemyGroup);
		add(projectileGroup);
		add(doorGroup);
		add(doorCollidableGroup);
		add(townPeopleGroup);
		*/
		add(tileMap);
		
		add(hairDresser);
		add(ui);
    }
	
	override public function update():Void
	{
		//super.update();
		
		// check if on ground
		hairDresser.isOnGround = false;
		FlxG.overlap(hairDresser, obsticalGroup,goundDetect);
		FlxG.overlap(hairDresser, floorGroup, goundDetect);
		
		// move character
		//FlxG.collide(hairDresser, obsticalGroup);
		//FlxG.collide(hairDresser, floorGroup);
		FlxG.collide(hairDresser, tileMap);
		
		// update ref
		Reg.ref_x = FlxG.camera.scroll.x;
		Reg.ref_y = FlxG.camera.scroll.y;
		
		// check overlapable obejcts
		FlxG.overlap(hairDresser, enemyGroup, enemyDetect);
		FlxG.overlap(projectileGroup, enemyGroup, projectileDetect);
		FlxG.overlap(hairDresser,doorGroup,doorDetect);
		
		
		if (FlxG.keys.justPressed.R) FlxG.switchState(new RestartState(new CutScene1()));
		else if (FlxG.keys.justPressed.F5) FlxG.switchState(new CutScene2());

		
		if (FlxG.keys.justPressed.E) {
			if(hairDresser.face_left)
				projectileGroup.add(new Projectile(hairDresser.x,hairDresser.y,hairDresser.x-200,hairDresser.y));
			else
				projectileGroup.add(new Projectile(hairDresser.x,hairDresser.y,hairDresser.x+200,hairDresser.y));
		}
		
		super.update();
	}
	
	// player and solid ground interaction
	// detects if player is on ground
	private function goundDetect(Object1:FlxObject, Object2:FlxObject):Void {
		hairDresser.isOnGround = true;
	}
	
	// player and enemy interaction
	private function enemyDetect(Object1:FlxObject, Object2:FlxObject):Void {
		if(FlxG.keys.justPressed.F){
			var spriteObject:FlxSprite = cast Object2;
			
			spriteObject.makeGraphic(64,128, FlxColor.CRIMSON);
		}
	}
	
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