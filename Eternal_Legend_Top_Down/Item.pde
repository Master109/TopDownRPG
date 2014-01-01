class Item
{
  PVector loc;
  String[] item;
  String name;
  float goldRecieveAdd;
  int hands, cost, playerHealthAdd, playerDamageAdd, effectDuration;
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
    goldRecieveAdd = float(item[23]);
    effectDuration = int(item[25]);
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
