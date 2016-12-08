// a representation of a point mass
final class Particle {

  public PVector location, velocity ;
  Point2D point;

  // Vector to accumulate forces prior to integration
  private PVector forceAccumulator ; 

  // Store inverse mass to allow simulation of infinite mass
  public float invMass ;

  // If you do need the mass, here it is:
  public float getMass() {
    return 1/invMass ;
  }

  Particle(float x, float y, float xVel, float yVel, float invM) {
    location = new PVector(x, y) ;
    velocity = new PVector(xVel, yVel) ;
    forceAccumulator = new PVector(0, 0) ;
    invMass = invM ;
    point = new Point2D.Float(x,y);
  }

  // Add a force to the accumulator
  void addForce(PVector force) {
    forceAccumulator.add(force) ;
  }

  // update location and velocity
  void update() {
    // If infinite mass, we don't integrate
    if (invMass <= 0f) return ;

    // update location
    location.add(velocity) ;

    // NB If you have a constant acceleration (e.g. gravity) start with
    //    that then add the accumulated force / mass to that.
    PVector resultingAcceleration = forceAccumulator.copy() ;
    resultingAcceleration.mult(invMass) ;

    // update velocity
    velocity.add(resultingAcceleration) ;


    // Clear accumulator
    forceAccumulator.x = 0 ;
    forceAccumulator.y = 0 ;
  }
}