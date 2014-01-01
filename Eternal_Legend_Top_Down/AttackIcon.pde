class AttackIcon
{
  PVector loc;
  float maxSize, size;
  int lifeLength, age, DAMAGE;
  boolean active, bad;

  AttackIcon(PVector loc, int lifeLength, int DAMAGE, boolean bad)
  {
    this.DAMAGE = DAMAGE;
    maxSize = width * 0.075;
    this.lifeLength = lifeLength;
    age = 0;
    maxSize = width * .075;
    this.loc = loc;
    active = true;
    this.bad = bad;
    size = 1;
  }

  void show()
  {
    stroke(127);
    if (bad)
      fill(255, 0, 0);
    else
      fill(0, 255, 0);
    float lifeLeft = lifeLength - age;
    float fractionOfLife = lifeLeft / lifeLength;
    size = fractionOfLife * maxSize;
    ellipse(loc.x, loc.y, size, size);
  }

  void run()
  {
    age ++;
    if (active && age > lifeLength)
    {
      active = false;
      atkIcons.remove(this);
      if (!bad)
        p.hp -= DAMAGE;
    }
  }
}
