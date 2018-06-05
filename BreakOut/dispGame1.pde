void dispGame1() {//ゲーム画面表示用の関数
  frameRate(60+20*combo);//コンボ数によって速さが違う
  if (y < 0) {
    dy = -dy;
    ddy = dy;
    player3.trigger();//壁で跳ね返ったときの音
  }
  if (x > width-aw/2) {//ボールが画面右に達したら跳ね返す
    dx = -dx;
    ddx = dx;
    player3.trigger();//壁で跳ね返ったときの音
  } else if (x < 0) {//ボールが画面左に達したら跳ね返す
    dx = -dx;
    ddx = dx;
    player3.trigger();//壁で跳ね返ったときの音
  }
  if (mouseX+25 >= width) {
    mx = width-50;
  } else if (mouseX-25<0) {
    mx = 0;
  } else {
    mx = mouseX-30;
  }

  if (keyPressed && key == 'q') {//自動で跳ね返せる隠しモード
    mx = x-25;
    frameRate(600);
  }

  x = x + dx;
  y = y + dy;

  background(255, 198, 185);
  noStroke();

  fill(255, 204, 185);
  check_pattern();

  if (miscount1 <= 0) {//ゲームオーバー画面へ分岐
    fill1 = 0;
    fill2 = 0;
    GameStatus = "StatusOver";
  }

  if (hit == 70) {//ゲームクリア画面へ分岐
    fill1 = 0;
    fill2 = 0;
    GameStatus = "StatusClear1";
  }

  noStroke();
  fill(255, 92, 121, fill1);
  rect(x, y, aw, ah, 5);//ボール
  fill(186, 124, 89, fill1);//クッキーとかビスケットみたいな色
  rect(mx, 500, 60, 5, 3);//ラケット上
  rect(mx, 513, 60, 5, 3);//ラケット下
  fill(255, 255, 220, fill1);//クリームみたいな色
  rect(mx+1, 505, 58, 8, 3);//ラケット中

  imageMode(CENTER);//画像の座標の指定位置を中心に
  tint(255, fill1);//画像の見た目に変化を加えず、ゲームオーバーやゲームクリアでは非表示にするため

  pushMatrix();//ビスケットひとつめ
  translate(100, 300);
  rotate(frameCount / 200.0);
  image(biscuit, 0, 0, 70, 70);
  popMatrix();

  pushMatrix();//ビスケットふたつめ
  translate(300, 300);
  rotate(frameCount / 200.0);
  image(biscuit, 0, 0, 70, 70);
  popMatrix(); 

  pushMatrix();//キャンディひとつめ
  translate(50, 400);
  rotate(frameCount / 100.0);
  image(candy1, 0, 0, 40, 40);
  popMatrix(); 

  pushMatrix();//キャンディふたつめ
  translate(70, 200);
  rotate(frameCount / 100.0);
  image(candy2, 0, 0, 40, 40);
  popMatrix(); 

  pushMatrix();//キャンディみっつめ
  translate(330, 200);
  rotate(frameCount / 100.0);
  image(candy3, 0, 0, 40, 40);
  popMatrix(); 

  pushMatrix();//キャンディよっつめ
  translate(350, 400);
  rotate(frameCount / 100.0);
  image(candy4, 0, 0, 40, 40);
  popMatrix(); 

  if (checkHitCandy(50, 400, 20) || checkHitCandy(350, 400, 20)) {//上の段のキャンディーとの当たり判定
    dx = random(-4, 4);
    ddx = dx;
    if (y <= 420) {
      dy = random(-8, -2);
      ddy = dy;
    } else if (y > 420) {
      dy = random(2, 8);
      ddy = dy;
    }
  }

  if (checkHitCandy(70, 200, 20) || checkHitCandy(330, 200, 20)) {//下の段のキャンディーとの当たり判定
    dx = random(-4, 4);
    ddx = dx;
    if (y<=220) {
      dy = random(-8, -2);
      ddy = dy;
    } else if (y>220) {
      dy = random(2, 8);
      ddy = dy;
    }
  }

  if (checkHitCandy(100, 300, 35) || checkHitCandy(300, 300, 35)) {//ビスケットとの当たり判定
    dy=random(1, 3);
    ddy = dy;
    if ((x<100) || (200 < x && x < 300)) {
      dx=random(-4, -2);
      ddx = dx;
    } else {
      dx=random(2, 4);
      ddx = dx;
    }
  }

  for (int i=0; i<hit2.length; i=i+2) {//大きいブロック
    int ref2=0;
    if (hit2[i] > 0) {
      show_block2(i, 40);
      ref2 = checkHitBlock2(i, 1, x, y);
      switch(ref2) {
      case 1:
      case 3:
        player1.trigger();//ブロックにボールが当たった時の音
        hit2[i]=hit2[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dy = -1*dy;
        break;
      case 2:
      case 4:
        player1.trigger();//ブロックにボールが当たった時の音
        hit2[i]=hit2[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        break;
      case 5:
      case 6:
      case 7:
      case 8:
        player1.trigger();//ブロックにボールが当たった時の音
        hit2[i]=hit2[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        dy = -1*dy;
        break;
      }
      ddx = dx;
      ddy = dy;
    }
  }

  for (int i=2; i<hit1.length; i=i+4) {//大きいブロックの間、左上
    int ref3=0;
    if (hit3[i] > 0) {
      show_block1(i, 40);
      ref3 = checkHitBlock1(i, 1, x, y);
      switch(ref3) {
      case 1:
      case 3:
        player1.trigger();//ブロックにボールが当たった時の音
        hit3[i]=hit3[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        break;
      case 2:
      case 4:
        player1.trigger();//ブロックにボールが当たった時の音
        hit3[i]=hit3[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dy = -1*dy;
        break;
      case 5:
      case 6:
      case 7:
      case 8:
        player1.trigger();//ブロックにボールが当たった時の音
        hit3[i]=hit3[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit+ 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        dy = -1*dy;
        break;
      }
      ddx = dx;
      ddy = dy;
    }
  }

  for (int i=2; i<hit1.length; i=i+4) {//大きいブロックの間、左下
    int ref5=0;
    if (hit5[i] > 0) {
      show_block3(i, 60);
      ref5 = checkHitBlock1(i, 1.5, x, y);
      switch(ref5) {
      case 1:
      case 3:
        player1.trigger();//ブロックにボールが当たった時の音
        hit5[i]=hit5[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        break;
      case 2:
      case 4:
        player1.trigger();//ブロックにボールが当たった時の音
        hit5[i]=hit5[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dy = -1*dy;
        break;
      case 5:
      case 6:
      case 7:
      case 8:
        player1.trigger();//ブロックにボールが当たった時の音
        hit5[i]=hit5[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit+ 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        dy = -1*dy;
        break;
      }
      ddx = dx;
      ddy = dy;
    }
  }

  for (int i=3; i<hit1.length; i=i+4) {//大きいブロックの間、右上
    int ref4=0;
    if (hit4[i] > 0) {
      show_block1(i, 40);
      ref4 = checkHitBlock1(i, 1, x, y);
      switch(ref4) {
      case 1:
      case 3:
        player1.trigger();//ブロックにボールが当たった時の音
        hit4[i]=hit4[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        break;
      case 2:
      case 4:
        player1.trigger();//ブロックにボールが当たった時の音
        hit4[i]=hit4[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dy = -1*dy;
        break;
      case 5:
      case 6:
      case 7:
      case 8:
        player1.trigger();//ブロックにボールが当たった時の音
        hit4[i]=hit4[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit+ 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        dy = -1*dy;
        break;
      }
      ddx = dx;
      ddy = dy;
    }
  }
  for (int i=3; i<hit1.length; i=i+4) {//大きいブロックの間、右下
    int ref6=0;
    if (hit6[i] > 0) {
      show_block3(i, 60);
      ref6 = checkHitBlock1(i, 1.5, x, y);
      switch(ref6) {
      case 1:
      case 3:
        player1.trigger();//ブロックにボールが当たった時の音
        hit6[i]=hit6[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;
        dx = -1*dx;
        break;
      case 2:
      case 4:
        player1.trigger();//ブロックにボールが当たった時の音
        hit6[i]=hit6[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dy = -1*dy;
        break;
      case 5:
      case 6:
      case 7:
      case 8:
        player1.trigger();//ブロックにボールが当たった時の音
        hit6[i]=hit6[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit+ 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        dy = -1*dy;
        break;
      }
      ddx = dx;
      ddy = dy;
    }
  }

  for (int i=0; i<hit1.length; i++) {//大きいブロックの下の段
    int ref1=0;
    if (hit1[i] > 0) {
      show_block1(i, 80);
      ref1 = checkHitBlock1(i, 2, x, y);
      switch(ref1) {
      case 1:
      case 3:
        player1.trigger();//ブロックにボールが当たった時の音
        hit1[i]=hit1[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        break;
      case 2:
      case 4:
        player1.trigger();//ブロックにボールが当たった時の音
        hit1[i]=hit1[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dy = -1*dy;
        break;
      case 5:
      case 6:
      case 7:
      case 8:
        player1.trigger();//ブロックにボールが当たった時の音
        hit1[i]=hit1[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit+ 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        dy = -1*dy;
        break;
      }
      ddx = dx;
      ddy = dy;
    }
  }

  for (int i=0; i<hit7.length; i++) {//大きいブロックの下の段
    int ref7=0;
    if (hit7[i] > 0) {
      show_block3(i, 100);
      ref7 = checkHitBlock1(i, 2.5, x, y);
      switch(ref7) {
      case 1:
      case 3:
        player1.trigger();//ブロックにボールが当たった時の音
        hit7[i]=hit7[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        break;
      case 2:
      case 4:
        player1.trigger();//ブロックにボールが当たった時の音
        hit7[i]=hit7[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit + 1;//ブロックに当たった回数のカウントを1増やす
        dy = -1*dy;
        break;
      case 5:
      case 6:
      case 7:
      case 8:
        player1.trigger();//ブロックにボールが当たった時の音
        hit7[i]=hit7[i]-1;//当たったブロックの部分の配列の中身を1減らす
        hit = hit+ 1;//ブロックに当たった回数のカウントを1増やす
        dx = -1*dx;
        dy = -1*dy;
        break;
      }
      ddx = dx;
      ddy = dy;
    }
  }

  strokeWeight(3);//枠線の幅を調整する関数
  stroke(140, 79, 65, fill2);//枠線の色
  fill(249, 231, 150, fill2);//スコアなどを表示する部分の背景色
  rect(10, height-115, 110, 100);//スコアなどを表示する場所

  fill(140, 79, 65, fill1);//スコアなどの文字の色
  textFont(font2, 10);
  textAlign(LEFT);
  text("Count", 20, height-90);
  text("Life", 20, height-75);
  text("Combo", 20, height-60);
  text("Hit", 20, height-45);
  text("Point", 20, height-30);
  textAlign(RIGHT);
  text(count, 110, height-90);
  text(miscount1, 110, height-75);
  text(combo, 110, height-60); 
  text(hit, 110, height-45); 
  text(count*10+combo*100+hit*50, 110, height-30);//ゲーム中に表示されるスコアはカウントとコンボ数に依存している

  if (y+ah >= 500 && y+ah <=505) {//ラケットとの当たり判定
    if (count%10 == 9) {//10回当たると
      combo =combo +1;//コンボが増える
    }
    if ((x >= mx)&&(x+aw <= mx+60)) {
      player3.trigger();//ラケットで跳ね返した時に音を鳴らす
      dy = -2;//コンボ数によって跳ね返した時の速さが違う
      count = count + 1;//跳ね返した回数を数える変数
    }
  } else if (y+ah > height) {//打ち損じの処理
    x = random(50, 350);//リスポーン地点はランダム
    y = 250;
    dx = 1;
    dy = 2;
    ddx = dx;
    ddy = dy;
    if (miscount1>0) {
      point1[4-miscount1]=count*10+combo*100;//ボールを落とした時に、配列内にスコアを保存
      miscount1 = miscount1 -1;//残機数を減らす
    }
    if (miscount1 == 0) {//残機が0のとき
      for (int i=0; i<point1.length; i++) {
        pointsum = pointsum + point1[i];//配列に保存されたスコアを合計する
      }
      pointsum = pointsum + hit * 50;//最終スコアは壊したブロックの数も影響してくる
    }
    count = 0;//跳ね返した回数のリセット
    combo = 0;//コンボ数のリセット
  }
}