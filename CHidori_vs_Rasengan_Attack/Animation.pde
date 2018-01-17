class Animation {
  //data
  //int
  int player;

  //Player
  Player character;

  //Arrays
  PImage [] narutoAnimationRight;
  PImage [] narutoAnimationLeft;
  PImage [] narutoAnimationJumpRight;
  PImage [] narutoAnimationJumpLeft;
  PImage [] narutoAnimationMoveRight;
  PImage [] narutoAnimationMoveLeft;
  PImage [] narutoAnimationAttackRight;
  PImage [] narutoAnimationAttackLeft;
  PImage [] narutoAnimationDamageLeft;
  PImage [] narutoAnimationDamageRight;
  PImage [] narutoAnimationSpecialRight;
  PImage [] narutoAnimationSpecialLeft;
  PImage [] narutoAnimationChakraRight;
  PImage [] narutoAnimationChakraLeft;

  PImage [] sasukeAnimationRight;
  PImage [] sasukeAnimationLeft;
  PImage [] sasukeAnimationJumpRight;
  PImage [] sasukeAnimationJumpLeft;
  PImage [] sasukeAnimationMoveRight;
  PImage [] sasukeAnimationMoveLeft;     
  PImage [] sasukeAnimationAttackRight;
  PImage [] sasukeAnimationAttackLeft; 
  PImage [] sasukeAnimationDamageLeft;
  PImage [] sasukeAnimationDamageRight;
  PImage [] sasukeAnimationSpecialLeft;
  PImage [] sasukeAnimationSpecialRight;
  PImage [] sasukeAnimationChakraRight;
  PImage [] sasukeAnimationChakraLeft;

  //constructor
  Animation(int _player) {
    //take in player when calling animation
    player = _player;
  }

  void moveLeft() {
    sasukeAnimationMoveLeft = new PImage[6];
    narutoAnimationMoveLeft = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationMoveLeft.length; frame++) {
        narutoAnimationMoveLeft[frame] = loadImage("Naruto/AnimationMoveLeft/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationMoveLeft.length; frame++) {
        sasukeAnimationMoveLeft[frame] = loadImage("Sasuke/AnimationMoveLeft/" + frame + ".png");
      }
    }
  }

  void moveRight() {
    sasukeAnimationMoveRight = new PImage[6];
    narutoAnimationMoveRight = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationMoveRight.length; frame++) {
        narutoAnimationMoveRight[frame] = loadImage("Naruto/AnimationMoveRight/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationMoveRight.length; frame++) {
        sasukeAnimationMoveRight[frame] = loadImage("Sasuke/AnimationMoveRight/" + frame + ".png");
      }
    }
  }

  void right() {
    sasukeAnimationRight = new PImage[6];
    narutoAnimationRight = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationRight.length; frame++) {
        narutoAnimationRight[frame] = loadImage("Naruto/AnimationRight/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationRight.length; frame++) {
        sasukeAnimationRight[frame] = loadImage("Sasuke/AnimationRight/" + frame + ".png");
      }
    }
  }

  void left() {
    sasukeAnimationLeft = new PImage[6];
    narutoAnimationLeft = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationLeft.length; frame++) {
        narutoAnimationLeft[frame] = loadImage("Naruto/AnimationLeft/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationLeft.length; frame++) {
        sasukeAnimationLeft[frame] = loadImage("Sasuke/AnimationLeft/" + frame + ".png");
      }
    }
  }

  void jumpRight() {
    sasukeAnimationJumpRight = new PImage[6];
    narutoAnimationJumpRight = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationJumpRight.length; frame++) {
        narutoAnimationJumpRight[frame] = loadImage("Naruto/AnimationJumpRight/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationJumpRight.length; frame++) {
        sasukeAnimationJumpRight[frame] = loadImage("Sasuke/AnimationJumpRight/" + frame + ".png");
      }
    }
  }

  void jumpLeft() {
    sasukeAnimationJumpLeft = new PImage[6];
    narutoAnimationJumpLeft = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationJumpLeft.length; frame++) {
        narutoAnimationJumpLeft[frame] = loadImage("Naruto/AnimationJumpLeft/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationJumpLeft.length; frame++) {
        sasukeAnimationJumpLeft[frame] = loadImage("Sasuke/AnimationJumpLeft/" + frame + ".png");
      }
    }
  }

  void attackLeft() {
    sasukeAnimationAttackLeft = new PImage[6];
    narutoAnimationAttackLeft = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationAttackLeft.length; frame++) {
        narutoAnimationAttackLeft[frame] = loadImage("Naruto/AnimationAttackLeft/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationAttackLeft.length; frame++) {
        sasukeAnimationAttackLeft[frame] = loadImage("Sasuke/AnimationAttackLeft/" + frame + ".png");
      }
    }
  }

  void attackRight() {
    sasukeAnimationAttackRight = new PImage[6];
    narutoAnimationAttackRight = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationAttackRight.length; frame++) {
        narutoAnimationAttackRight[frame] = loadImage("Naruto/AnimationAttackRight/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationAttackRight.length; frame++) {
        sasukeAnimationAttackRight[frame] = loadImage("Sasuke/AnimationAttackRight/" + frame + ".png");
      }
    }
  }

  void specialRight() {
    sasukeAnimationSpecialRight = new PImage[6];
    narutoAnimationSpecialRight = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationSpecialRight.length; frame++) {
        narutoAnimationSpecialRight[frame] = loadImage("Naruto/AnimationSpecialRight/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationSpecialRight.length; frame++) {
        sasukeAnimationSpecialRight[frame] = loadImage("Sasuke/AnimationSpecialRight/" + frame + ".png");
      }
    }
  }

  void specialLeft() {
    sasukeAnimationSpecialLeft = new PImage[6];
    narutoAnimationSpecialLeft = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationSpecialLeft.length; frame++) {
        narutoAnimationSpecialLeft[frame] = loadImage("Naruto/AnimationSpecialLeft/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationSpecialLeft.length; frame++) {
        sasukeAnimationSpecialLeft[frame] = loadImage("Sasuke/AnimationSpecialLeft/" + frame + ".png");
      }
    }
  }

  void damageRight() {
    sasukeAnimationDamageRight = new PImage[6];
    narutoAnimationDamageRight = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationDamageRight.length; frame++) {
        narutoAnimationDamageRight[frame] = loadImage("Naruto/AnimationDamageRight/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationDamageRight.length; frame++) {
        sasukeAnimationDamageRight[frame] = loadImage("Sasuke/AnimationDamageRight/" + frame + ".png");
      }
    }
  }

  void damageLeft() {
    sasukeAnimationDamageLeft = new PImage[6];
    narutoAnimationDamageLeft = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationDamageLeft.length; frame++) {
        narutoAnimationDamageLeft[frame] = loadImage("Naruto/AnimationDamageLeft/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationDamageLeft.length; frame++) {
        sasukeAnimationDamageLeft[frame] = loadImage("Sasuke/AnimationDamageLeft/" + frame + ".png");
      }
    }
  }

  void chakraRight() {
    sasukeAnimationChakraRight = new PImage[6];
    narutoAnimationChakraRight = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationChakraRight.length; frame++) {
        narutoAnimationChakraRight[frame] = loadImage("Naruto/AnimationChakraRight/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationChakraRight.length; frame++) {
        sasukeAnimationChakraRight[frame] = loadImage("Sasuke/AnimationChakraRight/" + frame + ".png");
      }
    }
  }

  void chakraLeft() {
    sasukeAnimationChakraLeft = new PImage[6];
    narutoAnimationChakraLeft = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationChakraLeft.length; frame++) {
        narutoAnimationChakraLeft[frame] = loadImage("Naruto/AnimationChakraLeft/" + frame + ".png");
      }
    }
    if (player == 2) {
      for (int frame = 0; frame < sasukeAnimationChakraLeft.length; frame++) {
        sasukeAnimationChakraLeft[frame] = loadImage("Sasuke/AnimationChakraLeft/" + frame + ".png");
      }
    }
  }
}