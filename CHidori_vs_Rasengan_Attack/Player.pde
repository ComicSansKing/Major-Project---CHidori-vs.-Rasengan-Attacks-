class Player {  //<>//
  //data
  //movement
  float x, y;
  float dx, dy;
  float radius;
  float speed;
  float gravity = .2;
  float timeOfJump;
  int direction;
  boolean bounce;
  boolean jump, moveLeft, moveRight;

  //player
  int player;
  float health;
  int death;

  //attack
  int touching;
  float attack = 2.5;
  float block;
  int knockBackValue;
  float knockbackTimer;
  boolean hurt;
  float timeOfHit;
  boolean hitting;
  boolean blocking;
  int counter;

  //combo
  float comboTimer;
  float comboTimerADV;
  int comboCounterBasic;
  int comboCounterADV;

  //chakra
  boolean chakraOn = false;
  int chakraDirection;
  float chakraTimer;
  float currentChakraPosition;
  int chakra;
  FloatList chakraShot = new FloatList();

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
    //set player direction to begin with, 1 = facing right, 2 = facing left 
    if (player == 1) {
      direction = 1;
    }
    if (player == 2) {
      direction = 0;
    }
    //call current health and attack for each player, updates per player
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
        //applies knockback to player who is attacked
        knockback(otherPlayer);
        //otherPlayer changes to hurt animation 
        otherPlayer.hurt = true;

        //if you attack then add 3 to chakra, if you are attacked add 5 to chakra
        chakra += 3;
        otherPlayer.chakra += 5;

        //if chakra goes over the 300 limit it is equal to 300
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
      }
      if (key == 'd'|| key == 'D') {
        moveRight = true;
      }
      if (key == 'g'|| key == 'G') {
        blocking = true;
      }
    }
    if (player == 2) {
      if (keyCode == UP) {
        if (y == 600) {
          timeOfJump = millis() + 100;
          jump = true;
        }
      }
      if (keyCode == LEFT) {
        moveLeft = true;
      }

      if (keyCode == RIGHT) {

        moveRight = true;
      }
      if (key == '1') {
        blocking = true;
      }
    }
    //stops you from moving when you are blocking
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
        //start the advanced combo counter, set a time limit to press next key
        comboCounterADV +=1;
        comboTimerADV = millis()+300;
      }

      if (key == 'f' || key == 'F') {
        //increases combo counter and timer, increases combo timer advanced, and sets hitting to true
        timeOfHit = millis() + 100;
        hitting = true;
        comboCounterBasic += 1;
        comboTimer = millis() + 500;
        comboTimerADV = millis()+300;
      }
      if (key == 'g'|| key == 'G') {
        blocking = false;
      }
      if (key == 'q' || key ==  'Q') {
        //turns chakra on and sets a timer, sets position to x which moves later in the code
        if (chakra == 300) {
          currentChakraPosition = x;
          chakraOn = true;
          chakra = 0;
          chakraTimer = millis()+150;
          //chakra direction is equal to direction player was facing when shot 
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
        //start the advanced combo counter, set a time limit to press next key
        comboCounterADV +=1;
        comboTimerADV = millis()+300;
      }

      if (key == '0') {
        //increases combo counter and timer, increases combo timer advanced, and sets hitting to true
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
        //turns chakra on and sets a timer, sets position to x which moves later in the code
        if (chakra == 300) {
          currentChakraPosition = x;
          chakraOn = true;
          chakraTimer = millis()+150;
          chakra = 0;
          //chakra direction is equal to direction player was facing when shot 
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
    //y will equal itself + speed, speed equals itself + gravity
    y = y + speed;
    speed = speed + gravity;
    //if you are above 600 your speed midair is 0, if you are above 650 then start descending at a rate of 12
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
      } else {
        jump = false;
      }
    }
    //update movement for x depending on direction and if not touching other player
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
    //if health hits 0 then die
    if (currentPlayerHealth.health <= 0) {
      death = 1;
    }
  }

  void hitting(Player otherPlayer) {
    //if you hit the player and your millis are less than the hit timer then check collision and if colliding hit and take away health
    if (hitting && millis() <= timeOfHit ) { 
      checkIfCollidingWith(otherPlayer);
      currentPlayerHealth.display();
    }
    //else set hitting and hurt animation to false
    else {
      hitting = false;
      otherPlayer.hurt = false;
    }
  }

  void comboDetector() {
    //if the combo time is greater then millis and the counter = 3 then change attack to 5
    if (comboTimer >= millis()) {
      if (comboCounterBasic == 3) {
        if (blocking == false) {
          attack = 5;
        }
      }
    }
    //if combo time is less then millis then change attack back to 2.5 and counter now = 0
    if (comboTimer < millis()) {
      comboCounterBasic = 0;
      attack = 2.5;
    }
    //if time is greater then millis, advanced counter = 2, and regular counter = 2, then change attack to 10
    if (comboTimerADV >= millis()) {
      if (comboCounterADV  == 2) {
        if (comboCounterBasic == 2) {
          if (blocking == false) {
            attack = 10;
          }
        }
      }
    }
    //if the advanced timer is less then millis set counter to 0 and attack back to normal 2.5
    if (comboTimerADV < millis()) {
      comboCounterADV = 0;
      attack = 2.5;
    }
  }

  void chakraSpecial(Player otherPlayer) {
    float distanceFromChakraBall = dist(currentChakraPosition, y, otherPlayer.x, otherPlayer.y);
    float chakraRadius = 10 + otherPlayer.radius;
    if (currentChakraPosition > width || currentChakraPosition < 0) {
      chakraOn = false;
    }
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

        if (player == 2) {
          if (direction == 1 && chakraOn ) {
            currentPlayerAnimation.chakraRight();
            imageMode(CENTER);
            image(currentPlayerAnimation.sasukeAnimationChakraRight[counter], currentChakraPosition, 600, 100, 100);
            if (frameCount % 2 == 0) {
              counter++;
              counter = counter % currentPlayerAnimation.sasukeAnimationChakraRight.length;
            }
          }
          if (direction == 0 && chakraOn) {
            currentPlayerAnimation.chakraLeft();
            imageMode(CENTER);
            image(currentPlayerAnimation.sasukeAnimationChakraLeft[counter], currentChakraPosition, 600, 100, 100);
            if (frameCount % 2 == 0) {
              counter++;
              counter = counter % currentPlayerAnimation.sasukeAnimationChakraLeft.length;
            }
          }
        }
        if (player == 1) {
          if (direction == 1 && chakraOn ) {
            currentPlayerAnimation.chakraRight();
            imageMode(CENTER);
            image(currentPlayerAnimation.narutoAnimationChakraRight[counter], currentChakraPosition, 600, 100, 100);
            if (frameCount % 2 == 0) {
              counter++;
              counter = counter % currentPlayerAnimation.narutoAnimationChakraRight.length;
            }
          }
          if (direction == 0 && chakraOn) {
            currentPlayerAnimation.chakraLeft();
            imageMode(CENTER);
            image(currentPlayerAnimation.narutoAnimationChakraLeft[counter], currentChakraPosition, 600, 100, 100);
            if (frameCount % 2 == 0) {
              counter++;
              counter = counter % currentPlayerAnimation.narutoAnimationChakraLeft.length;
            }
          }
        }
      }
    }
  }


  void blockCheck(Player otherPlayer) {
    //if your blocking is true then attack = 0
    if (blocking) { 
      attack = 0;
      //if player 1 direction is left and x is greater than player 2 then player 2 attack is set to 0.75
      if (direction == 0 && x > otherPlayer.x) {
        otherPlayer.attack = .75;
        //if player 1 direction is right and x is less than player 2 then player 2 attack is set to 0.75
      } else if (direction == 1 && x < otherPlayer.x) {
        otherPlayer.attack = .75;
        //else reset attack to 2.5
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
    //if the x of the players are equal to each other minus the size of player then they are touching
    if (x+50 == otherPlayer.x-50) {
      touching = 2;
      otherPlayer.touching = 1;
    } else if (x - 50 == otherPlayer.x + 50) {
      touching = 1;
      otherPlayer.touching = 2;
      //else they are not touching
    } else {
      touching = 0;
      otherPlayer.touching = 0;
    }
  }


  void headCollision(Player otherPlayer) { 
    //if all conditions true then bounce off of head of plater, DOES NOT WORK
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
    //if x + player size is greater then width then do not pass
    if (x + 50 > width) {
      x = width - 50;
    }
    //if x - player size is less then 0 then do not pass
    if (x - 50 < 0) {
      x = 0 + 50;
    }
  }

  void playerFunc(Player otherPlayer) {
    //take in other player's data
    //gravity, movement, and .display applied to self
    //calls all functions
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
    rectMode(CENTER);
    if (player == 1) {
      //move left
      if (moveLeft&& jump == false && y == 600 && !hitting && !hurt && !moveRight) {
        currentPlayerAnimation.moveLeft();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationMoveLeft[counter], x, y, 100, 100);
        if (frameCount % 10 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationMoveLeft.length;
        }
      }
      //move right
      if (moveRight && jump == false && y == 600 && !hitting && !hurt && !moveLeft) {
        currentPlayerAnimation.moveRight();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationMoveRight[counter], x, y, 100, 100);
        if (frameCount % 10 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationMoveRight.length;
        }
      }
      //idle right
      if (direction == 1 && !moveRight && !jump && y == 600 && !hitting && !hurt || (moveRight && moveLeft && direction == 1)) {
        currentPlayerAnimation.right();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationRight[counter], x, y, 100, 100);
        if (frameCount % 10 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationRight.length;
        }
      }
      //idle left
      if (direction == 0 && !moveLeft && !jump && y == 600 && !hitting && !hurt || (moveRight && moveLeft && direction == 0)) {
        currentPlayerAnimation.left();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationLeft[counter], x, y, 100, 100);
        if (frameCount % 10 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationLeft.length;
        }
      }
      //attack left
      if (direction == 0 && hitting && !jump && y == 600 && !hurt) {
        currentPlayerAnimation.attackLeft();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationAttackLeft[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationAttackLeft.length;
        }
      }
      //attack right
      if (direction == 1 && !jump && y == 600 && hitting && !hurt) {
        currentPlayerAnimation.attackRight();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationAttackRight[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationAttackRight.length;
        }
      }

      if (direction == 0 && chakraOn && y == 600 && !hitting && !hurt && chakraTimer > millis()) {
        currentPlayerAnimation.specialLeft();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationSpecialLeft[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationSpecialLeft.length;
        }
      }

      if (direction == 1 && chakraOn && y == 600 && !hitting && !hurt && chakraTimer > millis()) {
        currentPlayerAnimation.specialRight();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationSpecialRight[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationSpecialRight.length;
        }
      }

      if (direction == 1 && hurt) {
        currentPlayerAnimation.damageRight();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationDamageRight[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationDamageRight.length;
        }
      }

      if (direction == 0 && hurt) {
        currentPlayerAnimation.damageLeft();
        imageMode(CENTER);
        image(currentPlayerAnimation.narutoAnimationDamageLeft[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationDamageLeft.length;
        }
      }

      //jump right
      if (direction == 1 && jump || y != 600 && jump == false && direction == 1 && !hurt ) {
        currentPlayerAnimation.jumpRight();
        imageMode(CENTER);
        if (y != 600 && jump == false && direction == 1) {
          image(currentPlayerAnimation.narutoAnimationJumpRight[1], x, y, 100, 100);
        } else {
          image(currentPlayerAnimation.narutoAnimationJumpRight[counter], x, y, 100, 100);
        }
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationJumpRight.length;
        }
      }

      //jump left
      if (direction == 0 && jump || y != 600 && jump == false && direction == 0 && !hurt  ) {
        currentPlayerAnimation.jumpLeft();
        imageMode(CENTER);
        if (y != 600 && jump == false && direction == 0) {
          image(currentPlayerAnimation.narutoAnimationJumpLeft[1], x, y, 100, 100);
        } else {
          image(currentPlayerAnimation.narutoAnimationJumpLeft[counter], x, y, 100, 100);
        }
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.narutoAnimationJumpLeft.length;
        }
      }
    }

    if (player == 2) {
      //move left
      if (moveLeft&& jump == false && y == 600 && !hitting && !hurt&& chakraTimer < millis()) {
        currentPlayerAnimation.moveLeft();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationMoveLeft[counter], x, y, 100, 100);
        if (frameCount % 10 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationMoveLeft.length;
        }
      }
      //move right
      if (moveRight && jump == false && y == 600 && !hitting && !hurt&& chakraTimer < millis()) {
        currentPlayerAnimation.moveRight();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationMoveRight[counter], x, y, 100, 100);
        if (frameCount % 10 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationMoveRight.length;
        }
      }
      //idle right
      if (direction == 1 && !moveRight && !jump && y == 600 && !hitting && !hurt&& chakraTimer < millis()) {
        currentPlayerAnimation.right();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationRight[counter], x, y, 100, 100);
        if (frameCount % 10 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationRight.length;
        }
      }
      //idle left
      if (direction == 0 && !moveLeft && !jump && y == 600 && !hitting && !hurt&& chakraTimer < millis()) {
        currentPlayerAnimation.left();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationLeft[counter], x, y, 100, 100);
        if (frameCount % 10 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationLeft.length;
        }
      }
      //attack left
      if (direction == 0 && hitting && !jump && y == 600 && !hurt) {
        currentPlayerAnimation.attackLeft();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationAttackLeft[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationAttackLeft.length;
        }
      }
      //attack right
      if (direction == 1 && !jump && y == 600 && hitting && !hurt) {
        currentPlayerAnimation.attackRight();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationAttackRight[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationAttackRight.length;
        }
      }

      if (direction == 0 && chakraOn && y == 600 && !hitting && !hurt && chakraTimer > millis()) {
        currentPlayerAnimation.specialLeft();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationSpecialLeft[counter], x, y, 100, 100);
        if (frameCount % 5 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationSpecialLeft.length;
        }
      }

      if (direction == 1 && chakraOn && y == 600 && !hitting && !hurt && chakraTimer > millis()) {
        currentPlayerAnimation.specialRight();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationSpecialRight[counter], x, y, 100, 100);
        if (frameCount % 5 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationSpecialRight.length;
        }
      }

      if (direction == 1 && hurt) {
        currentPlayerAnimation.damageRight();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationDamageRight[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationDamageRight.length;
        }
      }

      if (direction == 0 && hurt) {
        currentPlayerAnimation.damageLeft();
        imageMode(CENTER);
        image(currentPlayerAnimation.sasukeAnimationDamageLeft[counter], x, y, 100, 100);
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationDamageLeft.length;
        }
      }

      //jump right
      if (direction == 1 && jump || y != 600 && jump == false && direction == 1 && !hurt  ) {
        currentPlayerAnimation.jumpRight();
        imageMode(CENTER);
        if (y != 600 && jump == false && direction == 1) {
          image(currentPlayerAnimation.sasukeAnimationJumpRight[3], x, y, 100, 100);
        } else {
          image(currentPlayerAnimation.sasukeAnimationJumpRight[counter], x, y, 100, 100);
        }
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationJumpRight.length;
        }
      }

      //jump left
      if (direction == 0 && jump || y != 600 && jump == false && direction == 0 && !hurt  ) {
        currentPlayerAnimation.jumpLeft();
        imageMode(CENTER);
        if (y != 600 && jump == false && direction == 0) {
          image(currentPlayerAnimation.sasukeAnimationJumpLeft[3], x, y, 100, 100);
        } else {
          image(currentPlayerAnimation.sasukeAnimationJumpLeft[counter], x, y, 100, 100);
        }
        if (frameCount % 2 == 0) {
          counter++;
          counter = counter % currentPlayerAnimation.sasukeAnimationJumpLeft.length;
        }
      }
    }

    if (blocking) {
      //draw an ellipse and set colour to different settings depending on character  
      if (player == 1) {
        fill(247, 183, 7, 50);
      }
      if (player == 2) {
        fill(47, 91, 181, 50);
      }
      ellipse(x, y, 125, 125);
    }
  }
}