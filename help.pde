/*
* CGRA 151 Project 3: Daring Adventure Game
* Vaibhav Ekambaram | 300472561
* ekambavaib
*
* ----------------------------------------------------------------
* Help
* ----------------------------------------------------------------
*/

void help() {
  clear();
  // clear all items on screen
  textAlign(CENTER);
  background(85, 107, 47);
  fill(0);
    stroke(255, 242, 0);
  strokeWeight(2);
  rect((width*0.5)-100, 720, 200, 40);
  fill(255);
  noStroke();
  textSize(16);
  // show information text
  text("Player 1 Jump - W / Spacebar / Left Mouse", (width*0.22), 280);
  text("P - pause/unpause", (width*0.22), 330);
  text("Player 2 Jump - UP / Enter / Right Mouse", (width*0.22), 380);
  text("Daring Adventure (formerly Daring Escape) v1.0", (width*0.8), 280);
  text("Made by Vaibhav Ekambaram for CGRA151 Final Project", (width*0.8), 310);
  text("Game made using Processing ", (width*0.8), 340);
  text("Sprites made by myself using Aesprite", (width*0.8), 370);

  // change text alignment for game description
  textAlign(LEFT);
  text("Daring Adventure is an endless runner where your goal as the player", (width*0.02), 500);
  text("is to run the furthest distance possible. This is done by jumping", (width*0.02), 520);
  text("from platform to platform while avoiding puddles or obstacles.", (width*0.02), 540);
  text("All the obstacles in the game can be seen towards the right.", (width*0.02), 560);
  text("The game is lost if the player falls in a puddle or running into", (width*0.02), 590);
  text("obstacles. This will send them to the game over screen where they", (width*0.02), 610);
  text("can then try another round. Obstacles can be avoided by jumping", (width*0.02), 630);
  text("over or on top of them. But be careful!", (width*0.02), 650);
  text("Difficulty & number of players can be selected from the main menu.", (width*0.02), 680);
   
  textAlign(CENTER);
  text("Return", (width*0.5), 745);
  textSize(24);
  text("Controls",width*0.2,200);
  text("Obstacles",width*0.5,200);
  text("Credits",width*0.8,200);
  text("Game Objective",width*0.2,475);
  fill(255);    
  textSize(64);
  textAlign(CENTER);
  text("Help", width/2, height*0.1667);
  // display images corresponding to info text
  image(playerOneThumbnail,width*0.03,height*0.244);
  image(playerTwoThumbnail,width*0.03,height*0.355);
  image(obstacle1,(width*0.5)-(height*0.0215),height*0.277,69,69);
  image(obstacle2,(width*0.5)-(height*0.0215),height*0.366,69,69);
  image(obstacle3,(width*0.5)-(height*0.0215),height*0.455,69,69);
  image(obstacle4,(width*0.5)-(height*0.0215),height*0.544,69,69);
}
