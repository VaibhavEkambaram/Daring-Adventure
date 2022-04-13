/*
* CGRA 151 Project 3: Daring Adventure Game
 * Vaibhav Ekambaram | 300472561
 * ekambavaib
 *
 * ----------------------------------------------------------------
 * Collision method for player interaction with platforms
 * ----------------------------------------------------------------
 */

void collision(Player getPlayer) {
  if ((!(getPlayer.vy==0))) {
    getPlayer.can_jump = false;
    // if player is not on a platform then they are unable to jump
  }
  // loop through platforms
  for ( Platform platform : platformArray) {
    if (getPlayer.px >= platform.px && getPlayer.px <= platform.px+platform.pw) {
      if (getPlayer.py+getPlayer.pw <= platform.py) {
        // check platform has obstacle
        if (platform.hasObstacle) {
          // check if within the bounds of the obstacle
          if (getPlayer.px+getPlayer.pw >= platform.obstacleX && getPlayer.px <= platform.obstacleX+platform.obstacleWidth) {
            if (getPlayer.py+getPlayer.pw >= platform.obstacleY && getPlayer.py <= platform.obstacleY+5) {
              // if player is on top of the obstacle
              getPlayer.py = platform.obstacleY - getPlayer.pw; // set player y sit on obstacle
              getPlayer.vy = 0; // set velocity to zero
              getPlayer.can_jump = true; // set jump ability
              // if player hits obstacle in mid air
            } else if (getPlayer.py+getPlayer.pw >= platform.obstacleY+5 && getPlayer.py+getPlayer.pw <= platform.py-5) {
              // if single player
              if (numberOfPlayers==1) {
                lostString = "You ran "+distanceCounter/10+"m before running into an obstacle";
                getPlayer.setVisible(false); // make player invisible
                state = "gameOver";
              } else if (numberOfPlayers==2) {
                // if multiplayer
                getPlayer.setVisible(false); // make player invisible
                // if dead then get respective player score
                if (getPlayer==player) {
                  playerOneScore = distanceCounter;
                } else if (getPlayer==player2) {
                  playerTwoScore = distanceCounter;
                }
                lostStatus++; // increment lostStatus - main control in game method
              }
            }
          }
        }
      } else {
        //  if player is standing on top of the platform
        getPlayer.py = platform.py - getPlayer.pw; // set player y sit on obstacle
        getPlayer.vy = 0; // set velocity to zero
        getPlayer.can_jump = true; // set jump ability
        // check platform has obstacle
        if (platform.hasObstacle) {
          // if player hits obstacle
          if (getPlayer.px+getPlayer.pw >= platform.obstacleX+(platform.obstacleWidth/2) && getPlayer.px+player.pw <= platform.obstacleX + platform.obstacleWidth && getPlayer.py+getPlayer.pw >= platform.obstacleY) {
            if (numberOfPlayers==1) {
              // if single player
              lostString = "You ran "+distanceCounter/10+"m before running into an obstacle";
              getPlayer.setVisible(false); // make invisible
              state = "gameOver";
            } else if (numberOfPlayers==2) {
              // if multiplayer
              getPlayer.setVisible(false); // make invisible
              // if dead then get respective player score
              if (getPlayer==player) {
                playerOneScore = distanceCounter;
              } else if (getPlayer==player2) {
                playerTwoScore = distanceCounter;
              }
              lostStatus++; // increment lostStatus - main control in game method
            }
          }
        }
      }
    }
  }
}
