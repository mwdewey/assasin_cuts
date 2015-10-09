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
	var ogre:Ogre;

	public function new() 
	{
		super();
		
	}
	
	override public function create():Void
    {
        super.create();
		
		hairDresser = new HairDresser();
		add(hairDresser);
		
		ogre = new Ogre(FlxG.width/2, FlxG.height/2-100, hairDresser);
		add(ogre);
    }
	
	override public function update():Void
	{
		
		super.update();
		
	}
	
}