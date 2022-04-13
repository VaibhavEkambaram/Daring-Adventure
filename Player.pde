/*
* CGRA 151 Project 3: Daring Adventure Game
 * Vaibhav Ekambaram | 300472561
 * ekambavaib
 *
 * ----------------------------------------------------------------
 * Player Class
 * ----------------------------------------------------------------
 */


class Player {

  public boolean can_jump = false; // determine whether player can jump (must be contact with surface)
  private float ay = .3; // vertical acceleration
  float vy = 0; // vertical speed
  float px = 450; // x location
  float py = 600; // y location
  float pw = 92; // width / height
  private PImage char1; // animation state 1
  private PImage char2; // animation state 2
  private int frame = 0; // frame counter for animation
  boolean isVisible = true; // determine if image is visible

  /**
   * Jump method
   * If the player is on a hard surface, then jump
   */
  void jump() {
    if ( can_jump==true ) {
      vy = -12;
      can_jump = false;
    }
  }

  /**
   * Determine visibility of player character
   */
  void setVisible(boolean visible) {
    isVisible = visible;
  }

  /**
   * Set player character images
   */
  void setImage(String path, String path2) {
    char1 = loadImage(path);
    char2 = loadImage(path2);
  }


  /**
   * Draw method
   * draw if visibility is set to true
   * also cycle through the two animation states
   * and finally perform updates on vertical velocity and y position
   */
  void draw(float startX) {
    if (isVisible) {
      if (frame > 20) {
        frame = 0;
      }

      px = startX;
      fill(255, 0, 0);
      noStroke();

      if (frame > 10) {
        image(char1, px, py);
      } else {
        image(char2, px, py);
      }

      vy+=ay;
      py+=vy;
      frame++;
    }
  }
}
