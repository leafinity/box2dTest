part of FallinBasket;

typedef void Build();
typedef Fixture SpecialBasket();

class PlayInfo {
  Vector2 gravity;
  int numBlocks;
  Build build;
  SpecialBasket specialBasket;
  double _basketWidth;
  double basketHeight;
  double impulse;
  
  void set basketWidth(double width) {
    _basketWidth = width;
    basketHeight = (width * 9) / 8;
  }
  double get basketWidth => _basketWidth;
  
  PlayInfo(this.gravity, {double basketWidth: 80.0, this.impulse: 2000.0, this.numBlocks:0, this.specialBasket, this.build}) {
    this.basketWidth = basketWidth;
  }
}
List<PlayInfo> playInfos = [
  new PlayInfo(new Vector2(0.0, -50.0)),
  new PlayInfo(new Vector2(0.0, -80.0), basketWidth: 40.0, impulse: 3000.0 , numBlocks: 5),
  ];