/*
* CGRA 151 Project 3: Daring Adventure Game
* Vaibhav Ekambaram | 300472561
* ekambavaib
*
* ----------------------------------------------------------------
* Main Menu
* ----------------------------------------------------------------
*/

void mainMenu() {
  clear();
  // reset variaibles for game methodology
  playerOneScore = 0;
  playerTwoScore = 0;
  platformArray.clear();
  deletionArray.clear();
  firstRun = false;
  distanceCounter = 0;
  tick = 0;
  firstRun = true;
  player = new Player();
  player2 = new Player();
  pause = false;
  lostStatus = 0;
  lostString = "";
  clear();
  background(85, 107, 47);
  // clear screen and set green background
  fill(255);    
  textSize(64);
  textAlign(CENTER);
  // title and heading
  text("Daring Adventure", width/2, height*0.1667);
  textSize(24);
  text("Select a difficulty to play", width/2, height*0.255);
  // create difficulty display buttons
  image(dayDisplayButton, width*0.25, height*0.277);
  image(nightDisplayButton, (width*0.75)-width*0.2375, height*0.277);
  textSize(20);
  textAlign(LEFT);
  text("Day", width*0.27, height*0.644);
  text("Night", (width*0.77)-width*0.2375, height*0.644);
  textSize(18);
  // draw text on top of display images
  text("Slower speed with minimal obstacles", width*0.27, height*0.667);
  text("Faster speed with more obstacles", (width*0.77)-(width*0.2375), height*0.667);
  fill(0);
  stroke(255, 242, 0);
  strokeWeight(2);
  // draw button rectangles
  rect((width*0.5)-(width*0.0625), height*0.7388, 200, 40);
  rect((width*0.5)-(width*0.0625), height*0.8, 200, 40);
  rect((width*0.5)-(width*0.0625), height*0.861, 200, 40);
  fill(255);
  textSize(16);
  textAlign(CENTER);
  // text labels for buttons
  // toggle function for more than one players
  text("(Optional) Select number of players before setting difficulty", (width*0.5), height*0.722);
  if (numberOfPlayers==1) {
    text("1 Player (Click to toggle)", (width*0.5), height*0.766);
  } else if (numberOfPlayers==2) {
    text("2 Player (Click to toggle)", (width*0.5), height*0.766);
  }
  text("Help", (width*0.5), height*0.8277);
  text("Quit", (width*0.5), height*0.8888);  
  // controllers for these buttons can be found in the mouse functions within the main class
  textAlign(LEFT);
}
