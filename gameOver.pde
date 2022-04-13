/*
* CGRA 151 Project 3: Daring Adventure Game
* Vaibhav Ekambaram | 300472561
* ekambavaib
*
* ----------------------------------------------------------------
* Game Over screen
* ----------------------------------------------------------------
*/

void gameOver() { 
  platformArray.clear(); // clear platforms and clear garbage collector
  deletionArray.clear();
  clear();
  background(85, 107, 47);
  // clear objects and set background
  textSize(64);
  fill(255);
  textAlign(CENTER);
  //info text
  text("Game Over!", width/2, 200);
  textSize(32);
  // if number of players if one then just display loststring message passed through
  // (this will not show up for multiple players)
  text(lostString, width/2, 250);
  fill(0);
  stroke(255, 242, 0);
  strokeWeight(2);
  // draw back to main menu button
  rect((width*0.5)-200, 720, 400, 40);
  fill(255);
  textSize(16);
  textAlign(CENTER);
  text("Return to main menu", (width*0.5), 745);
  textSize(32);
  // if more than two players then show the score of each player
  // then show the winning player and their playersprite
  // if it is a draw then both sprites are displayed
  if (numberOfPlayers==2) {
    text("Player one ran "+playerOneScore+"m", width/2, 250);
    text("Player two ran "+playerTwoScore+"m", width/2, 285);    
    if (playerOneScore > playerTwoScore) {
      text("Player one is the winner!", width/2, 600);
      image(playerOneThumbnail, (width/2)-46, 400);
    } else if (playerOneScore==playerTwoScore) {
      text("It's a draw!", width/2, 600);
      image(playerOneThumbnail, (width/2)-92, 400);
      image(playerTwoThumbnail, (width/2)+92, 400);
    } else if (playerOneScore < playerTwoScore) {
      image(playerTwoThumbnail, (width/2)-46, 400);
      text("Player two is the winner!", width/2, 600);
    }
  }
}
