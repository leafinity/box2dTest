library FallinBasket;

import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'package:box2d/box2d_browser.dart';

part 'level1.dart';
//part 'level2.dart';
//part 'level3.dart';

part 'box2dtest_util.dart';
part 'PlayInfo.dart';

World world;
int time = 0;
int CANVAS_WIDTH;
int CANVAS_HEIGHT;

int level = 0;

void initializeGame(int level) {
  play(level);
}
void startGame(int level){  
  initializeGame(level);
  initializeCanvas();
  run();
}

CanvasElement canvas;
CanvasRenderingContext2D ctx;
ViewportTransform viewport;
DebugDraw debugDraw;

void initializeCanvas() {
  // Create a canvas and get the 2d context.
  canvas = query("#canvas");
  canvas.width = CANVAS_WIDTH;
  canvas.height = CANVAS_HEIGHT;
  ctx = canvas.getContext("2d");

  // Create the viewport transform with the center at extents.
  final extents = new Vector2(CANVAS_WIDTH/2, CANVAS_HEIGHT/2);
  viewport = new CanvasViewportTransform(extents, extents);
  viewport.scale = 1.0;

  // Create our canvas drawing tool to give to the world.
  debugDraw = new CanvasDraw(viewport, ctx);

  // Have the world draw itself for debugging purposes.
  world.debugDraw = debugDraw;
}
void run() {
  window.animationFrame.then((time) => step());
}

void step() {
  world.step(1/60, 10, 10);
  ctx.clearRect(0, 0, CANVAS_WIDTH, CANVAS_HEIGHT);
  world.drawDebugData();
  run();
}
void main() {
  startGame(level);
}