void show_block1(int n, int m) {//小さいブロックを表示するための関数
  if (n%2 == 0) {//交互に塗りつぶしの色を変えることで、クッキーのような柄にしています
    fill(186, 124, 89);
  } else {
    fill(249, 231, 150);
  }
  rect(bw1 * n, m, bw1, bh1);
}