part of FallinBasket;

Random random = new Random();

void play(int level) {
  final pi = playInfos[level];
  double ran;
  // Create a world with gravity and allow it to sleep.
  world = CreateWorld(pi.gravity);
  
  Fixture groundFixture = createBox(800.0, 600.0);
  Fixture passFixture;
  if(pi.specialBasket != null) {
    passFixture = pi.specialBasket();
  } else {
    ran = random.nextDouble()*500 - 250;
    passFixture = createBasket(80.0, 90.0, new Vector2(ran, -CANVAS_HEIGHT/2));
  }
  // Create a bouncing ball.
  final bouncingBall = new CircleShape();
  bouncingBall.radius = 20.0;

  final ballFixtureDef = new FixtureDef();
  ballFixtureDef.friction = 0.005;
  ballFixtureDef.restitution = 0.7;
  ballFixtureDef.density = 0.05;
  ballFixtureDef.shape = bouncingBall;

  final ballBodyDef = new BodyDef();
  ballBodyDef.linearVelocity = new Vector2(-2.0, -20.0);
  ran = random.nextDouble()*500 - 250;
  ballBodyDef.position = new Vector2(ran, 250.0);
  ballBodyDef.type = BodyType.DYNAMIC;

  final ballBody = world.createBody(ballBodyDef);
  final ball = ballBody.createFixture(ballFixtureDef);

  for (int i = 0; i < pi.numBlocks; i++) {
    buildObstacle();
  }

  if (pi.build != null)
    pi.build();

  //game
  world.contactListener = new _ContactListener(groundFixture, passFixture, ball, level);
  document.onKeyDown.listen((KeyboardEvent evt){  
    //if in basket
    //if out of basketd
    if(evt.keyCode == 37) { //LEFT
      ballBody.applyLinearImpulse(new Vector2(-(pi.impulse), 0.0), ballBody.sweep.center);
      evt.preventDefault();
    } else if(evt.keyCode == 39) {//R
      ballBody.applyLinearImpulse(new Vector2(pi.impulse, 0.0), ballBody.sweep.center);
      evt.preventDefault();
    } else if(evt.keyCode == 38) {//U
      ballBody.applyLinearImpulse(new Vector2(0.0, pi.impulse), ballBody.sweep.center);
      evt.preventDefault();
    } else if(evt.keyCode == 40) {//D
      ballBody.applyLinearImpulse(new Vector2(0.0, -(pi.impulse)), ballBody.sweep.center);
      evt.preventDefault();
    }
  });
}


