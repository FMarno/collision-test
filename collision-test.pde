import java.awt.geom.*;

Rect r0;

ForceRegistry forceRegistry;
ContactResolver contactResolver;
ArrayList<Contact> contacts;
Gravity gravity = new Gravity(new PVector(0f, .004f)) ;

void setup() {
  size(800, 600);

  forceRegistry = new ForceRegistry() ;

  contactResolver = new ContactResolver() ;
  contacts = new ArrayList<Contact>();

  r0 = new Rect(100f, 100f, 200f, 200f, 0.1, #ff00ff);
}

void draw() {
  background(128);
  fill(#ffff00);



  r0.getContacts(contacts);
  contactResolver.resolveContacts(contacts);

  forceRegistry.updateForces() ;

  r0.update();

  contacts.clear();
  r0.display();
}

// When mouse is pressed, store x, y coords
void mousePressed() {
  r0.corners[2].addForce(new PVector(10, -10));
}