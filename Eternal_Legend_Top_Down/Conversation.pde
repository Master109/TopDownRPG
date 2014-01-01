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
