boolean checkHitCandy(float n, float m, float r) {//円形の障害物のあたり判定に使う
  if (sq(n-x+aw/2)+sq(m-y+ah/2) <= r*r) {//距離の計算式
    return true;//一定の範囲内にあればtrueを返す
  } else {
    return false;
  }
}