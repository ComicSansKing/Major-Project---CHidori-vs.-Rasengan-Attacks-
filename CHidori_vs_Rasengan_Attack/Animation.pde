class Animation {
  //NONE OF THIS WORKS YET!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  int player;
  Player character;


  PImage [] narutoAnimationRight;
  PImage [] narutoAnimationLeft;
  PImage [] narutoAnimationJumpRight;
  PImage [] narutoAnimationJumpLeft;
  PImage [] narutoAnimationMoveRight;
  PImage [] narutoAnimationMoveLeft;
  PImage [] narutoAnimationAttackRight;
  PImage [] narutoAnimationAttackLeft;

  PImage [] sasukeAnimationRight;
  PImage [] sasukeAnimationLeft;
  PImage [] sasukeAnimationJumpRight;
  PImage [] sasukeAnimationJumpLeft;
  PImage [] sasukeAnimationMoveRight;
  PImage [] sasukeAnimationMoveLeft;     
  PImage [] sasukeAnimationAttackRight;
  PImage [] sasukeAnimationAttackLeft; 


  //constructor

  Animation(int _player) {

    player = _player;



    //narutoAnimationRight = new PImage[6];
    //narutoAnimationLeft = new PImage[6];
    //narutoAnimationJumpRight = new PImage[5];
    //narutoAnimationJumpLeft = new PImage[5];
    //narutoAnimationMoveRight = new PImage[6];

    //narutoAnimationAttackRight = new PImage[6];
    //narutoAnimationAttackLeft = new PImage[6];

    //sasukeAnimationRight = new PImage[6];
    //sasukeAnimationLeft = new PImage[6];
    //sasukeAnimationJumpRight = new PImage[6];
    //sasukeAnimationJumpLeft = new PImage[6];
    //sasukeAnimationMoveRight = new PImage[6];

    //sasukeAnimationAttackRight = new PImage[6];
    //sasukeAnimationAttackLeft = new PImage[6];
  }


  void moveLeft() {
    sasukeAnimationMoveLeft = new PImage[6];
    narutoAnimationMoveLeft = new PImage[6];
    if (player == 1) {
      for (int frame = 0; frame < narutoAnimationMoveLeft.length; frame++) {
        narutoAnimationMoveLeft[frame] = loadImage("Naruto/AnimationMoveLeft/" + frame + ".png");
      }
    }
  }
}