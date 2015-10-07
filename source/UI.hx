package;

 import flixel.FlxBasic;
 import flixel.FlxG;
 import flixel.FlxSprite;
 import flixel.group.FlxTypedGroup;
 import flixel.text.FlxText;
 import flixel.util.FlxColor;
 import flixel.ui.FlxBar;
 using flixel.util.FlxSpriteUtil;

/**
 * @author Kevin
 */
class UI extends FlxTypedGroup<FlxSprite> 
{
	var sprHealth:FlxSprite;
	var barHealth:FlxBar;
	var sprTextBox:FlxSprite;
	var textTextBox:FlxText;

	public function new() 
	{
		super();
		
		barHealth = new FlxBar().createGradientBar([0xEE000000, 0xEE0C0C0], [0xFFFF0000, 0xFF00FF00], 1, 180, true, 0xFF000000);
		//sprHealth = new FlxSprite(0, 0, "assets/images/racoon.jpg");
		sprTextBox = new FlxSprite().makeGraphic(500, 100);
		sprTextBox.x = FlxG.width / 2;
		sprTextBox.y = FlxG.height / 2;
		textTextBox = new FlxText(0, (2 / 3) * FlxG.height, (4 / 5) * FlxG.width, "Hello whale"/*, INT font size, BOOL use imbedded fonts)*/);
		textTextBox.alignment = "center";
		
		//add(sprHealth);
		add(barHealth);
		add(sprTextBox);
		add(textTextBox);
		
		barHealth.
		
		//prevent any scrolling onscreen
		forEach(function(spr:FlxSprite) {
             spr.scrollFactor.set();
         });	
	}
	
	public updateHealthBar(healthe:Int) : Void{
		//barHealth.health = healthe;
		barHealth.percent = healthe * .1;
	}
	
	public updateText(texte:String) : Void{
		textTextBox.text = texte;
	}
	
}