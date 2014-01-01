class Enemy
{
  PVector loc;
  float SIZE, MIN_ICON_SPREAD, SIGHT_RADIUS;
  int defense, defenseTimer, defenseStay, offense, offenseTimer, offenseStay, DAMAGE, hp, maxHP, SPEED, moveTimer, gold;
  ArrayList loot;
  ArrayList<Integer> wayPointNums;
  ArrayList<PVector> branchLocs, path, idealPath, wayPoints;
  ArrayList<ArrayList<PVector>> paths;
  boolean explored, firstMove;
  String name;

  Enemy(PVector loc, int defense, int offense, int defenseStay, int offenseStay, String name, int DAMAGE, int maxHP, int SPEED, float SIGHT_RADIUS, int gold)
  {
    this.loc = loc;
    SIZE = SPACE_SIZE;
    this.defense = defense;
    this.offense = offense;
    defenseTimer = 0;
    offenseTimer = 0;
    this.defenseStay = defenseStay;
    this.offenseStay = offenseStay;
    MIN_ICON_SPREAD = width * .2;
    this.DAMAGE = DAMAGE;
    this.maxHP = maxHP;
    hp = maxHP;
    this.SPEED = SPEED;
    loot = new ArrayList();
    this.SIGHT_RADIUS = SIGHT_RADIUS;
    this.gold = gold;
    explored = false;
    this.name = name;
    firstMove = true;
    wayPoints = new ArrayList<PVector>();
    wayPointNums = new ArrayList<Integer>();
    idealPath = new ArrayList<PVector>();
  }

  void show()
  {
    stroke(0);
    fill(255, 0, 0);
    ellipse(loc.x, loc.y, SIZE, SIZE);
    noStroke();
    fill(255, 0, 0, 75);
    ellipse(loc.x, loc.y, SIGHT_RADIUS, SIGHT_RADIUS);
  }

  void run()
  {
    if (loc.dist(p.loc) <= p.SIGHT_RADIUS / 2)
      explored = true;
    if (loc.dist(p.loc) <= SIGHT_RADIUS / 2)
    {
      moveTimer ++;
      if (firstMove)
      {
        firstMove = false;
        path = new ArrayList<PVector>();
        if (!rowStr.get(int(p.loc.y / SPACE_SIZE)).get(int(p.loc.x / SPACE_SIZE + 1)).equals("xx"))
        {
          wayPoints.add(new PVector(p.loc.x + SPACE_SIZE, p.loc.y));
          wayPointNums.add(1);
        }
        if (!rowStr.get(int(p.loc.y / SPACE_SIZE)).get(int(p.loc.x / SPACE_SIZE - 1)).equals("xx"))
        {
          wayPoints.add(new PVector(p.loc.x - SPACE_SIZE, p.loc.y));
          wayPointNums.add(1);
        }
        if (!rowStr.get(int(p.loc.y / SPACE_SIZE - 1)).get(int(p.loc.x / SPACE_SIZE)).equals("xx"))
        {
          wayPoints.add(new PVector(p.loc.x, p.loc.y - SPACE_SIZE));
          wayPointNums.add(1);
        }        
        if (!rowStr.get(int(p.loc.y / SPACE_SIZE + 1)).get(int(p.loc.x / SPACE_SIZE)).equals("xx"))
        {
          wayPoints.add(new PVector(p.loc.x, p.loc.y + SPACE_SIZE));
          wayPointNums.add(1);
        }
        while (true)
        {
          println(wayPoints.size());
          boolean blocked = true;
          //ArrayList nextWayPoints = new ArrayList();
          int minWayPoint = (Integer) wayPointNums.get(1);
          for (int i = 1; i < wayPoints.size(); i += 2)
          {
            if ((Integer) wayPointNums.get(i) > minWayPoint)
              minWayPoint = i;
          }
          PVector nextWayPoint = (PVector) wayPoints.get(minWayPoint - 1);
          if (!rowStr.get(int(nextWayPoint.y / SPACE_SIZE)).get(int(nextWayPoint.x / SPACE_SIZE + 1)).equals("xx"))
          {
            wayPoints.add(new PVector(nextWayPoint.x + SPACE_SIZE, nextWayPoint.y));
            wayPointNums.add(minWayPoint + 1);              
            blocked = false;
          }
          if (!rowStr.get(int(nextWayPoint.y / SPACE_SIZE)).get(int(nextWayPoint.x / SPACE_SIZE - 1)).equals("xx"))
          {
            wayPoints.add(new PVector(nextWayPoint.x - SPACE_SIZE, nextWayPoint.y));
            wayPointNums.add(minWayPoint + 1);            
            blocked = false;
          }

          if (!rowStr.get(int(nextWayPoint.y / SPACE_SIZE - 1)).get(int(nextWayPoint.x / SPACE_SIZE)).equals("xx"))
          {
            wayPoints.add(new PVector(nextWayPoint.x, nextWayPoint.y - SPACE_SIZE));
            wayPointNums.add(minWayPoint + 1);            
            blocked = false;
          }        
          if (!rowStr.get(int(nextWayPoint.y / SPACE_SIZE + 1)).get(int(nextWayPoint.x / SPACE_SIZE)).equals("xx"))
          {
            wayPoints.add(new PVector(nextWayPoint.x, nextWayPoint.y + SPACE_SIZE));
            wayPointNums.add(minWayPoint + 1);            
            blocked = false;
          }
          (int) wayPointNums.get(minWayPoint) = MAX_INT;
        }
        idealPath = wayPoints;
      }
    }
    else
    {
      moveTimer = 0;
      //paths = new ArrayList<ArrayList<PVector>>();
      idealPath = new ArrayList<PVector>();
      //branchLocs = new ArrayList<PVector>();
      wayPoints = new ArrayList<PVector>();
      //firstMove = true;
    }
    if (moveTimer > SPEED)
    {
      moveTimer = 0;
      for (int i = 0; i < wayPoints.size(); i += 2)
      {
        PVector p = (PVector) wayPoints.get(i);
        PVector p2 = (PVector)wayPoints.get(wayPoints.size() - 2);
        if (p2  .dist(p) == SPACE_SIZE && (Integer)wayPoints.get(wayPoints.size() - 1) - (Integer)wayPoints.get(i + 1) == 1)
          loc.set((PVector) wayPoints.get(i));
      }
    }
    if (loc.dist(p.loc) == 0)
    {
      //firstBattle = true;
      camera(width / 2, height / 2, (height/2.0) / tan(PI*30.0 / 180.0) * 1.0, width / 2, height / 2, 0, 0, 1, 0);
      atkIcons.clear();
      battle = true;
    }
  }

  void fight()
  {
    if (p.hp <= 0)
      restart(true, "");
    if (hp <= 0)
    {
      battle = false;
      p.gold += gold;
      inventory.addAll(loot);
      if (inventory.size() > 0 && firstItem)
      {
        firstItem = false;
        dialogs.add(new Dialog(new String[] {
          "The enemy dropped an item! Press [i] at any time|to view your inventory. Click on an item to use it,|or drag it onto the world to destroy it. Mouse over|an item to view its properties. Items will not be|visible in battle if you are not able to use them.|"
        }
        ));
        dialogsTotal.add(3);
      }
      enemies.remove(this);
    }
    defenseTimer ++;
    if (defenseTimer > defense)
    {
      defenseTimer = 0;
      atkIcons.add(new AttackIcon(new PVector(random(SIZE / 2, width - (SIZE / 2)), random(SIZE / 2, height - (SIZE / 2))), defenseStay, DAMAGE, false));
      if (atkIcons.size() > 1)
      {
        AttackIcon a = atkIcons.get(atkIcons.size() - 1);
        AttackIcon a2 = atkIcons.get(atkIcons.size() - 2);
        while (a.loc.dist (a2.loc) < MIN_ICON_SPREAD)
        {
          atkIcons.remove(a);
          atkIcons.add(new AttackIcon(new PVector(random(SIZE / 2, width - (SIZE / 2)), random(SIZE / 2, height - (SIZE / 2))), defenseStay, DAMAGE, false));
          a = atkIcons.get(atkIcons.size() - 1);
          a2 = atkIcons.get(atkIcons.size() - 2);
        }
      }
    }
    offenseTimer ++;
    if (offenseTimer > offense && offense != -1)
    {
      offenseTimer = 0;
      atkIcons.add(new AttackIcon(new PVector(random(SIZE / 2, width - (SIZE / 2)), random(SIZE / 2, height - (SIZE / 2))), defenseStay, DAMAGE, true));
      if (atkIcons.size() > 1)
      {
        AttackIcon a = atkIcons.get(atkIcons.size() - 1);
        AttackIcon a2 = atkIcons.get(atkIcons.size() - 2);
        while (a.loc.dist (a2.loc) < MIN_ICON_SPREAD)
        {
          atkIcons.remove(a);
          atkIcons.add(new AttackIcon(new PVector(random(SIZE / 2, width - (SIZE / 2)), random(SIZE / 2, height - (SIZE / 2))), defenseStay, DAMAGE, true));
          a = atkIcons.get(atkIcons.size() - 1);
          a2 = atkIcons.get(atkIcons.size() - 2);
        }
      }
    }
    if (mouseJustPressed && atkIcons.size() > 0 && !keys[4])
    {
      int collisionTests = atkIcons.size();
      for (int i = 0; i < atkIcons.size(); i ++)
      {
        AttackIcon a = atkIcons.get(i);
        //mouseLoc = PVector.mult(new PVector(mouseX * CAMERA_ZOOM, mouseY * CAMERA_ZOOM), 1);
        //println(a.loc.dist(new PVector(mouseX, mouseY)));
        if (a.loc.dist(new PVector(mouseX, mouseY)) <= a.size / 2 && !keys[4])
        {
          a.active = false;
          atkIcons.remove(a);
          if (!a.bad && !keys[4])
          {
            hp -= p.damage;
            break;
          }
          else if (!keys[4])
          {
            p.hp -= DAMAGE;
            break;
          }
        }
        else if (!keys[4])
          collisionTests --;
      }
      if (collisionTests == 0 && !keys[4])
      {
        p.hp -= DAMAGE;
        //println("MISS");
      }
      mouseJustPressed = false;
    }
    rectMode(CORNERS);
    //fill(0);
    //rect(0, height - 25, width, height);
    float playerHPFraction = float(p.hp) / p.maxHP;
    float enemyHPFraction = float(hp) / maxHP;
    //println(hpFraction);
    //println("HP: " + p.hp);
    //println("MAX HP: " + p.maxHP);
    stroke(255);
    fill(255, 0, 0);
    rect(0, height * .025, width * enemyHPFraction, 0);
    fill(0, 255, 0);
    rect(0, height - (height * .025), width * playerHPFraction, height);
    fill(255);
    textAlign(CENTER, BASELINE);
    text(name, width / 2, height * .025 + fontSize);
  }
}

