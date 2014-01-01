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
