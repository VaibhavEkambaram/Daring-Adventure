/*
* CGRA 151 Project 3: Daring Adventure Game
 * Vaibhav Ekambaram | 300472561
 * ekambavaib
 *
 * ----------------------------------------------------------------
 * Platform class
 * ----------------------------------------------------------------
 */


class Platform {

  float px =1600; // x position
  float py = height-300; // y position
  float pw = 1200; // platform width
  float ph = height-py; // platform height
  float vx = 6; // horizontal velocity
  boolean drawObstacles = false; // whether to draw obstacles or not
  float obstacleWidth = 92; // obstacle width
  float obstacleHeight = 92; // obstacle height
  private float randomX = random(obstacleWidth*3, pw-(obstacleWidth*3)); // randomize x position
  float drawOrNot = random(0, 1); // randomize whether to draw
  float randomizePlatformImage = random(0, 1); // randomize image to use
  float obstacleX; // obstacle x position init
  float obstacleY; // obstacle y position init
  boolean hasObstacle = false; // determinie whether has obstacle

  // load images
  PImage platform1 = loadImage("/assets/platforms/platform1.gif");
  PImage platform2 = loadImage("/assets/platforms/platform2.gif");
  PImage platform3 = loadImage("/assets/platforms/platform3.gif");
  PImage startImg = loadImage("/assets/platforms/platform1_start.gif");
  PImage obstacle1 = loadImage("/assets/obstacles/obstacle1.gif");
  PImage obstacle2 = loadImage("/assets/obstacles/obstacle2.gif");
  PImage obstacle3 = loadImage("/assets/obstacles/obstacle3.gif");
  PImage obstacle4 = loadImage("/assets/obstacles/obstacle4.gif");

  // randomize obstacle imaiges
  float randomizeObstacleImage = random(0, 0.8);
  float obstacleProbability;

  /**
   * setObstacleProbability
   * Set the probability of obstacle spawn
   */
  void setObstacleProbability(float probability) {
    obstacleProbability = probability;
  }

  /**
   * set horizontal speed
   * Set the speed at which the platform updates
   */
  void setSpeed(int speed) {
    vx = speed;
  }

  /**
   * Determine height randomizer
   */
  void isRandom(boolean randomHeight) {
    if (randomHeight) {
      py = height-random(100, 225);
    }
  }

  /**
   * Determine if obstacles are drawn
   */
  void drawObstacles(boolean getValue) {
    drawObstacles = getValue;
  }

  /**
   * Primary draw method
   */
  void draw() {
    fill(0, 255, 0);
    noStroke();

    if (pw==1200) {
      if (randomizePlatformImage <= 0.33) {
        image(platform1, px, py);
      } else if (randomizePlatformImage > 0.33 && randomizePlatformImage < 0.66) {
        image(platform2, px, py);
      } else if (randomizePlatformImage >= 0.66) {
        image(platform3, px, py);
      }
    } else {
      image(startImg, px, py);
    }
    fill(0, 0, 255);
    // obstacle is baked into platform class
    if (drawObstacles && drawOrNot>=obstacleProbability) { // probability of obstacle spawn
      hasObstacle = true;
      obstacleX = px + randomX;
      obstacleY = py-obstacleHeight;
      // randomize obstacle image
      if (randomizeObstacleImage <= 0.2) {
        image(obstacle1, obstacleX, obstacleY);
      } else if (randomizeObstacleImage > 0.2 && randomizeObstacleImage <= 0.4) {
        image(obstacle2, obstacleX, obstacleY);
      } else if (randomizeObstacleImage > 0.4 && randomizeObstacleImage <= 0.6) {
        image(obstacle3, obstacleX, obstacleY);
      } else if (randomizeObstacleImage > 0.6 && randomizeObstacleImage <= 0.8) {
        image(obstacle4, obstacleX, obstacleY);
      }
    }
  }

  /**
   * Update x position to move to the left
   */
  void update() {
    px = px - vx;
  }
}
