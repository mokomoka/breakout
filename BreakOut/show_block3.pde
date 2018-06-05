void show_block3(int n, int m) {//小さいブロックを表示するための関数（交互に色を変えるため二つ作っている）
  if (n%2 == 1) {
    fill(186, 124, 89);
  } else {
    fill(249, 231, 150);
  }
  rect(bw1 * n, m, bw1, bh1);
}