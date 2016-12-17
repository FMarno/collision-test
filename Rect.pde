class Rect {
  Particle[] corners;
  Rod[] edges;
  int fill;
  float w;
  float h;

  Rect(float x, float y, float w, float h, float invMass, int fill) {
    corners = new Particle[4];
    corners[0] = new Particle(x, y, 0, 0, invMass*4);
    corners[1] = new Particle(x+w, y, 0, 0, invMass*4);
    corners[2] = new Particle(x+w, y+h, 0, 0, invMass*4);
    corners[3] = new Particle(x, y+h, 0, 0, invMass*4);
    edges = new Rod[6];
    edges[0] = new Rod(corners[0], corners[1], w);
    edges[1] = new Rod(corners[1], corners[2], h);
    edges[2] = new Rod(corners[2], corners[3], w);
    edges[3] = new Rod(corners[3], corners[0], h);
    edges[4] = new Rod(corners[0], corners[2], h);
    edges[5] = new Rod(corners[1], corners[3], h);
    this.w  = w;
    this.h = h;

    this.fill = fill;
  }

  void applyGravity() {
    for (Particle p : corners) {
      forceRegistry.add(p, gravity) ;
    }
  }

  void update() {
    for (Particle p : corners) {
      p.update();
    }
  }

  void display() {
    fill(fill);
    stroke(0);    
    beginShape();
    vertex(corners[0].location.x, corners[0].location.y);
    vertex(corners[1].location.x, corners[1].location.y);
    vertex(corners[2].location.x, corners[2].location.y);
    vertex(corners[3].location.x, corners[3].location.y);
    vertex(corners[0].location.x, corners[0].location.y);
    endShape();
    fill(255);
    ellipse(corners[0].location.x, corners[0].location.y, 10, 10);
  }

  void getContacts(ArrayList<Contact> contacts) {
    for (Rod r : edges) {
      Contact contact = r.getContact();
      if (contact != null)
        contacts.add(contact);
    }
  }

  boolean contains(PVector point) {
    float angle = atan2(corners[3].location.x-corners[0].location.x, corners[3].location.y-corners[0].location.y);
    PVector c = corners[0].location.copy();
    PVector p = point.copy();
    p.rotate(angle);
    c.rotate(angle);
    fill(0, 0, 255);
    int f = fill;
    pushMatrix();
    this.fill = #00ffff;
    rotate(angle);
    display();
    this.fill = f;
    rotate(-angle);
    ellipse(p.x, p.y, 10, 10);

    popMatrix();

    return (p.x >= c.x && p.x <= c.x+w && p.y >= c.y && p.y <= c.y+h);
  }

  void rotateAround(PVector centre, float angle) {
    if (centre == null) {
      centre = corners[0].location.copy();
    }
    for (Particle p : corners) {
      PVector diff = p.location;
      diff.sub(centre);
      diff.rotate(angle);
      diff.add(centre);
    }
  }
}