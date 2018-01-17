class Button {
  //data
  float x, y, buttonWidth, buttonHeight;
  float top, bottom, left, right;
  int state;
  PImage startGame1, startGame2, options1, options2, back1, back2;
  int button;

  //constructor(s)
  Button(float _x, float _y, int _button) {
    //take in x, y, and button
    x = _x;
    y = _y;
    button = _button;
    //set button to 0 and then load button images
    state = 0;
    startGame1 = loadImage("Menu/startGame1.png");
    startGame2 = loadImage("Menu/startGame2.png");
    options1 = loadImage("Menu/options1.png");
    options2 = loadImage("Menu/options2.png");
    back1 = loadImage("Menu/back1.png");
    back2 = loadImage("Menu/back2.png");
  }

  //behaviour
  void calculator() {
    //calculate button size
    buttonWidth = width/4;
    buttonHeight = height/5;

    //calculate sides of button
    top = y;
    bottom = y + buttonHeight;
    left = x;
    right = x + buttonWidth;
  }

  boolean mouseIsOnButton() {
    //if all true return true
    return ((mouseX > left) &&
      (mouseX < right) &&
      (mouseY > top) &&
      (mouseY < bottom));
  }

  void display() {
    //if button is this button load image for on and off
    if (button == 0) {
      if (mouseIsOnButton()) {
        image(startGame2, x, y, buttonWidth, buttonHeight);
      } else {
        image(startGame1, x, y, buttonWidth, buttonHeight);
      }
    } else if (button == 1) {
      if (mouseIsOnButton()) {
        image(options2, x, y, buttonWidth, buttonHeight);
      } else {
        image(options1, x, y, buttonWidth, buttonHeight);
      }
    } else if (button == 2) {
      if (mouseIsOnButton()) {
        image(back2, x, y, buttonWidth, buttonHeight);
      } else {
        image(back1, x, y, buttonWidth, buttonHeight);
      }
    }
  }

  void mousePressed() {
    //if mouse is on button and pressed and is this button change state
    if (mouseIsOnButton()) {
      if (button == 0) {
        state = 1;
      }
      if (button == 1) {
        state = 2;
      }
      if (button == 2) {
        state = 3;
      }
    }
  }
}