Player p;
boolean[] keys, keys2;
PFont font;
ArrayList<Enemy> enemies;
ArrayList<AttackIcon> atkIcons;
ArrayList<Dialog> dialogs;
ArrayList dialogsTotal;
ArrayList<Space> spaces;
boolean battle, mouseJustPressed, runOnce, runOnce2, skipDialog, firstBattle, increaseR1, increaseR2, increaseR3, inMainMenu, canMoveCamera;
PVector mouseLoc, cameraOffset;
int fontSize, WORLD_SIZE_X, WORLD_SIZE_Y, carryCapacity;
String[] map, map2, currentMap, strToSave, healingPotion, bronzeDagger;
ArrayList<String> spaceStr;
ArrayList<ArrayList<String>> rowStr;
ArrayList<Item> inventory;
ArrayList<Conversation> conversations;
ArrayList conversationsTotal;
float r1, r2, r3, SPACE_SIZE;
float CAMERA_ZOOM = 1.0;

final int CAMERA_MOVE_BORDER = 50;

void setup()
{
  size(500, 500, P3D);
  smooth();
  frameRate(60);
  canMoveCamera = false;
  //rectMode(CENTER);
  font = loadFont("AngsanaNew-48.vlw");
  fontSize = int(width * .075);
  textFont(font, fontSize);
  keys = new boolean[5];
  keys2 = new boolean[4];
  SPACE_SIZE = width * 0.05;
  runOnce = true;
  runOnce2 = true;
  mouseJustPressed = false;
  map = new String[] {
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx oo oo oo xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx oo xx 01 oo oo oo xx oo oo oo xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx oo oo oo xx oo oo oo oo oo xx oo xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx oo oo xx oo oo oo oo xx oo 18 oo oo xx oo xx oo oo xx xx xx", 
    "xx xx xx xx xx xx xx xx oo oo oo oo oo oo 02 oo xx oo oo oo oo oo oo oo oo 03 oo oo xx", 
    "xx xx xx xx xx xx oo oo oo oo oo xx oo oo oo oo oo oo oo oo 04 oo oo xx oo xx oo oo xx", 
    "xx xx xx oo oo oo 05 oo oo xx oo oo oo xx oo oo xx oo oo xx oo oo oo oo oo 06 oo oo xx", 
    "xx xx oo oo xx oo oo oo xx oo oo oo oo oo s0 oo oo oo oo oo oo xx oo xx oo oo xx oo xx", 
    "xx AA oo oo oo oo xx oo xx oo oo 07 oo xx oo oo oo 08 xx oo oo oo oo oo oo oo oo oo xx", 
    "xx AB oo oo oo 08 oo oo oo xx oo oo oo oo xx oo oo oo xx oo oo xx oo 09 oo oo oo oo xx", 
    "xx AC oo xx oo xx oo oo oo oo oo xx oo 10 oo oo xx oo oo xx oo oo oo oo xx 11 oo oo xx", 
    "xx AD oo 12 oo oo xx oo oo xx oo oo oo oo oo oo oo xx oo oo oo xx oo oo oo xx oo xx xx", 
    "xx AE oo oo xx oo oo xx oo oo oo oo xx oo xx xx oo 13 oo oo oo oo oo oo xx xx xx xx xx", 
    "xx AF oo oo oo oo oo oo oo 14 oo oo oo oo oo oo oo oo xx oo xx oo oo xx xx xx xx xx xx", 
    "xx xx xx xx 15 oo oo xx oo xx oo xx oo 16 xx oo xx xx xx xx oo 17 oo xx xx xx xx xx xx", 
    "xx xx xx xx xx oo xx xx oo oo oo oo oo oo xx xx xx xx xx xx xx oo xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx oo oo xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx"
  };
  map2 = new String[] {
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx AA xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx AB xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx AC xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx AD xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx AE xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx AF xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx", 
    "xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx xx"
  };
  currentMap = map;
  rowStr = new ArrayList<ArrayList<String>>();
  for (int i = 0; i < currentMap.length; i ++)
  {
    spaceStr = new ArrayList<String>();
    String row = currentMap[i];
    for (int i2 = 0; i2 < row.length(); i2 += 3)
      spaceStr.add(spaceStr.size(), "" + row.charAt(i2) + row.charAt(i2 + 1));
    rowStr.add(spaceStr);
  }
  //println(rowStr);
  //saveStrings("RPG Map.txt", strToSave);
  //map = loadStrings("RPG Map.txt");
  healingPotion = new String[] {
    "0-Name-1", 
    "Bronze Dagger", 
    "2-Consume-3", 
    "false", 
    "4-Passive-5", 
    "true", 
    "6-Cost-7", 
    "75", 
    "8-Player Heatlh Add (mh = max health...h = health)-9", 
    "5", 
    "10-Plyer Health Set (mh = max health...h = health)-11", 
    "h", 
    "12-Visible In Combat-13", 
    "false", 
    "14-Player Damage Add (d = damage)-15", 
    "1", 
    "16-Player Damage Set (d = damage)-17", 
    "d", 
    "18-Hands-19", 
    "1", 
    "20-Apply Effect Once-21", 
    "true"
  };
  //saveStrings("Healing Potion.txt", strToSave);
  //healingPotion = loadStrings("Healing Potion.txt");
  bronzeDagger = new String[] {
    "0-Name-1", 
    "Healing Potion", 
    "2-Consume-3", 
    "true", 
    "4-Passive-5", 
    "false", 
    "6-Cost-7", 
    "50", 
    "8-Player Heatlh Add (mh = max health...h = health)-9", 
    "5", 
    "10-Plyer Health Set (mh = max health...h = health)-11", 
    "h", 
    "12-Visible In Combat-13", 
    "true", 
    "14-Player Damage Add (d = damage)-15", 
    "0", 
    "16-Player Damage Set (d = damage)-17", 
    "d", 
    "18-Hands-19", 
    "0", 
    "20-Apply Effect Once-21", 
    "true"
  };
  //saveStrings("Bronze Dagger.txt", strToSave);
  //bronzeDagger = loadStrings("Bronze Dagger.txt");
  //inMainMenu = true;
  r1 = random(255);
  r2 = random(255);
  r3 = random(255);
  if (random(-1, 1) > 0)
    increaseR1 = true;
  else
    increaseR1 = false;
  if (random(-1, 1) > 0)
    increaseR2 = true;
  else
    increaseR2 = false;
  if (random(-1, 1) > 0)
    increaseR3 = true;
  else
    increaseR3 = false;
  restart(true, "");
}

void mainMenu()
{
  int rChangeMin = 0;
  int rChangeMax = 10;
  frameRate(60);
  background(r1, r2, r3);
  if (r1 <= 0)
    increaseR1 = true;
  else if (r1 >= 255)
    increaseR1 = false;
  if (increaseR1)
    r1 += random(rChangeMin, rChangeMax);
  else
    r1 -= random(rChangeMin, rChangeMax);
  if (r2 <= 0)
    increaseR2 = true;
  else if (r2 >= 255)
    increaseR2 = false;
  if (increaseR2)
    r2 += random(rChangeMin, rChangeMax);
  else
    r2 -= random(rChangeMin, rChangeMax);
  if (r3 <= 0)
    increaseR3 = true;
  else if (r3 >= 255)
    increaseR3 = false;
  if (increaseR3)
    r3 += random(rChangeMin, rChangeMax);
  else
    r3 -= random(rChangeMin, rChangeMax);
  fill(r3 * 2, r2 - r1 + r3, r1 / 2);
  ellipse(width / 2, height / 2, width * .25, width * .1);
  fill(r2 + (r1 / 2), r3 / 3 + r2, r1 * 1.5);
  textFont(font, fontSize * .75);
  textAlign(CENTER, CENTER);
  text("NEW GAME", width / 2, height / 2);
}

void changeArea(String warpSpace)
{
  if (warpSpace.charAt(0) == 'A')
  {
    if (currentMap == map)
      currentMap = map2;
  }
  rowStr = new ArrayList<ArrayList<String>>();
  for (int i = 0; i < currentMap.length; i ++)
  {
    spaceStr = new ArrayList<String>();
    String row = currentMap[i];
    for (int i2 = 0; i2 < row.length(); i2 += 3)
      spaceStr.add(spaceStr.size(), "" + row.charAt(i2) + row.charAt(i2 + 1));
    rowStr.add(spaceStr);
  }
  restart(false, warpSpace);
}

void restart(boolean dead, String warpSpace)
{
  if (dead)
  {
    cameraOffset = new PVector();
    conversationsTotal = new ArrayList();
    conversations = new ArrayList<Conversation>();
    firstBattle = true;
    battle = false;
    inventory = new ArrayList<Item>();
    carryCapacity = 10;
  }
  WORLD_SIZE_Y = currentMap.length;
  ArrayList a = rowStr.get(0);
  WORLD_SIZE_X = a.size();
  println(WORLD_SIZE_X);
  println(WORLD_SIZE_Y);
  enemies = new ArrayList<Enemy>();
  spaces = new ArrayList<Space>();
  for (int y = 0; y < WORLD_SIZE_Y; y ++)
    for (int x = 0; x < WORLD_SIZE_X; x ++)
    {
      if (!rowStr.get(y).get(x).equals("xx"))
        spaces.add(new Space(new PVector(x * SPACE_SIZE, y * SPACE_SIZE), color(0, 255, 0)));
      if (rowStr.get(y).get(x).charAt(0) == 'A')
      {
        Space s = new Space(new PVector(x * SPACE_SIZE, y * SPACE_SIZE), color(0, 255, 0));        
        s.warp = true;
        spaces.add(s);
      }
    }
  for (int y = 0; y < WORLD_SIZE_Y; y ++)
    for (int x = 0; x < WORLD_SIZE_X; x ++)
    {
      if (rowStr.get(y).get(x).equals("01"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 115, 115, 115, 115, "Goblin", 1, 4, 20, width * .15, 5);
        e.loot.add(new Item(healingPotion));
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("02"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 125, -1, 125, -1, "Dire Wolf", 1, 3, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("03"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 125, -1, 125, -1, "Dire Wolf", 1, 3, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("04"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 125, -1, 125, -1, "Dire Wolf", 1, 3, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("05"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 110, -1, 110, -1, "Wolf", 1, 2, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("06"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 110, -1, 110, -1, "Wolf", 1, 2, 20, width * .15, 0);
        e.loot.add(new Item(bronzeDagger));
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("07"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 115, 115, 115, 115, "Goblin", 1, 4, 20, width * .15, 15);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("08"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 115, 115, 115, 115, "Goblin", 1, 4, 20, width * .15, 25);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("09"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 110, -1, 110, -1, "Wolf", 1, 2, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("10"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 115, 115, 115, 115, "Goblin", 1, 4, 20, width * .15, 5);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("11"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 115, 115, 115, 115, "Goblin", 1, 4, 20, width * .15, 30);
        e.loot.add(new Item(healingPotion));
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("12"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 125, -1, 125, -1, "Dire Wolf", 1, 3, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("13"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 110, -1, 110, -1, "Wolf", 1, 2, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("14"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 125, -1, 125, -1, "Dire Wolf", 1, 3, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("15"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 115, 115, 115, 115, "Goblin", 1, 4, 20, width * .15, 15);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("16"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 125, -1, 125, -1, "Dire Wolf", 1, 3, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("17"))
      {
        Enemy e = new Enemy(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 110, -1, 110, -1, "Wolf", 1, 2, 20, width * .15, 0);
        enemies.add(e);
      }
      else if (rowStr.get(y).get(x).equals("s0"))
      {
        p = new Player(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 25, 1, 10);
      }
    }

  //p = new Player(new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2)), 25, 1, 10);
  atkIcons = new ArrayList<AttackIcon>();
  //inventory.add(new Item(bronzeDagger));
  if (dead)
  {
    dialogs = new ArrayList<Dialog>();
    dialogsTotal = new ArrayList();
    dialogs.add(new Dialog(new String[] {
      "You find yourself in a forest glade with no|memories of a past that you might have had, only|simple knowledge of how to speak, move around,|etc. {[Enter] to continue.}|", 
      "To your surprise, your body automatically starts to|walk. You try to see if you can stop yourself, but|with no success. {Hold [w], [a], [s], or [d] to|move.}|"
    }
    ));
    dialogsTotal.add(0);
  }
  else
  {
    for (int y = 0; y < WORLD_SIZE_Y; y ++)
      for (int x = 0; x < WORLD_SIZE_X; x ++)
      {
        if (rowStr.get(y).get(x).equals(warpSpace))
          p.loc = new PVector(x * SPACE_SIZE + (SPACE_SIZE / 2), y * SPACE_SIZE + (SPACE_SIZE / 2));
      }
  }
}

void draw()
{
  if (inMainMenu)
  {
    mainMenu();
    return;
  }
  //mouseLoc = PVector.div(new PVector(mouseX, mouseY), CAMERA_ZOOM);
  background(0);
  if (!battle)
  {
    if (canMoveCamera)
    {
      if (p.loc.x - width / 2 + mouseX < p.loc.x - width / 2 + CAMERA_MOVE_BORDER)
        cameraOffset.x -= 5;
      if (p.loc.x - width / 2 + mouseX > p.loc.x + width / 2 - CAMERA_MOVE_BORDER)
        cameraOffset.x += 5;
      if (p.loc.y - height / 2 + mouseY < p.loc.y - height / 2 + CAMERA_MOVE_BORDER)
        cameraOffset.y -= 5;
      if (p.loc.y - height / 2 + mouseY > p.loc.y + height / 2 - CAMERA_MOVE_BORDER)
        cameraOffset.y += 5;
    }
    camera(p.loc.x + cameraOffset.x, p.loc.y + cameraOffset.y, (height/2.0) / tan(PI*30.0 / 180.0) * CAMERA_ZOOM, p.loc.x + cameraOffset.x, p.loc.y + cameraOffset.y, 0, 0, 1, 0);
    fill(0, 255, 0);
    stroke(0);
    for (int i = 0; i < spaces.size(); i ++)
    {
      Space s = spaces.get(i);
      if (conversations.size() == 0)
        s.run();
      if (s.explored)
        s.show();
    }
    for (int i = 0; i < enemies.size(); i ++)
    {
      Enemy e = enemies.get(i);
      if (e.explored)
      {
        e.show();
        if (e.loc.dist(new PVector(p.loc.x - width / 2 + cameraOffset.x + mouseX, p.loc.y - height / 2 + cameraOffset.y + mouseY)) <= e.SIZE / 2)
        {
          fill(255);
          text(e.name, e.loc.x, e.loc.y);
        }
      }
      if (dialogs.size() == 0 && conversations.size() == 0)
        e.run();
    }
    if (dialogs.size() == 0 && conversations.size() == 0)
      p.run();
    p.show();
    textAlign(LEFT, TOP);
    fill(127);
    text("HP: " + p.hp + " / " + p.maxHP, p.loc.x - (width / 2) + cameraOffset.x, p.loc.y - (height / 2) + cameraOffset.y);
    text("Damage: "+ p.damage, p.loc.x - (width / 2) + cameraOffset.x, p.loc.y - (height / 2) + cameraOffset.y + fontSize * 1);
    text("Items: "+ inventory.size() + " / "  + carryCapacity, p.loc.x - (width / 2) + cameraOffset.x, p.loc.y - (height / 2) + cameraOffset.y + fontSize * 2);
    text("Gold: " + p.gold, p.loc.x - (width / 2) + cameraOffset.x, p.loc.y - (height / 2) + cameraOffset.y + fontSize * 3);
  }
  else
  {
    if (dialogs.size() == 0)
      skipDialog = false;
    if (firstBattle)
    {
      dialogs.clear();
      dialogs.add(new Dialog(new String[] {
        "Your first battle! {Click on the green circles before|they dissappear to damage the enemy. You lose an|HP each time a green circle dissapears, you click|on a red circle, or you click randomly. The bottom|bar shows your HP, and the top shows the|enemys'.}|"
      }
      ));
      firstBattle = false;
    }
    if (!firstBattle)
    {
      for (int i = 0; i < atkIcons.size(); i ++)
      {
        AttackIcon a = atkIcons.get(i);
        if (a.active)
        {
          a.show();
          if (dialogs.size() == 0)
            a.run();
        }
      }
      if (dialogs.size() == 0)
        for (int i = 0; i < enemies.size(); i ++)
        {
          Enemy e = enemies.get(i);
          if (e.loc.dist(p.loc) == 0)
            e.fight();
        }
    }
  }
  for (int i = 0; i < dialogs.size(); i ++)
  {
    Dialog d = dialogs.get(i);
    d.run();
    if (d.active)
      d.show();
  }
  for (int index = 0; index < inventory.size(); index ++)
  {
    Item i = inventory.get(index);
    if (i.passive && !(i.hands > 0 && p.hands > 2))
      i.run();
    if (keys[4])
      i.show();
  }
  for (int i = 0; i < conversations.size(); i ++)
  {
    Conversation c = conversations.get(i);
    if (c.active)
    {
      c.run();
      c.show();
    }
  }
  if (dialogs.size() == 0 && dialogsTotal.size() == 1 && conversationsTotal.size() == 0)
  {
    //conversations.add(new Conversation("Sex?"));
    conversationsTotal.add(0);
  }
}

void keyPressed()
{
  if (key == 'w')
    keys[0] = true;
  else if (key == 'd')
    keys[1] = true;
  else if (key == 's')
    keys[2] = true;
  else if (key == 'a')
    keys[3] = true;
  else if (key == 'i')
    keys[4] = true;
  else if (keyCode == ENTER && runOnce2)
  {
    skipDialog = true;
    runOnce2 = false;
  }
}

void keyReleased()
{
  if (key == 'w')
  {
    keys[0] = false;
    keys2[0] = true;
  }
  else if (key == 'd')
  {
    keys[1] = false;
    keys2[1] = true;
  }
  else if (key == 's')
  {
    keys[2] = false;
    keys2[2] = true;
  }
  else if (key == 'a')
  {
    keys[3] = false;
    keys2[3] = true;
  }
  else if (key == 'i')
    keys[4] = false;
  else if (keyCode == ENTER)
    runOnce2 = true;
  else if (key == 'm')
  {
    if (CAMERA_ZOOM == 1.0)
      CAMERA_ZOOM = 2.0;
    else
      CAMERA_ZOOM = 1.0;
  }
  //else if (key == 'r')
  //restart(true);
}

void mouseMoved()
{
  canMoveCamera = true;
}

void mousePressed()
{
  if (runOnce)
  {
    mouseJustPressed = true;
    runOnce = false;
  }
}

void mouseReleased()
{
  mouseJustPressed = false;
  runOnce = true;
}

void mouseClicked()
{
  if (keys[4])
  {
    for (int index = 0; index < inventory.size(); index ++)
    {
      Item i = inventory.get(index);
      if (i.loc.dist(new PVector(mouseX, mouseY)) <= i.SIZE / 2)
        i.run();
    }
  }
}
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

class Conversation
{
  String text;
  float sizeX, sizeY;
  boolean active;

  Conversation(String text)
  {
    this.text = text;
    sizeX = width * .075;
    sizeY = width * .05;
    active = true;
  }

  void show()
  {
    print(2);
    fill(255);
    ellipse(p.loc.x - width / 2, p.loc.y - height / 2 + (conversations.size() - 1 * sizeY), sizeX, sizeY);
  }

  void run()
  {
  }
}
class Dialog
{
  String[] strings;
  int currentPart;
  boolean active;

  Dialog(String[] strings)
  {
    this.strings = strings;
    currentPart = 0;
    active = true;
  }

  void show()
  {
    fill(255);
    rectMode(CORNERS);
    if (!battle)
      rect(p.loc.x - width / 2 + cameraOffset.x, p.loc.y + (height / 2) - (height * .425) + cameraOffset.y, p.loc.x + width / 2 + cameraOffset.x, p.loc.y + (height / 2) + cameraOffset.y);
    else
      rect(0, height - (height * .425), width * 2, height);
    fill(0);
    textAlign(LEFT, TOP);
    String[] lines = new String[6];
    for (int i = 0; i < lines.length; i ++)
      lines[i] = "";
    int currentLine = 0;
    int lastLineEnd = 0;
    for (int i = 0; i < strings[currentPart].length(); i ++)
    {
      if (strings[currentPart].charAt(i) == '|')
      {
        lines[currentLine] = strings[currentPart].substring(lastLineEnd, i);
        currentLine ++;
        lastLineEnd = i + 1;
      }
    }
    for (int i = 0; i < lines.length; i ++)
    {
      for (int i2 = 0; i2 < 4; i2 ++)
      {
        if (!battle)
          text(lines[i], p.loc.x - (width / 2) + cameraOffset.x, p.loc.y + (height / 2) - (height * .375) + (fontSize * i) - (fontSize / 2) + cameraOffset.y);
        else
          text(lines[i], 0, height - (height * .375) + (fontSize * i) - (fontSize / 2));
      }
    }
  }

  void run()
  {
    if (skipDialog)
    {
      skipDialog = false;
      currentPart ++;
      if (currentPart > strings.length - 1)
      {
        active = false;
        dialogs.remove(this);
      }
    }
  }
}

class Enemy
{
  PVector loc;
  float SIZE, MIN_ICON_SPREAD, SIGHT_RADIUS;
  int defense, defenseTimer, defenseStay, offense, offenseTimer, offenseStay, DAMAGE, hp, maxHP, SPEED, moveTimer, gold;
  ArrayList loot;
  boolean explored;
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
      moveTimer ++;
    else
      moveTimer = 0;
    if (moveTimer > SPEED)
    {
      moveTimer = 0;
      boolean moved = false;
      PVector direction = PVector.sub(p.loc, loc);
      float horizonatalDirection = min(PVector.angleBetween(direction, new PVector(1, 0)), PVector.angleBetween(direction, new PVector(-1, 0)));
      float verticalDirection = min(PVector.angleBetween(direction, new PVector(0, 1)), PVector.angleBetween(direction, new PVector(0, -1)));
      if (min(horizonatalDirection, verticalDirection) == horizonatalDirection)
      {
        if (horizonatalDirection == PVector.angleBetween(direction, new PVector(1, 0)) && !rowStr.get(int(loc.y / SPACE_SIZE)).get(int(loc.x / SPACE_SIZE + 1)).equals("xx"))
        {
          loc.x += SPACE_SIZE;
          moved = true;
        }
        else if (horizonatalDirection == PVector.angleBetween(direction, new PVector(-1, 0)) && !rowStr.get(int(loc.y / SPACE_SIZE)).get(int(loc.x / SPACE_SIZE - 1)).equals("xx") && !moved)
        {
          loc.x -= SPACE_SIZE;
          moved = true;
        }
      }
      if (min(verticalDirection, horizonatalDirection) == verticalDirection && !moved)
      {
        if (verticalDirection == PVector.angleBetween(direction, new PVector(0, 1)) && !rowStr.get(int(loc.y / SPACE_SIZE + 1)).get(int(loc.x / SPACE_SIZE)).equals("xx"))
        {
          loc.y += SPACE_SIZE;
          moved = true;
        }
        else if (verticalDirection == PVector.angleBetween(direction, new PVector(0, -1)) && !rowStr.get(int(loc.y / SPACE_SIZE - 1)).get(int(loc.x / SPACE_SIZE)).equals("xx") && !moved)
          loc.y -= SPACE_SIZE;
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
class Item
{
  PVector loc;
  String[] item;
  String name;
  int cost, playerHealthAdd, playerDamageAdd, hands;
  boolean passive, consume, visibleInCombat, effectApplied, applyEffectOnce;
  float SIZE;
  //int remainingTime, USE_TIMER_DEADLINE;

  Item(String[] item)
  {
    this.item = item;
    name = item[1];
    consume = boolean(item[3]);
    passive = boolean(item[5]);
    cost = int(item[7]);
    playerHealthAdd = int(item[9]);
    visibleInCombat = boolean(item[13]);
    playerDamageAdd = int(item[15]);
    hands = int(item[17]);
    applyEffectOnce = boolean(item[21]);
    SIZE = width * .05;
    effectApplied = false;
    loc = new PVector();
    //this.USE_TIMER_DEADL;INE = USE_TIMER_DEADLINE;
    //remainingTime = USE_TIMER_DEADLINE;
  }

  void show()
  {
    int itemNum = 0;
    for (int index = 0; index < inventory.size(); index ++)
    {
      Item i = inventory.get(index);
      if (i == this)
        itemNum = index;
    }
    if (!passive)
    {
      fill(255);
      if (battle)
      {
        loc = new PVector((itemNum * SIZE) + (SIZE / 2), height - (height * .15));
        ellipse((itemNum * SIZE) + (SIZE / 2), height - (height * .15), SIZE, SIZE);
      }
      else
      {
        loc = new PVector(p.loc.x - (width / 2) + ((itemNum * SIZE) + (SIZE / 2)), p.loc.y + (height / 2) - (height * .15));
        ellipse(p.loc.x - (width / 2) + ((itemNum * SIZE) + (SIZE / 2)), p.loc.y + (height / 2) - (height * .15), SIZE, SIZE);
      }
    }
  }

  void run()
  {
    int itemNum = 0;
    for (int index = 0; index < inventory.size(); index ++)
    {
      Item i = inventory.get(index);
      if (i == this)
        itemNum = index;
    }
    if (battle)
      loc = new PVector((itemNum * SIZE) + (SIZE / 2), height - (height * .15));
    else
      loc = new PVector(p.loc.x - (width / 2) + ((itemNum * SIZE) + (SIZE / 2)), p.loc.y + (height / 2) - (height * .15));
    if ((effectApplied && applyEffectOnce) || (p.hands > 2 && hands > 0) || (battle && !visibleInCombat))
      return;
    effectApplied = true;
    p.hands += hands;
    p.hp += playerHealthAdd;
    p.damage += playerDamageAdd;
    if (consume)
      inventory.remove(this);
  }
}
class Player
{
  PVector loc;
  float SIZE, SIGHT_RADIUS;
  int speed, moveTimer, hp, damage, maxHP, hands, gold;

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

class Space
{
  PVector loc;
  boolean explored, warp;
  color c;

  Space(PVector loc, color c)
  {
    explored = false;
    warp = false;
    this.loc = loc;
    this.c = c;
  }

  void show()
  {
    rectMode(CORNER);
    if (!warp)
      fill(c);
    else
      fill(255);
    stroke(0);
    rect(loc.x, loc.y, SPACE_SIZE, SPACE_SIZE);
  }

  void run()
  {
    if (loc.dist(p.loc) <= p.SIGHT_RADIUS / 2)
      explored = true;
  }
}

