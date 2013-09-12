part of FallinBasket;

World CreateWorld(Vector2 gravity) {
  return new World (gravity, true, new DefaultWorldPool());
}

Fixture createBox(double width, double height){
  CANVAS_WIDTH = width.toInt();
  CANVAS_HEIGHT= height.toInt();

  PolygonShape sd = new PolygonShape(); 
  BodyDef bd = new BodyDef();

  //Create ground   
  sd.setAsBox(width/2.0, 5.0);
  bd.position.setValues(0.0, 0.5 -(height / 2.0));    
  final boxFixtureDef = new FixtureDef();
  boxFixtureDef.restitution = 0.7;
  boxFixtureDef.density = 0.05;
  boxFixtureDef.shape = sd;
  Body ground = world.createBody(bd);
  final groundFixture = ground.createFixture(boxFixtureDef);

  // Create the wall.
  sd.setAsBox(0.0, height/2.0);
  bd.position.setValues(-width/2.0, 0.0);
  Body wallLefy = world.createBody(bd);
  wallLefy.createFixtureFromShape(sd);

  bd.position.setValues(width/2.0, 0.0);
  Body wallRight = world.createBody(bd);
  wallRight.createFixtureFromShape(sd);

  sd.setAsBox(width/2.0, 0.0);  
  bd.position.setValues(0.0, height/2.0);
  Body wallUp = world.createBody(bd);
  wallUp.createFixtureFromShape(sd);

  return groundFixture;
}

Fixture createBasket(double width, double height, Vector2 position) {
  double x = position.storage[0];
  double y = position.storage[1];
  
  PolygonShape sd = new PolygonShape(); 
  BodyDef bd = new BodyDef();

  //creat left
  sd.setAsBox(5.0, height/2);
  bd = new BodyDef();
  bd.position.setValues(x - width/2, y + height/2);
  final bkFixtureDef = new FixtureDef();
  bkFixtureDef.shape = sd;
  Body basketLeft = world.createBody(bd);
  basketLeft.createFixture(bkFixtureDef);

  //create right
  sd.setAsBox(5.0, height/2);
  bd.position.setValues(x + width/2, y + height/2);
  Body basketRight = world.createBody(bd);
  basketRight.createFixture(bkFixtureDef);  

  //create bottom and return fixture of bottom
  sd.setAsBox(width/2, 2.0);
  bd.position.setValues(x, (y + 7.0));
  bkFixtureDef.shape = sd;
  Body basketBottom = world.createBody(bd);
  final passFixture = basketBottom.createFixture(bkFixtureDef);
  return passFixture;
}

//Fixture CreateCircle({double radius, double centerPosX: 0.0, double centorposY: 0.0, double friction: 0.2, double restitution:, double density:, double velocityX, double velocityY}) {
//  final bouncingBall = new CircleShape();
//  bouncingBall.radius = radius;
//
//  final ballFixtureDef = new FixtureDef();
//  ballFixtureDef.friction = friction;
//  ballFixtureDef.restitution = restitution;
//  ballFixtureDef.density = density;
//  ballFixtureDef.shape = bouncingBall;
//
//  final ballBodyDef = new BodyDef();
//  ballBodyDef.linearVelocity = new Vector2(velocityX, velocityY);
//  ballBodyDef.position = new Vector2(15.0, 15.0);
//  ballBodyDef.type = BodyType.DYNAMIC;
//
//  final ballBody = world.createBody(ballBodyDef);
//  final ball = ballBody.createFixture(ballFixtureDef);
//}

void buildObstacle() {
  double width  = random.nextDouble()*50 + 50;
  double height = random.nextDouble()*30 + 30;
  double posX = random.nextDouble()*600 - 300;
  double posY = random.nextDouble()*300 - 100;

  PolygonShape sd = new PolygonShape(); 
  BodyDef bd = new BodyDef();
  sd.setAsBox(width / 2.0, height / 2.0);
  bd.position.setValues(posX, posY);    
  final boxFixtureDef = new FixtureDef();
  boxFixtureDef.restitution = 0.1;
  boxFixtureDef.density = 0.05;
  boxFixtureDef.shape = sd;
  Body ground = world.createBody(bd);
  ground.createFixture(boxFixtureDef);
}


bool inContact(Contact contact, Fixture A, Fixture B) {
  for (; contact != null; contact = contact.next){
    if (contact.fixtureA == A && contact.fixtureB == B)
      return true;
    if (contact.fixtureA == B && contact.fixtureB == A)
      return true;
  }
  return false;
}

class _ContactListener implements ContactListener {
  Fixture _ground;
  Fixture _pass;
  Fixture _ball;
  int _level;
  bool _done = false;
  _ContactListener(this._ground, this._pass, this._ball, this._level);
 
  void beginContact(Contact contact) {
    if (_done) {
      return;
    }

    if (inContact(world.contactList, _pass, _ball)) {
      _done = true;
      print("pass");
      DivElement over = query('#win');
      over.classes.remove('disappear');
      _ball.body.linearVelocity = new Vector2(0.0, 0.0);
print("$level, ${playInfos.length}");
      if(++level < playInfos.length)
        new Timer(const Duration(seconds: 1), (){
print("in");
          over.classes.add('disappear');
          startGame(level);
        });
    } else if (inContact(world.contactList, _ground, _ball)) {      
      _done = true;
      print("fail");
      DivElement over = query('#end');
      over.classes.remove('disappear');
      _ball.body.linearVelocity = new Vector2(0.0, 0.0);
      //new Timer(const Duration(seconds: 5), startGame);
    }
  }  

  void endContact(Contact contact) {
  }

  void preSolve(Contact contact, Manifold oldManifold) {
  }

   void postSolve(Contact contact, ContactImpulse impulse) {
   }
}