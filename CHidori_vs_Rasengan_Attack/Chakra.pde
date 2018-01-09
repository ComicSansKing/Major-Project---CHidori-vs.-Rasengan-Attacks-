class Chakra {

  float chakra;
  int player;
  int x;

  //constructor
  Chakra(float _chakra, int _player) {
    chakra = _chakra;
    player = _player;
    if (player == 1) {
      x = 100;
    }
    if (player == 2) {
      x = 900;
    }
  }
  void display(int chakra) {
    //draw healthbar, changes colour and size, set to individual players
    rectMode(CORNER);
    if (player == 1) {
      fill(0);
      rect(width/14, height/15+10, 300, 15);

     fill(137, 182, 255);

      rect(width/14, height/15+10, chakra, 15);
    }
    if (player == 2) {
      fill(0);
      rect(width/9*5+300, height/15+10, 300, 15);

      fill(137, 182, 255);

      rect(width/9*5-chakra+600, height/15+10, chakra, 15);
    }
    rectMode(CENTER);
  }
}