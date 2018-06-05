void check_pattern() {
  for (int j = 0; j<height; j=j+40) {
    for (int i = 0; i < 10; i++) {
      rect(i*40, j, 20.0, 20.0);
    }
  }
  for (int k = 20; k<height; k=k+40) {
    for (int i = 0; i < 10; i++) {
      rect(20+i*40, k, 20.0, 20.0);
    }
  }
}