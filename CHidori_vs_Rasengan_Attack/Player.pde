class Player { //<>// //<>// //<>// //<>//
  //data
  //numbers
  float x, y;
  float dx, dy;
  int player;
  float health;
  float radius;
  float speed = 0;
  float gravity = .2;
  float timeOfJump;
  float timeOfHit;
  int animationStance;
  int death;
  int counter = 0;
  int direction;
  int touching = 0;
  float attack = 2.5;
  float block = 0;
  float comboTimer;
  float comboTimerADV;
  int comboCounterBasic;
  int comboCounterADV;
  boolean chakraOn = false;
  int chakraDirection;
  int knockBackValue;
  float knockbackTimer;

  float currentChakraPosition;
  int chakra;
  FloatList chakraShot = new FloatList();


  //boolean
  boolean jump, moveLeft, moveRight;
  boolean hitting;
  boolean blocking;
  boolean bounce;
  //classes
  HP currentPlayerHealth;
  Attack currentPlayerAttack;
  Animation currentPlayerAnimation;
  Chakra currentPlayerChakra;

  //constructor(s)
  Player(float _x, float _y, int _player, float _health, float _radius, int _death) {
    //take in all these numbers
    x = _x;
    y = _y;
    dx = 10;
    dy = 10;
    health = _health;
    radius = _radius;
    player = _player;
    death = _death;
    if (player == 1) {
      direction = 1;
    }
    if (player == 2) {
      direction = 0;
    }
    //calll current health and attack for each player, updates per player
    currentPlayerHealth = new HP(health, player);
    currentPlayerAttack = new Attack(x, y, dx, dy);
    currentPlayerAnimation = new Animation(player);
    currentPlayerChakra = new Chakra(chakra, player);
  }

  //behaviour
  void checkIfCollidingWith(Player otherPlayer) {
    //distance between players and radius calculated
    float distanceBetweenPlayers = dist(x, y, otherPlayer.x, otherPlayer.y);
    float sumOfRadii = radius + otherPlayer.radius;

    //if the distance is less than or equal to radii then attack other player
    if ((direction == 1 && otherPlayer.direction == 0) || (direction == 0 && otherPlayer.direction == 1) || (direction == 1 && otherPlayer.direction == 1 && x < otherPlayer.x) || (direction == 0 && otherPlayer.direction == 0 && x > otherPlayer.x)) {
      if (distanceBetweenPlayers <= sumOfRadii) {
        currentPlayerAttack.meleeAttack(otherPlayer.currentPlayerHealth, attack);
        knockback(otherPlayer);

        chakra += 3;
        otherPlayer.chakra += 5;
        if (chakra > 300) {
          chakra = 300;
        }
        if (otherPlayer.chakra > 300) {
          otherPlayer.chakra = 300;
        }
      }
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
      if (key == 'g'|| key == 'G') {
        blocking = true;
        block = 255;
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
      if (key == '1') {
        blocking = true;
        block = 255;
      }
    }

    if (blocking == true) {
      stopMoving();
    }
  }


  void keyReleased() {
    //when any key released set any movement to false
    if (player == 1) {
      if (key == 'w' || key == 'W') {
        if (y == 600) {
          jump = false;
        }
      }

      if (key == 'a'|| key == 'A') {
        moveLeft = false;
      }

      if (key == 'd' || key == 'D') {
        moveRight = false;
      }
      if (key == 's'|| key == 'S') {
        comboCounterADV +=1;
        comboTimerADV = millis()+300;
      }

      if (key == 'f' || key == 'F') {
        timeOfHit = millis() + 100;
        hitting = true;
        comboCounterBasic += 1;
        comboTimer = millis() + 500;
        comboTimerADV = millis()+300;
      }
      if (key == 'g'|| key == 'G') {
        blocking = false;
        block = 0;
      }
      if (key == 'q' || key ==  'Q') {
        if (chakra == 300) {
          currentChakraPosition = x;
          chakraOn = true;
          chakra = 0;
          if (direction == 0) {
            chakraDirection = 0;
          }
          if (direction == 1) {
            chakraDirection = 1;
          }
        }
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

      if (keyCode == DOWN) {
        comboCounterADV +=1;
        comboTimerADV = millis()+300;
      }

      if (key == '0') {
        timeOfHit = millis() + 100;
        comboTimer = millis() + 500;
        hitting = true;
        comboCounterBasic += 1;
        comboTimerADV = millis()+300;
      }
      if (key == '1') {
        blocking = false;
        block = 0;
      }
      if (key == '2') {
        if (chakra == 300) {
          currentChakraPosition = x;
          chakraOn = true;
          chakra = 0;
          if (direction == 0) {
            chakraDirection = 0;
          }
          if (direction == 1) {
            chakraDirection = 1;
          }
        }
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

  void stopMoving() {
    moveLeft = false;
    moveRight = false;
    jump = false;
  }

  void movement() {
    //if jump is true and if millis  is less than millis + 100ms then jump
    if (jump) {
      if (millis() <= timeOfJump ) {
        y -= 55;
      }
    }
    //update movement for x 
    if (moveLeft) {
      direction = 0;
      if (touching != 1) {
        x -= dx;
      }
    }

    if (moveRight) {
      direction = 1;
      if (touching != 2) {
        x += dx;
      }
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
    } else {
      hitting = false;
    }
  }

  void comboDetector() {
    if (comboTimer >= millis()) {
      if (comboCounterBasic == 3) {
        attack = 5;
      }
    }
    if (comboTimer < millis()) {
      comboCounterBasic = 0;
      attack = 2.5;
    }
    if (comboTimerADV >= millis()) {
      if (comboCounterADV  == 2) {
        if (comboCounterBasic == 2) {
          attack = 10;
        }
      }
    }
    if (comboTimerADV < millis()) {
      comboCounterADV = 0;
      attack = 2.5;
    }
  }

  void chakraSpecial(Player otherPlayer) {
    float distanceFromChakraBall = dist(currentChakraPosition, y, otherPlayer.x, otherPlayer.y);
    float chakraRadius = 10 + otherPlayer.radius;
    if (chakraOn) {
      chakraShot.append(player);
      if (chakraShot.size() > 0) {
        if (distanceFromChakraBall <= chakraRadius) {
          otherPlayer.currentPlayerHealth.gotHit(16);
        }
        if (chakraDirection == 0) {
          currentChakraPosition -= 20;
        }
        if (chakraDirection == 1) {
          currentChakraPosition += 20;
        }
        rect(currentChakraPosition, 600, 50, 50);
      }
    }
  }


  void blockCheck(Player otherPlayer) {
    if (blocking == true ) { 
      attack = 0;
      if (direction == 0 && x > otherPlayer.x) {
        otherPlayer.attack = .75;
      } else if (direction == 1 && x < otherPlayer.x) {
        otherPlayer.attack = .75;
      } else {
        otherPlayer.attack = 2.5;
      }
    } else {
      otherPlayer.attack = 2.5;
    }
  }

  void knockback(Player otherPlayer) {
    if ((direction == 0 && otherPlayer.direction == 1) || (direction == 0 && otherPlayer.direction == 0)) {
      otherPlayer.knockbackTimer = millis() + 500;
      if (otherPlayer.knockbackTimer > millis()) {
        if (otherPlayer.blocking) { 
          otherPlayer.x-=2.5;
        } else {
          otherPlayer.x-=10;
        }
      }
    }
    if ((direction == 1 && otherPlayer.direction == 0) || (direction == 1 && otherPlayer.direction == 1)) {
      otherPlayer.knockbackTimer = millis() + 500;
      if (otherPlayer.knockbackTimer > millis()) {
        if (otherPlayer.blocking) { 
          otherPlayer.x+=2.5;
        } else {
          otherPlayer.x+=10;
        }
      }
    }
  }


  void collisionDetection(Player otherPlayer) {
    if (x+50 == otherPlayer.x-50) {
      touching = 2;
      otherPlayer.touching = 1;
    } else if (x - 50 == otherPlayer.x + 50) {
      touching = 1;
      otherPlayer.touching = 2;
    } else {
      touching = 0;
      otherPlayer.touching = 0;
    }
  }


  void headCollision(Player otherPlayer) { 
    if (((x+50 <= otherPlayer.x+50) && (x+50 >= otherPlayer.x-50) &&((y + 100 <= otherPlayer.y - 100)))||((x-50 >= otherPlayer.x-50) && (x-50 <= otherPlayer.x+50) && ((y + 100 <= otherPlayer.y)))) {
      if (direction == 0) {
        x-=5;
        y-=5;
      }
      if (direction == 1) {
        x+=5; 
        y-=5;
      }
    }
  }

  void border() {
    if (x+50 > width) {
      x = width - 50;
    }
    if (x-50 < 0) {
      x = 0 + 50;
    }
  }



  void playerFunc(Player otherPlayer) {
    //take in other player's data
    //gravity, movement, and .display applied to self
    movement();

    currentPlayerHealth.display();
    blockCheck(otherPlayer);
    headCollision(otherPlayer);
    collisionDetection(otherPlayer);
    comboDetector();
    currentPlayerChakra.display(chakra);
    chakraSpecial(otherPlayer); 
    death();
    hitting(otherPlayer);
    gravity();
    border();
  }

  void display() {
    //change player colours
    rectMode(CENTER);
    if (player == 1) {
      //currentPlayerAnimation.moveLeft();
      //imageMode(CENTER);
      //image(currentPlayerAnimation.narutoAnimationMoveLeft[counter], x,y,100,100);
      //if (frameCount % 2 == 0){
      // counter++;
      // counter = counter % currentPlayerAnimation.narutoAnimationMoveLeft.length;



      fill(252, 188, 40);
      rect(x, y, 100, 200);
      if (direction == 0) {
        fill(252, 188, block);
        rect(x-50, y, 50, 50);
      }
      if (direction == 1) {
        fill(252, 188, block);
        rect(x+50, y, 50, 50);
      }
    }

    if (player == 2) {
      fill(0, 34, 160);
      rect(x, y, 100, 200);

      if (direction == 0) {
        fill(0, 34, block);
        rect(x-50, y, 50, 50);
      }
      if (direction == 1) {
        fill(0, 34, block);
        rect(x+50, y, 50, 50);
      }
    }
  }
}