class HP {
  //data
  float health;
  int player;
  int x;
  int death;

  //constructor(s)
  //set player location and take in which player and their helath
  HP(float _health, int _player) {
    health = _health;
    player = _player;
    //depending on player change x
    if (player == 1) {
      x = 100;
    }
    if (player == 2) {
      x = 900;
    }
  }

  //behaviour
  void gotHit(float amount) {
    //if hit then -amount from health
    health -= amount;
  }

  void display() {
    //draw healthbar, changes colour and size, set to individual players
    rectMode(CORNER);
    if (player == 1) {
      fill(0);
      rect(width/14, height/30, 600, 30);
      if (health >=300) {
        fill(0, 255, 0);
      }
      if (health >=100 && health <= 300) {
        fill(255, 255, 0);
      }
      if (health <= 100) {
        fill(255, 0, 0);
      }
      rect(width/14, height/30, health, 30);
    }
    if (player == 2) {
      fill(0);
      rect(width/9*5, height/30, 600, 30);
      if (health >=300) {
        fill(0, 255, 0);
      }
      if (health >=100 && health <= 300) {
        fill(255, 255, 0);
      }
      if (health <= 100) {
        fill(255, 0, 0);
      }
      rect(width/9*5-health+600, height/30, health, 30);
    }
    rectMode(CENTER);
  }
}   