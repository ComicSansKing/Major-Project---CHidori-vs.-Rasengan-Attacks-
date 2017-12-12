class Player {
  //data
  //numbers
  float x, y;
  float dx, dy;
  int player;
  int health;
  float radius;
  float speed = 0;
  float gravity = .2;
  float timeOfJump;
  float timeOfHit;
  int animationStance;
  int death;
  int counter = 0;


  //boolean
  boolean jump, moveLeft, moveRight;
  boolean hitting;
  //classes
  HP currentPlayerHealth;
  Attack currentPlayerAttack;
  Animation currentPlayerAnimation;
  
  //constructor(s)
  Player(float _x, float _y, int _player, int _health, float _radius, int _death) {
    //take in all these numbers
    x = _x;
    y = _y;
    dx = 15;
    dy = 15;
    health = _health;
    radius = _radius;
    player = _player;
    death = _death;

    //calll current health and attack for each player, updates per player
    currentPlayerHealth = new HP(health, player);
  currentPlayerAttack = new Attack(1, x, y, dx, dy);
  currentPlayerAnimation = new Animation(player);
  }

  //behaviour
  void checkIfCollidingWith(Player otherPlayer) {
    //distance between players and radius calculated
    float distanceBetweenPlayers = dist(x, y, otherPlayer.x, otherPlayer.y);
    float sumOfRadii = radius + otherPlayer.radius;

    //if the distance is less than or equal to radii then attack other player
    if (distanceBetweenPlayers <= sumOfRadii) {
      currentPlayerAttack.meleeAttack(otherPlayer.currentPlayerHealth);
    }
  }


  void keyPressed() { 
    //movement and jump code for players
    if (player == 1) {
      if (y == 600) {
        if (key == 'w'|| key == 'W') {
          //add 100ms to millis and set jump to true
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
    if (player == 2) {
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
      if (key == '0') {
          timeOfHit = millis() + 100;
          hitting = true;
        }
    }
  }

  void keyReleased() {
    //when any key released set any movement to false
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
      if (key == 'q' || key == 'Q') {
          timeOfHit = millis() + 100;
          hitting = true;
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
    //if jump is true and if millis  is less than millis + 100ms then jump
    if (jump) {
      if (millis() <= timeOfJump ) {
        y -= 25;
      }
    }
    //update movement for x 
    if (moveLeft) {
      x -= 10;
    }

    if (moveRight) {
      x += 10;
    }
  }

  void death() {
    if (currentPlayerHealth.health <= 0) {
      death = 1;
    }
  }

  void hitting(Player otherPlayer) {
    if (hitting && millis() <= timeOfHit ) { 
      checkIfCollidingWith(otherPlayer);
      currentPlayerHealth.display();
    }
    else{
     hitting = false; 
    }
    }

    void playerFunc(Player otherPlayer) {
      //take in other player's data
      //gravity, movement, and .display applied to self
      currentPlayerHealth.display();
      movement();
      death();
      hitting(otherPlayer);
      gravity();
    }

    void display() {
      //change player colours
      rectMode(CENTER);
      if (player == 1) {
        currentPlayerAnimation.moveLeft();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationMoveLeft[counter], x,y,100,100);
        if (frameCount % 2 == 0){
         counter++;
         counter = counter % currentPlayerAnimation.narutoAnimationMoveLeft.length;
          
        }
      }
      if (player == 2) {
        fill(0, 34, 160);
        rect(x, y, 100, 200);
      }

    }
    
    
    
    
  }