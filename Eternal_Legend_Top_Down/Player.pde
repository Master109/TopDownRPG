class Player
{
  PVector loc;
  float SIZE, SIGHT_RADIUS, gold;
  int speed, moveTimer, hp, damage, maxHP, hands;

  Player(PVector loc, int speed, int damage, int maxHP)
  {
    this.loc = loc;
    SIZE = width * 0.025;
    this.speed = speed;
    this.damage = damage;
    this.maxHP = maxHP;
    hp = maxHP;
    hands = 0;
    gold = 0;
    SIGHT_RADIUS = width * .5;
  }

  void show()
  {
    stroke(0);
    fill(255);
    ellipse(loc.x, loc.y, SIZE, SIZE);
    noStroke();
    fill(255, 75);
    ellipse(loc.x, loc.y, SIGHT_RADIUS, SIGHT_RADIUS);
  }

  void run()
  {
    moveTimer ++;
    if (moveTimer > speed)
    {
      moveTimer = 0;
      if (keys[0] && !rowStr.get(int(loc.y / SPACE_SIZE - 1)).get(int(loc.x / SPACE_SIZE)).equals("xx"))
      {
        loc.y -= SPACE_SIZE;
        //keys2[0] = false;
      }
      else if (keys[1] && !rowStr.get(int(loc.y / SPACE_SIZE)).get(int(loc.x / SPACE_SIZE + 1)).equals("xx"))
      {
        loc.x += SPACE_SIZE;
        //keys2[1] = false;
      }
      else if (keys[2] && !rowStr.get(int(loc.y / SPACE_SIZE + 1)).get(int(loc.x / SPACE_SIZE)).equals("xx"))
      {
        loc.y += SPACE_SIZE;
        //keys2[2] = false;
      }
      else if (keys[3] && !rowStr.get(int(loc.y / SPACE_SIZE)).get(int(loc.x / SPACE_SIZE - 1)).equals("xx"))
      {
        loc.x -= SPACE_SIZE;
        //keys2[3] = false;
      }
      if (rowStr.get(int(loc.y / SPACE_SIZE)).get(int(loc.x / SPACE_SIZE)).charAt(0) == 'A')
      {
        changeArea(rowStr.get(int(loc.y / SPACE_SIZE)).get(int(loc.x / SPACE_SIZE)));
      }
    }
    if (hp > maxHP)
      hp = maxHP;
  }
}
