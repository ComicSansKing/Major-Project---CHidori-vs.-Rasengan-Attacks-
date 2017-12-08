class HP {
  int health;
  int player;
  int x;



  //buildboi
  HP(int _health, int _player) {
    health = _health;
    player = _player;
    if (player == 1) {
      x = 100;
    }
    if (player == 2) {
      x = 900;
    }
  }

  void gotHit(int amount) {
    health -= amount;
  }


  //behavv
  void display() {
    rectMode(CORNER);
    if (player == 1) {
      fill(0, 255, 0);
      rect(x, 20, health*3, 30);
    }
    if (player == 2) {
      fill(0, 255, 0);
      rect(x-health*3+580, 20, health*3, 30);
    }
    rectMode(CENTER);
        println("eatass");
  }
}    