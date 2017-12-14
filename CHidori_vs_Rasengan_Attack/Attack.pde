class Attack {
  //data
  int player;
  float damage;
  float x, y;
  float dx, dy;

  //constructor(s)
  Attack( float _x, float _y, float _dx, float _dy) {
     
    x = _x;
    y = _y;
    dx = _dx;
    dy = _dy;
  }

  //behaviour
  void meleeAttack(HP health,float damage) {
    fill(255, 0, 0);
    rectMode(CENTER);
    //if hit take in damage
    health.gotHit(damage);
  }
}