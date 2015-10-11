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

using flixel.util.FlxSpriteUtil;

class GameState1 extends FlxState
	{
		
	var floorGroup:FlxGroup;
	var obsticalGroup:FlxGroup;
	var floorList:List<StaticObject>;
		
	var hairDresser:HairDresser;
	var s1:StaticObject;
	var s2:StaticObject;
	var s3:StaticObject;
	var ogre:Ogre;

	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
    {
        super.create();
		
		hairDresser = new HairDresser();
		
		floorGroup = new FlxGroup();
		for (i in 0...100) floorGroup.add(new StaticObject(i * 100, FlxG.height - 100, 100, 100));
		
		obsticalGroup = new FlxGroup();
		for (i in 0...25) obsticalGroup.add(new StaticObject(i * 400, 500, 64, 64));
		
		add(new Background());
		add(floorGroup);
		add(obsticalGroup);
		add(hairDresser);
    }
	
	override public function update():Void
	{
		super.update();
		
		//check if on ground
		hairDresser.isOnGround = false;
		FlxG.overlap(hairDresser, obsticalGroup,goundDetect);
		FlxG.overlap(hairDresser, floorGroup, goundDetect);
		
		trace(hairDresser.isOnGround);
		
		// move character
		FlxG.collide(hairDresser, obsticalGroup);
		FlxG.collide(hairDresser, floorGroup);
		
		// update ref
		Reg.ref_x = hairDresser.x;
		Reg.ref_y = hairDresser.y;
		
		if (FlxG.keys.justPressed.R) FlxG.switchState(new RestartState(new CutScene1()));
	}
	
	private function goundDetect(Object1:FlxObject, Object2:FlxObject):Void {
		hairDresser.isOnGround = true;
	}
	
}