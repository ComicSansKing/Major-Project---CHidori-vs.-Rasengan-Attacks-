class Player {
  //data
  float x, y;
  float dx, dy;
  int player;
  int hp;
  float radius;
  float speed = 0;
  float gravity = .2;
  boolean jump, moveLeft, moveRight;
  float timeOfJump;
  int animationStance;


  HP currentPlayerHealth;
  Attack currentPlayerAttack;


  //constructor(s)
  Player(float _x, float _y, int _player, int _hp, float _radius) {
    x = _x;
    y = _y;
    dx = 15;
    dy = 15;
    hp = _hp;
    radius = _radius;
    player = _player;
    currentPlayerHealth = new HP(hp, player);
    currentPlayerAttack = new Attack(2, x, y, dx, dy);
  }

  void checkIfCollidingWith(Player otherPlayer) {
    float distanceBetweenPlayers = dist(x, y, otherPlayer.x, otherPlayer.y);
    float sumOfRadii = radius + otherPlayer.radius;
    if (distanceBetweenPlayers <= sumOfRadii) {
      currentPlayerAttack.meleeAttack(otherPlayer.currentPlayerHealth);
    }
  }

  void damage(Player otherPlayer) {
    if (player == 1) { 
      if (keyPressed) {
        if (key == 'q' || key == 'Q') {
          checkIfCollidingWith(otherPlayer);
          currentPlayerHealth.display();
        }
      }
    }
    if (player == 2) { 
      if (keyPressed) {
        if (key == '0') {
          checkIfCollidingWith(otherPlayer);
          currentPlayerHealth.display();
        }
      }
    }
  }



  void keyPressed() { 
    if (player==1) {
      if (y == 600) {
        if (key == 'w'|| key == 'W') {
          timeOfJump = millis()+100;
          jump = true;
        }
      }
      if (key == 'a'|| key == 'A') {
        moveLeft = true;
        animationStance = 1;
      }

      if (key == 'd'|| key == 'D') {
        moveRight = true;
        animationStance = 0;
      }
    }
    if (player==2) {
      if (keyCode == UP) {
        if (y == 600) {
          timeOfJump = millis()+100;
          jump = true;
        }
      }

      if (keyCode == LEFT) {
        moveLeft = true;
        animationStance = 1;
      }

      if (keyCode == RIGHT) {
        moveRight = true;
        animationStance = 0;
      }
    }
  }

  void keyReleased() {
    if (player == 1) {
      if (key == 'w' || key == 'W') {
        jump = false;
      }

      if (key == 'a' || key == 'A') {
        moveLeft = false;
      }

      if (key == 'd' || key == 'D') {
        moveRight = false;
      }
    }
    if (player == 2) {
      if (keyCode == UP) {
        if (y == 600) {
          jump = false;
        }
      }
      if (keyCode == LEFT) {
        moveLeft = false;
      }

      if (keyCode == RIGHT) {
        moveRight = false;
      }
    }
  }

  void gravity() {
    y = y + speed;
    speed = speed + gravity;

    if (y > 600) {
      speed = speed * 0 ;
      y = 600;
    }
    if (y > 650 ) {
      y += 12;
    }
  }


  void movement() {
    if (jump) {
      if (millis() <= timeOfJump ) {
        y -= 25;
      }
    }
    if (moveLeft) {
      x -= 10;
    }

    if (moveRight) {
      x += 10;
    }
  }



  //behaviour
  void playerfunc(Player otherPlayer) {
    currentPlayerHealth.display();
    movement();
    damage(otherPlayer);
    gravity();
  }


  void display() {
    rectMode(CENTER);
    rect(x, y, 20, 20);
    println("eatass");
  }
}