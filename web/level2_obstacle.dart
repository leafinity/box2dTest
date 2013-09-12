part of FallinBasket;

void level1() {
  // Create a world with gravity and allow it to sleep.
  world = CreateWorld(new Vector2(0.0, -5.0));
  
  Fixture groundFixture = createBox(1200.0, 900.0);

  Fixture passFixture = createBasket();

  // Create a bouncing ball.
  final bouncingBall = new CircleShape();
  bouncingBall.radius = 2.0;

  final ballFixtureDef = new FixtureDef();
  ballFixtureDef.friction = 0.005;
  ballFixtureDef.restitution = 0.7;
  ballFixtureDef.density = 0.05;
  ballFixtureDef.shape = bouncingBall;

  final ballBodyDef = new BodyDef();
  //ballBodyDef.linearVelocity = new Vector2(-2.0, -20.0);
  ballBodyDef.position = new Vector2(15.0, 15.0);
  ballBodyDef.type = BodyType.DYNAMIC;

  final ballBody = world.createBody(ballBodyDef);
  final ball = ballBody.createFixture(ballFixtureDef);

  //game
  world.contactListener = new _ContactListener(groundFixture, passFixture, ball);
  document.onKeyDown.listen((KeyboardEvent evt){  
    //if in basket
    //if out of basketd
    if(evt.keyCode == 37) { //LEFT
      ballBody.applyForce(new Vector2(-200.0, 0.0), ballBody.sweep.center);
      evt.preventDefault();
    } else if(evt.keyCode == 39) {//R
      ballBody.applyForce(new Vector2(200.0, 0.0), ballBody.sweep.center);
      evt.preventDefault();
    } else if(evt.keyCode == 38) {//U
      ballBody.applyForce(new Vector2(0.0, 200.0), ballBody.sweep.center);
      evt.preventDefault();
    } else if(evt.keyCode == 40) {//D
      ballBody.applyForce(new Vector2(0.0, -200.0), ballBody.sweep.center);
      evt.preventDefault();
    }
  });
}


