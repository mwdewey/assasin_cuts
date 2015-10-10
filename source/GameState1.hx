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
		floorList = new List<StaticObject>();
		for (i in 0...100) floorList.add(new StaticObject(i * 100, FlxG.height - 100, 100, 100));
		for (obj in floorList) add(obj);
		
		obsticalGroup = new FlxGroup();
		for (i in 0...25) obsticalGroup.add(new StaticObject(i * 400, 500, 100, 100));
		
		//add(floorGroup);
		add(obsticalGroup);
		add(hairDresser);
		
		//ogre = new Ogre(FlxG.width/2, FlxG.height/2-100, hairDresser);
		//add(ogre);
    }
	
	override public function update():Void
	{
		super.update();
		
		for (obj in floorList) FlxG.collide(hairDresser, obj);
		
		FlxG.collide(hairDresser, obsticalGroup);
		//FlxG.collide(hairDresser, floorGroup);
	}
	
}