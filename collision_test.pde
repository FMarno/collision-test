import java.awt.geom.*;

Rect r0;

ForceRegistry forceRegistry;
ContactResolver contactResolver;
ArrayList<Contact> contacts;
Gravity gravity = new Gravity(new PVector(0f, .004f)) ;
float angle;
PVector point;

void setup() {
  size(800, 600);

  forceRegistry = new ForceRegistry() ;

  contactResolver = new ContactResolver() ;
  contacts = new ArrayList<Contact>();

  r0 = new Rect(100f, 100f, 200f, 200f, 0.1, #ff00ff);
  //r0.applyGravity();
  point = new PVector(0, 0);
}

void draw() {
  point.set(mouseX, mouseY);
  background(128);
  fill(#ffff00);

  r0.rotateAround(null, 0.01);
  r0.getContacts(contacts);
  contactResolver.resolveContacts(contacts);

  forceRegistry.updateForces() ;

  r0.update();

  contacts.clear();
  r0.display();
  ellipse(point.x, point.y, 10, 10);

  if (r0.contains(point)) {
    fill(0, 255, 0);
  } else {
    fill(255, 0, 0);
  }
  rect(width/2 - 20, height/2 -20, 40, 40);
}