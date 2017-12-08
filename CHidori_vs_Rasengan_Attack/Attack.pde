
class Attack {
  //data
  int player;
  int damage;
  float x, y;
  float dx, dy;


  //constructor(s)
  Attack(int _damage, float _x, float _y, float _dx, float _dy) {
    damage = _damage; 
    x = _x;
    y = _y;
    dx = _dx;
    dy = _dy;
  }

  //behaviour
  void meleeAttack(HP health) {
    fill(255, 0, 0);
    rectMode(CENTER);
    health.gotHit(damage);
    println("eatass");
  }
}