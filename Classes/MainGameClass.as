package 
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	
	public class MainGameClass extends MovieClip 
	{
		public var playScreen:CyanGame;
		public var controlsScreen:ControlsScreen;
		public var titleScreen:TitleScreen;
		public var gameOverScreen:GameOverScreen;
		
		public function MainGameClass() 
		{
 			showTitleScreen();
		}
		
		public function showTitleScreen():void
		{	
			titleScreen = new TitleScreen();
			titleScreen.addEventListener( NavigationEvent.CONTROLS, showControlsScreen );
			titleScreen.x = 0;
			titleScreen.y = 0;
			addChild( titleScreen );
		}
		
		public function showControlsScreen( navigationEvent:NavigationEvent ):void
		{
			controlsScreen = new ControlsScreen();
			controlsScreen.addEventListener( NavigationEvent.START, showPlayScreen );
			controlsScreen.x = 0;
			controlsScreen.y = 0;
			addChild( controlsScreen );
		}
		
		public function showPlayScreen( navigationEvent:NavigationEvent ):void
		{
			playScreen = new CyanGame();
			playScreen.addEventListener( HeroEvent.DEAD, onHeroDeath );
			playScreen.addEventListener( NavigationEvent.NEXTLEVEL, onNextLevel );
			playScreen.x = 0;
			playScreen.y = 0;
			addChild( playScreen );
		}
		
		public function onHeroDeath( heroEvent:HeroEvent ):void
		{
			var gameOverScreen:GameOverScreen = new GameOverScreen();
			gameOverScreen.addEventListener( NavigationEvent.RESTART, onRequestRestart );
			gameOverScreen.x = 0;
			gameOverScreen.y = 0;
			addChild( gameOverScreen );
 
			playScreen = null;
		}
		
		public function onNextLevel( navigationEvent:NavigationEvent ):void
		{
			playScreen = null;
			//levels.setCurrentLevel( levels.getCurrentLevel() + 1 );
			playScreen = new CyanGame();
			playScreen.addEventListener( HeroEvent.DEAD, onHeroDeath );
			playScreen.addEventListener( NavigationEvent.NEXTLEVEL, onNextLevel );
			playScreen.x = 0;
			playScreen.y = 0;
			addChild( playScreen );
		}
		
		public function onRequestRestart( navigationEvent:NavigationEvent ):void
		{
			restartGame();
		}
		
		public function restartGame():void
		{
			playScreen = new CyanGame();
			playScreen.addEventListener( HeroEvent.DEAD, onHeroDeath );
			playScreen.x = 0;
			playScreen.y = 0;
			addChild( playScreen );
 
			gameOverScreen = null;
		}
	}
}