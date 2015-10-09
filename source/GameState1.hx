package;

import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

using flixel.util.FlxSpriteUtil;

class GameState1 extends FlxState
	{
	
	var hairDresser:HairDresser;
	var s1:StaticObject;
	var s2:StaticObject;
	var s3:StaticObject;

	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
    {
        super.create();
		
		hairDresser = new HairDresser();
		s1 = new StaticObject(300, 300, 100, 100);
		s2 = new StaticObject(300, 300, 100, 100);
		s3 = new StaticObject(300, 300, 100, 100);
		
		add(hairDresser);
		add(testSprite);
    }
	
	override public function update():Void
	{
		super.update();
		
		FlxG.collide(hairDresser,testSprite);
		
	}
	
}