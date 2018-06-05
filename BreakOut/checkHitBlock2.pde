int checkHitBlock2(int n, int m, float x, float y) {//大きいブロック用あたり判定

  float left = bw2*n;//ブロック左座標
  float right = bw2*(n+1);//ブロック右座標
  float top = 40*m;//ブロック上座標
  float bottom = top+bh2;//ブロック下座標
  float y1, y2;//左上右下、右上左下

  if ((x+aw <left)||(x>right)||(y+ah<top)||(y>bottom)) {
    return 0;
  }

  y1=bh2/bw2*x+top-(left*bh2/bw2);//ブロックの対角線　左上から右下
  y2=-bh2/bw2*x+bottom+(left*bh2/bw2);//ブロックの対角線　右上から左下

  if (y<y1) {
    if (y<y2) {
      return 1;
    } else if (y>y2) {
      return 2;
    } else {
      return 5;
    }
  } else if (y>y1) {
    if (y<y2) {
      return 4;
    } else if (y>y2) {
      return 3;
    } else {
      return 7;
    }
  } else {
    if (y<y2) {
      return 8;
    } else if (y>y2) {
      return 6;
    } else {
      return 0;
    }
  }
}