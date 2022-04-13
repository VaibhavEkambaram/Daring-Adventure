/*
* CGRA 151 Project 3: Daring Adventure Game
* Vaibhav Ekambaram | 300472561
* ekambavaib
*
* ----------------------------------------------------------------
* Main game control class
*   - Variable declaration
*   - Main draw controller loop
*   - run game
* ----------------------------------------------------------------
*/

// Initial variables delcaration
// ---------------------------------------------------------------- 
int tick = 0; // tick for spawning platform objects
int distanceCounter = 0; // count total distance covered
int numberOfPlayers = 1; // set number of players (programmed for 1 or 2)
int lostStatus = 0; // lost status calculator for multiplayer
// multiplayer player score storage
int playerOneScore = 0;
int playerTwoScore = 0;

// string to pass to gameOver if lost
String lostString;
// set starting state for draw function
String state = "mainMenu";

boolean pause = false; // set pause
boolean firstRun = true; // determine if first run

ArrayList<Platform> platformArray = new ArrayList<Platform>(); // store platform objects
ArrayList<Platform> deletionArray = new ArrayList<Platform>(); // platform objects scheduled for deletion

// Initilize sprite images
PImage backgroundDay;
PImage backgroundNight;
PImage pauseButton;
PImage dayDisplayButton;
PImage nightDisplayButton;
PImage homeButton;
PImage playerOneThumbnail;
PImage playerTwoThumbnail;
PImage obstacle1;
PImage obstacle2;
PImage obstacle3;
PImage obstacle4;

// Initilize player objects
Player player = new Player(); // player one
Player player2 = new Player(); // player two


  /**
   * Setup method
   * Initilize engine and load in sprite images for later use
   */
void setup() {
  // determine native screen resolution (changing this may exhibit strange behaviour)
  size(1600, 900); 
  //fullScreen();
  frameRate(60); // set framerate (again changing this may result in strange behaviour)
  
  // load sprite images
  backgroundDay = loadImage("/assets/backgrounds/background_day.bmp");
  backgroundNight = loadImage("/assets/backgrounds/background_night.bmp");
  pauseButton = loadImage("/assets/ui/pause.bmp");
  dayDisplayButton = loadImage("/assets/ui/dayDisplayButton.bmp");
  nightDisplayButton = loadImage("/assets/ui/nightDisplayButton.bmp");
  homeButton = loadImage("/assets/ui/home.bmp");
  playerOneThumbnail = loadImage("/assets/player/p1b.gif");
  playerTwoThumbnail = loadImage("/assets/player/p2b.gif");
  obstacle1 = loadImage("/assets/obstacles/obstacle1.gif");
  obstacle2 = loadImage("/assets/obstacles/obstacle2.gif");
  obstacle3 = loadImage("/assets/obstacles/obstacle3.gif");
  obstacle4 = loadImage("/assets/obstacles/obstacle4.gif");
}

  /**
   * Main draw method
   * what "screen" the user is on is determined by the string variable "state"
   */
void draw() {
  if (state.equals("mainMenu")) {
    mainMenu();
  } else if (state.equals("day") || (state.equals("night"))) {
    runGame();
  } else if (state=="gameOver") {
    gameOver();
  } else if (state =="help") {
    help();
  }
}


  /**
   * Main game engine loop
   * Draw background
   * Create player(s)
   * setup score system
   * Handle collisions
   */
void runGame() {
  // determine day or night background based on declared state
  if (state.equals("day")) {
    background(backgroundDay);
  } else if (state.equals("night")) {
    background(backgroundNight);
  }
  
  // draw pause button (mouse listener can be seen in the mouse function further down below)
  image(pauseButton, 25, 25);

  // set player 1 images and draw
  player.setImage("/assets/player/p1a.gif", "/assets/player/p1b.gif");
  player.draw(300);

  if (numberOfPlayers==2) {
    // if multiplayer, set player 2 images and draw as well as 1
    player2.setImage("/assets/player/p2a.gif", "/assets/player/p2b.gif");
    player2.draw(450);
  }

  // setup score system
  drawScore();
  
  // spawn first platform 
  // different variables apply depending on day and night, such as speed and obstacle probability
  // obstacle probability is always going to be 0 for the first platform to give the player a fair start
  if (firstRun == true) {
    Platform platform = new Platform();
    platform.isRandom(false);
    if (state.equals("day")) {
      platform.setSpeed(6);
      platform.setObstacleProbability(0);
    } else if (state.equals("night")) {
      platform.setObstacleProbability(0);
      platform.setSpeed(8);
    }
    // overwrite starting co-ordinates of the starting platform
    platform.px = 0;
    platform.pw = 2750;
    platformArray.add(platform);
    firstRun = false;
  }

  // tickrate determines the duration at which new platforms are generated
  // as night mode is faster, its tick rate is subsequently lower
  int tickRate = 0;
  if (state.equals("day")) {
    tickRate = 260; // day tick rate
  } else if (state.equals("night")) {
    tickRate = 205; // night tick rate
  }
  if (tick == tickRate) {
    Platform platform = new Platform();
    if (state.equals("day")) {
      platform.setSpeed(6);
      platform.setObstacleProbability(0.5);
    } else if (state.equals("night")) {
      platform.setSpeed(8);
      platform.setObstacleProbability(0.7);
    }
    if ((distanceCounter/100) > 5) {
      platform.drawObstacles(true);
    }
    platform.isRandom(true);
    platformArray.add(platform);
    tick = 0;
  }  

  // loop through platforms
  // if right side of the platform has reached an x value of 0
  // schedule it for removal
  // otherwise draw and update platform
  for ( Platform getPlatform : platformArray) {
    if ((getPlatform.px+getPlatform.pw) == 0) {
      deletionArray.add(getPlatform);
    } else {
      getPlatform.draw();
      getPlatform.update();
    }
  }
  // remove all platforms scheduled for deletion
  // (cant be done within the above loop)
  platformArray.removeAll(deletionArray);
  deletionArray.clear();
  
  // no platforms will spawn this low
  // so if a player has reached this height
  // this means that the player is ded :(
  if (numberOfPlayers==1) {
    if (player.py+player.pw > height-60) {
      // make player invisible, send lost string and set game over state
      player.setVisible(false);
      lostString = "You ran "+distanceCounter/10+"m before running into water";
      state = "gameOver";
    }
  } else if (numberOfPlayers==2) {
    // if two players then instead of one
    if (player.py+player.pw > height-60) {
      // make invisible
      player.setVisible(false);
      // move to x pos 0 so it doesnt interfere with collision detection
      player.px = 0;
      // set player one score
      playerOneScore = (distanceCounter/10);
      // increment lost status
      lostStatus++;
    }

    // do the same for player 2
    if (player2.py+player2.pw > height-60) {
      // make invisible
      player2.setVisible(false);
      // move to x pos 0 so it doesnt interfere with collision detection
      player2.px = 0;
      // set player 2 score
      playerTwoScore = (distanceCounter/10);
      // increment lost status
      lostStatus++;
    }
  }
  
  // call collision function
  if (numberOfPlayers==1) { // if only one player
    collision(player);
  } else if (numberOfPlayers==2) { // if both players
    collision(player);
    collision(player2);
  }

  // game over if lost status is greater or equal to 2
  // this is only really used for multiplayer
  if (lostStatus>=2) {
    state = "gameOver";
  }

  // increment tick and distance counter
  tick++;
  distanceCounter++;
}


// draw score counter on top left of screen
void drawScore() {
  fill(0);
  stroke(255);
  strokeWeight(2);
  rect(1210, 25, 390, 50);
  fill(255);
  textSize(32);
  text("Distance run: "+distanceCounter/10+"m", 1225, 60);
  noStroke();
  fill(49, 76, 176);
  rect(0, height-80, width, 80);
}

// draw pause UI if paused
void pausedUI() {
  //if the game is paused draw pause notification and home button
  pause = true;
  fill(0);
  stroke(255, 242, 0);
  strokeWeight(2);
  rect(0, 25, 390, 80);
  fill(255, 242, 0);
  textSize(32);
  text("Game Paused", 25, 60);
  textSize(24);
  text("Press to return to the game", 25, 90);
  image(homeButton, 25, 120);
  noLoop();
}

// keypress method
void keyPressed() {
  if (state.equals("day") || (state.equals("night"))) {
    if (key == 'p') {
      // if presses p, pause game
      if (pause==false) {
        pausedUI();
      } else if (pause==true) {
        // if they press p whilst paused then unpause
        pause = false;
        loop();
      }
      // player 1 jump using w or spacebar
    } else if (key == 'w' || key == ' ') {
      if (player!=null) {
        player.jump();
      }
      // player 2 jump using up or enter key
    } else if (keyCode == UP || keyCode == ENTER) {
      if (numberOfPlayers==2) {
        if (player2!=null) {
          player2.jump();
        }
      }
    }
  }
}


void mousePressed() {
  if (state.equals("help")) {
    // help retur button
    if (mouseX >= (width*0.5)-100 && mouseX <= (width*0.5)+100 && mouseY >= 720 && mouseY <= 775) {
      noLoop();
      state = "mainMenu";
      loop();
    }
  } else if ((state.equals("day")) || (state.equals("night"))) {
     // if user presses pause button while playing game
    if (pause==false) {
      if (mouseX >= 25 && mouseX <= 75 && mouseY >= 25 && mouseY <= 75) {
        pausedUI();
      } else {
        if (mouseButton == LEFT) {
          player.jump(); // player 1 jump
        } else if (mouseButton == RIGHT) {
          if (numberOfPlayers==2) {
            player2.jump(); // player 2 jump
          }
        }
      }
    } else if (pause==true) {
      // unpause game
      if (mouseX >= 0 && mouseX <= 390 && mouseY >= 25 && mouseY <= 105) {
        pause = false;
        loop();
        // back to main menu 
      } else if (mouseX >= 25 && mouseX <= 75 && mouseY >= 120 && mouseY <= 170) {
        noLoop();
        state = "mainMenu";
        loop();
      }
    }
    // main menu
  } else if (state.equals("mainMenu")) {
    if (mouseX >= width*0.25 && mouseX <= (width*0.25)+380 && mouseY >= 280 && mouseY <= 620) {
      // if day selected
      state = "day";
    } else if (mouseX >= (width*0.75)-380 && mouseX <= width*0.75 && mouseY >= 280 && mouseY <= 620) {
      // if night selected
      state = "night";
    } else if (mouseX >= (width*0.5)-100 && mouseX <= (width*0.5)+100 && mouseY >= 665 && mouseY <= 705) {
      if (numberOfPlayers==1) {
        numberOfPlayers = 2;
      } else if (numberOfPlayers==2) {
        numberOfPlayers = 1;
      }
      // main menu help button
    } else if (mouseX >= (width*0.5)-100 && mouseX <= (width*0.5)+100 && mouseY >= 720 && mouseY <= 775) {
      noLoop();
      state = "help";
      loop();
      // main menu exit button
    } else if (mouseX >= (width*0.5)-100 && mouseX <= (width*0.5)+100 && mouseY >= 775 && mouseY <= 830) {
      exit();
    }
    // game over main menu button
  } else if (state.equals("gameOver")) {
    if (mouseX >= (width*0.5)-200 && mouseX <= (width*0.5)+200 && mouseY >= 720 && mouseY <= 775) {
      noLoop();
      state = "mainMenu";
      loop();
    }
  }
}
