/*
CyanGame
by Steve Schmidt 2013
In this game a miner searches for treasue by digging down into the earth.
What he finds is both precious and horifying.*/

package
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	
	public class CyanGame extends MovieClip
	{
		private var hero:Hero;						// Player character
		private var score:Score;					// Player score
		private var sky:SkyBlue;					// Sky tile
		private var grass:GroundGrass;				// Grass tile
		private var dirt:GroundDirt;				// Dirt tile
		private var tunnel:GroundTunnel;			// Tunnel tile
		private var stone:GroundStone;				// Stone tile
		private var runMessage:RunMessage;			// run message
		private var gem:Gem;						// gem treasure
		private var gemCounter:GemCounter;			// displays number of gems
		private var gemCurrent:int;					// currnent gem count
		private var gemMax:int;						// max gem count for level
		private var skeleton:Skeleton;				// Skeleton character
		private var tempTile:MovieClip				// Selection tile
		private var gameTimer:Timer;				// game timer
		private var keyLock:Boolean;				// check for button presses
		private var legalMove:Boolean;				// check for hero moving in tunnels
		private var isSkeleton:Boolean;				// check if there is a Skeleton on the map
		private var moveSelector:MoveSelector;		// movement and digging location selector
		private var tickEnemyCounter:int;			// counter for enemy movement timing
		private var tickSkeletonCounter:int;		// counter for skeleton movement timing
		private var pathCounter:int;				// counter for skeleton movement pathing
		private var randomNumber:int;				// random number for tunnel contents generation
		private var gridX:Array = [0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448, 480];	// play map x values
		private var gridY:Array = [0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352];						// play map y values
		private var tileArray:Array = [];			// array to hold all tile types
		private var gemArray:Array = [];			// array to hold all gems
		private var heroPathX:Array = [];			// array to hold hero path x values
		private var heroPathY:Array = [];			// array to hold hero path y values	
		private var firstKeyPressed:KeyboardEvent;		// Key pressed value
		private var levels:Levels;					// Holds obstacles for different levels
		
		public function CyanGame()
		{
			initialize();
		}
		
		public function initialize():void
		{
		// initializing required variables
			gameTimer = new Timer( 25 );
			gameTimer.addEventListener( TimerEvent.TIMER, onTick );
			gameTimer.start();
			
			tickSkeletonCounter = 0;
			pathCounter = 0;
			gemCurrent = 0;
			gemMax = 5;
			gemCounter = new GemCounter();
			gemCounter.addMax( gemMax );
						
			keyLock = false;
			legalMove = false;
			isSkeleton = false;
			
			levels = new Levels;
			
			firstKeyPressed = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
			
			drawLevel();
			
			hero = new Hero();
			addChild( hero );
			
			score = new Score();
			addChild( score );
			
			addChild( gemCounter );
			
			moveSelector = new MoveSelector(hero.x, hero.y + 32);
			addChild( moveSelector );
			
			addEventListener( Event.ADDED_TO_STAGE, onAddToStage );
		}
			
		public function reset():void
		{
			levels.setCurrentLevel( levels.getCurrentLevel() + 1 );
			tileArray = [];
			gameTimer = null;
			
			// initializing required variables
			gameTimer = new Timer( 25 );
			gameTimer.addEventListener( TimerEvent.TIMER, onTick );
			gameTimer.start();
			
			tickSkeletonCounter = 0;
			pathCounter = 0;
			gemCurrent = 0;
			
			keyLock = false;
			legalMove = false;
			isSkeleton = false;
			
			firstKeyPressed = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
			
			drawLevel();
			
			hero = new Hero();
			addChild( hero );
			
			moveSelector = new MoveSelector(hero.x, hero.y + 32);
			addChild( moveSelector );
			
			//addEventListener( Event.ADDED_TO_STAGE, onAddToStage );
			
		}
		
		public function drawLevel():void
		{
			// create play map
			// 3 rows of sky tiles
			// 1 row of grass tiles
			// 8 rows of dirt tiles
			for (var i:int = 0; i < 16; i++)
			{
				for (var j:int = 0; j < 12; j++)
				{
					// Check for level based obstaces, then place tiles acording to row
					var currentLevelArray:Array;
					var currentLevelInt:int;
					currentLevelInt = levels.getCurrentLevel();
					currentLevelArray = levels.getLevelArray( currentLevelInt );
					if ( currentLevelArray[j][i] == 0 )
					{
						//skip space for score and gem items
					}
					
					else if ( currentLevelArray[j][i] == 1 )
					{
						sky = new SkyBlue();
						sky.x = gridX[i];
						sky.y = gridY[j];
						addChild( sky );
						tileArray.push( sky );
					}
					
					else if ( currentLevelArray[j][i] == 2 )
					{
						grass = new GroundGrass();
						grass.x = gridX[i];
						grass.y = 96;
						addChild( grass );
						tileArray.push( grass );
					}
				
					else if ( currentLevelArray[j][i] == 3 )
					{
						dirt = new GroundDirt();
						dirt.x = gridX[i];
						dirt.y = gridY[j];
						addChild( dirt );
						tileArray.push( dirt );
					}
					
					else if ( currentLevelArray[j][i] == 4 )
					{
						stone = new GroundStone();
    					stone.x = gridX[i];
						stone.y = gridY[j];
   						addChild( stone );
						tileArray.push( stone );
					}
				}
			}
		}
		
		public function onAddToStage( event:Event ):void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease );
		}
		
		// Function to handle all actions that need to be done repeatedly over time.
		public function onTick( timerEvent:TimerEvent ):void 
		{
			trace( tickSkeletonCounter );
			// Once a skeleton is on the map, its movement and distruction are handled
			tickSkeletonCounter += 1;
			if ( tickSkeletonCounter == 20 )
			{
				if ( isSkeleton )
				{
					if( skeleton.y <= 64 )
					{
						skeleton.parent.removeChild( skeleton );
						isSkeleton = false;
						trace("The Skeleton is gone");
						tickSkeletonCounter = 0;
						runMessage.parent.removeChild( runMessage );
						pathCounter = 0;
					}
				}
			}
			if( tickSkeletonCounter == 40 )
			{
				if ( isSkeleton )
				{
					if( pathCounter == 0 || pathCounter < heroPathX.length -1 )
					{
						skeleton.moveSkeleton( heroPathX[pathCounter], heroPathY[pathCounter] );
						trace( "Skeleton is moving to: " + heroPathX[pathCounter] + "," + heroPathY[pathCounter] );
						pathCounter += 1;
					}
					else
					{
						trace("End of Path"); 
						trace(heroPathX);
					}
				}
				tickSkeletonCounter = 0;
			}
			
			if ( isSkeleton )
			{
				if ( skeleton.x == hero.x && skeleton.y == hero.y )
				{
					gameTimer.stop();
					dispatchEvent( new HeroEvent( HeroEvent.DEAD ) );
				}
			}
			for(var g:int = 0; g < gemArray.length; g++)
			{
				if ( gemArray[g] != null && gemArray[g].parent )
				{
					if ( gemArray[g].x == hero.x && gemArray[g].y == hero.y )
					{
						gemArray[g].parent.removeChild( gemArray[g] );
						gemArray.splice( gemArray[g], 1 );
						score.addToValue( 10 );
						gemCounter.addToValue( 1 );
						gemCurrent++;
						if ( gemCurrent == gemMax )
						{
							reset();
							//dispatchEvent( new NavigationEvent( NavigationEvent.NEXTLEVEL ) );
						}
					}
				}
			}
		}
		
		// Search for the map tile that is selected by the MoveSelector
		public function getTile():void
		{
			for (var a:int = 0; a < tileArray.length; a++)
			{
				if ( tileArray[a].x == moveSelector.x && tileArray[a].y == moveSelector.y )
				{
					tempTile = tileArray[a];
				}
			}
		}
		
		// Check if the target tile is ok to to move to
		public function checkTileArray():void
		{
			getTile();
			if ( tempTile as GroundTunnel )
			{
				legalMove = true;
			}
			if ( moveSelector.y == 64 )
			{
				legalMove = true;
			}
		}
						
		// Check for gems in the dirt... or skeletons.
		public function checkTunnelContents():void
		{
			var randomNumber = Math.random() * 3;
			randomNumber = Math.round(randomNumber);

			if( randomNumber == 2 && hero.y > 160 )
			{
				trace("GEM!!");
				gem = new Gem();
    			gem.x = moveSelector.x;
				gem.y = moveSelector.y;
   				addChild( gem );
				setChildIndex( gem, getChildIndex( dirt ));
				gemArray.push( gem );
			}
			if( randomNumber == 3 && hero.y > 160 )
			{
				if(!isSkeleton)
				{
					trace("SKELETON!!");
					tickSkeletonCounter = 0;
					pathCounter = 0;
					skeleton = new Skeleton();
    				skeleton.x = moveSelector.x;
					skeleton.y = moveSelector.y;
   					addChild( skeleton );
					setChildIndex( skeleton, getChildIndex( dirt ));
					heroPathX = [];
					heroPathY = [];
					buildHeroPath();
					runMessage = new RunMessage();
					runMessage.x = 0;
					runMessage.y = 0;
					addChild( runMessage );
				}
				isSkeleton = true;
			}
			randomNumber = 0;
		}
		
		// Once a skeleton is found, the hero path will be used for the skeleton to follow
		public function buildHeroPath():void
		{
			heroPathX.push(hero.x);
			heroPathY.push(hero.y);
		}
		
		public function onKeyPress( keyboardEvent:KeyboardEvent ):void
		{
			if ( keyboardEvent.keyCode == Keyboard.SHIFT)
				{
					trace( "heroPathX: " + heroPathX );
					trace( "heroPathY: " + heroPathY );
				}
			
			if ( !keyLock )
			{
				firstKeyPressed.keyCode = keyboardEvent.keyCode;
				//trace(keyboardEvent.keyCode + "DOWN");
				
				if ( keyboardEvent.keyCode == Keyboard.DOWN )
				{
					keyLock = true;
					moveSelector.x = hero.x;
					moveSelector.y = hero.y +32;
					checkTileArray();

					if ( legalMove )
					{
						hero.moveDown();	
						moveSelector.moveDown(hero.x, hero.y);
						legalMove = false;
						buildHeroPath();
					}
				}
			
				if ( keyboardEvent.keyCode == Keyboard.UP )
				{
					keyLock = true;
					moveSelector.x = hero.x;
					moveSelector.y = hero.y -32;
					checkTileArray();
				
					if ( legalMove )
					{
						hero.moveUp();
						moveSelector.moveUp(hero.x, hero.y);
						legalMove = false;
						buildHeroPath();
					}
				}
			
				if ( keyboardEvent.keyCode == Keyboard.LEFT )
				{
					keyLock = true;
					moveSelector.x = hero.x -32;
					moveSelector.y = hero.y;
					checkTileArray();

					if ( legalMove )
					{
						hero.moveLeft();	
						moveSelector.moveLeft(hero.x, hero.y);
						legalMove = false;
						buildHeroPath();
					}
				}
			
				if ( keyboardEvent.keyCode == Keyboard.RIGHT )
				{
					keyLock = true;
					moveSelector.x = hero.x + 32;
					moveSelector.y = hero.y;
					checkTileArray();

					if ( legalMove )
					{
						hero.moveRight();	
						moveSelector.moveRight(hero.x, hero.y);
						legalMove = false;
						buildHeroPath();
					}
				}
			
				// To dig
				// Remove dirt, replace with tunnel,  add possibe tunnel contents
				if ( keyboardEvent.keyCode == Keyboard.SPACE )
				{
					keyLock = true;
					getTile();
					if ( tempTile.parent && ( tempTile as GroundDirt || tempTile as GroundGrass ))
					{ 
						tempTile.parent.removeChild( tempTile );
						score.addToValue( 1 );
						tunnel = new GroundTunnel;
						tunnel.x = moveSelector.x;
						tunnel.y = moveSelector.y;
						addChild( tunnel );
						setChildIndex( tunnel, getChildIndex( dirt ));
						tileArray.push( tunnel );
						checkTunnelContents();
						legalMove = false;
					}
				}
			}
		}
		
		public function onKeyRelease( keyboardEvent:KeyboardEvent ):void
		{
			//trace (keyboardEvent.keyCode + "UP");
			if ( keyboardEvent.keyCode == firstKeyPressed.keyCode )
			{
				keyLock = false;
			}
		}
	}
}