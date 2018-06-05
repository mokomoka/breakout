int checkHitBlock1(int n, float m, float x, float y) {//小さいブロック用のあたり判定

  float left = bw1*n;//ブロック左座標
  float right = bw1*(n+1);//ブロック右座標
  float top = 40*m;//ブロック上座標
  float bottom = top+bh1;//ブロック下座標
  float y1, y2;//左上右下、右上左下

  if ((x+aw <left)||
    (x>right)||
    (y+ah<top)||
    (y>bottom)) {
    return 0;
  }

  y1=bh1/bw1*x+top-(left*bh1/bw1);//ブロックの対角線　左上から右下
  y2=-bh1/bw1*x+bottom+(left*bh1/bw1);//ブロックの対角線　右上から左下

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