part of FallinBasket;
void level3() {
  // Create a world with gravity and allow it to sleep.
  world = new World(new Vector2(0.0, -1.0), true, new DefaultWorldPool());

  //initializeWalls
  PolygonShape sd = new PolygonShape();//多邊形    
  sd.setAsBox(40.0, 0.5);
  BodyDef bd = new BodyDef();
  //Create ground
  bd.position.setValues(0.0, -20.0);    
  final boxFixtureDef = new FixtureDef();
  boxFixtureDef.friction = 99.0;
  boxFixtureDef.restitution = 0.7;
  boxFixtureDef.density = 0.05;
  boxFixtureDef.shape = sd;
  Body ground = world.createBody(bd);
  ground.createFixture(boxFixtureDef);

  // Create the wall.
  sd.setAsBox(0.0, 50.0);
  bd = new BodyDef();
  bd.position.setValues(-40.0, 0.0);
  Body ground2 = world.createBody(bd);
  ground2.createFixtureFromShape(sd);

  sd.setAsBox(0.0, 50.0);
  bd = new BodyDef();
  bd.position.setValues(40.0, 0.0);
  Body ground3 = world.createBody(bd);
  ground3.createFixtureFromShape(sd);

  sd.setAsBox(50.0, 0.0);
  bd = new BodyDef();
  bd.position.setValues(0.0, 20.0);
  Body ground4 = world.createBody(bd);
  ground4.createFixtureFromShape(sd);

  // Create the basket
  sd.setAsBox(0.5, 3.0);
  bd = new BodyDef();
  bd.position.setValues(-30.0, -18.5);
  final bkFixtureDef = new FixtureDef();
  bkFixtureDef.friction = 0.0001;
  bkFixtureDef.shape = sd;
  Body basket = world.createBody(bd);
  basket.createFixture(bkFixtureDef);

  sd.setAsBox(0.5, 3.0);
  bd = new BodyDef();
  bd.position.setValues(-20.0, -18.5);
  Body basket2 = world.createBody(bd);
  basket2.createFixture(bkFixtureDef);

  sd.setAsBox(5.0, 0.2);
  bd = new BodyDef();
  bd.position.setValues(-25.0, -19.6);
  bkFixtureDef.shape = sd;
  Body basket3 = world.createBody(bd);
  basket3.createFixture(bkFixtureDef);

  //initializeObstacle
  sd.setAsBox(4.0, 0.4);
  BodyDef bd = new BodyDef();
  bd.position.setValues(-30.0, 15.0);
  Body ob = world.createBody(bd);
  ob.createFixtureFromShape(sd);

  sd.setAsBox(4.0, 0.4);
  bd = new BodyDef();
  bd.position.setValues(5.0, 5.0);
  Body od2 = world.createBody(bd);
  od2.createFixtureFromShape(sd);

  sd.setAsBox(4.0, 0.4);
  bd = new BodyDef();
  bd.position.setValues(25.0, -5.0);
  Body ob3 = world.createBody(bd);
  ob3.createFixtureFromShape(sd);

  // Create a bouncing ball.
  final bouncingBall = new CircleShape();
  bouncingBall.radius = 2.0;

  final ballFixtureDef = new FixtureDef();
  ballFixtureDef.friction = 0.005;
  ballFixtureDef.restitution = 0.7;
  ballFixtureDef.density = 0.05;
  ballFixtureDef.shape = bouncingBall;

  final ballBodyDef = new BodyDef();
  ballBodyDef.linearVelocity = new Vector2(-2.0, -20.0);
  ballBodyDef.position = new Vector2(15.0, 15.0);
  ballBodyDef.type = BodyType.DYNAMIC;

  final ballBody = world.createBody(ballBodyDef);
  ballBody.createFixture(ballFixtureDef);

  //game
  document.onKeyDown.listen((KeyboardEvent evt){    
    //if in basket
    //if out of basketd
    if(evt.keyCode == 37)//LEFT
      ballBody.applyForce(new Vector2(-1000.0, 0.0), ballBody.sweep.center);
    else if(evt.keyCode == 39)//R
      ballBody.applyForce(new Vector2(1000.0, 0.0), ballBody.sweep.center);
    else if(evt.keyCode == 38)//U
      ballBody.applyForce(new Vector2(0.0, 1000.0), ballBody.sweep.center);
    else if(evt.keyCode == 40)//D
      ballBody.applyForce(new Vector2(0.0, -1000.0), ballBody.sweep.center);
    evt.preventDefault();
    });
}