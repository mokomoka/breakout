import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioSample player1;//コイン音
AudioPlayer player2;//ゲームオーバー音
AudioSample player3;//ジャンプ音
AudioPlayer player4;//ゴール音
AudioPlayer player5;//ポーズ音
PFont font1, font2;
PImage star, biscuit, candy1, candy2, candy3, candy4;

float x, y, dx, dy, ddx, ddy, mx, aw, ah, bw1, bw2, bh1, bh2;
int count, miscount1, miscount2, combo, hit, block, pointsum, itempoint, fill1, fill2;
int pointsum1 = 0;
int pointsum2 = 0;
int point1[]=new int[4];
int point2[]=new int[4];
int hit1[]=new int[20];
int hit3[]=new int[20];
int hit4[]=new int[20];
int hit5[]=new int[20];
int hit6[]=new int[20];
int hit7[]=new int[20];
int hit2[]=new int[10];
int hit8[]=new int[10];
int item[]=new int[10];
String GameStatus, StatusSave;


void setup() {
  frameRate(60);
  size(400, 600);
  minim = new Minim(this);
  player1 = minim.loadSample("mariocoin.wav");
  player2 = minim.loadFile("mariodie.wav");
  player3 = minim.loadSample("mariojump.wav");
  player4 = minim.loadFile("mariogoal.wav");
  player5 = minim.loadFile("mariopause.wav");
  font1 = loadFont("04b30-50.vlw");
  font2 = loadFont("04b30-15.vlw");
  star = loadImage("star.png");
  biscuit = loadImage("biscuit1.png");
  candy1=loadImage("CandyPink.png");
  candy2=loadImage("CandyGreen.png");
  candy3=loadImage("CandyOrange.png");
  candy4=loadImage("CandyLightBlue.png");
  noCursor();//カーソルを非表示に

  x = random(50, 350);//初期位置x
  y = 250;//初期位置y
  dx = 1;//初期移動距離
  dy = 2;//初期移動距離
  aw =10.0;//ボールサイズ横
  ah =10.0;//ボールサイズ縦
  bw1 =20.0;//小ブロック横
  bw2 =40.0;//大ブロック横
  bh1 =20.0;//小ブロック縦
  bh2 =40.0;//大ブロック縦
  ddy = 2;
  ddx = 1;//一時停止解除後、ボールの速度を元に戻せるように保存する変数
  count = 0;//跳ね返した回数
  miscount1 = 3;//残機
  miscount2 = 4;//残機
  combo = 0;//コンボ
  hit = 0;//ブロックに当たった数
  block = 0;//壊したブロックの数
  pointsum = 0;//合計得点・最終スコア
  itempoint = 0;//アイテムを取った個数
  fill1 = 255;//ゲームオーバーの時にラケットやボールを透明にするため
  fill2 = 160;//ゲームオーバーの時に左下を非表示にするため
  for (int i=0; i<4; i++) {//点数用配列
    point1[i]=0;
    point2[i]=0;
  }
  for (int i=0; i<20; i++) {//ブロック用配列
    hit1[i]=1;
    hit7[i]=1;
    hit3[i]=hit4[i]=hit5[i]=hit6[i]=0;
  }
  for (int i=2; i<20; i=i+4) {//ブロック用配列
    hit3[i]=1;
    hit5[i]=1;
  }
  for (int i=3; i<20; i=i+4) {//ブロック用配列
    hit4[i]=1;
    hit6[i]=1;
  }
  for (int i=0; i<10; i++) {//ブロック用配列
    hit2[i]=2;
    hit8[i]=2;
    item[i]=1;
  }
  GameStatus = "StatusStart";//画面状態用
}

void draw() {
  if (GameStatus == "StatusStart") {//スタート画面の状態
    dispStart();
    if (mousePressed == true) {//クリックすると
      GameStatus = "Description";//簡易的な操作説明が表示される
    }
    if (key == ' ') {//キーを押すことでStatusに代入する文字を変え、場面が切り替わるようにしている
      GameStatus = "StatusPlay1";//プレイ画面へ移行
    }
  } else if (GameStatus == "Description") {//説明画面
    dispDescription();
    if (key == ' ') {
      GameStatus = "StatusPlay1";//プレイ画面へ移行
    }
  } else if (GameStatus == "StatusPlay1") {//ステージひとつめ
    dispGame1();
    if (key =='f' || key =='j') {//ポーズ機能
      StatusSave = "StatusPlay1";//復帰するときにきちんとこのステージに戻ってこれるよう、ステージの状態を保存します
      GameStatus = "StatusPause";
    }
  } else if (GameStatus == "StatusPlay2") {//ステージふたつめ
    dispGame2();
    if (key =='f' || key =='j') {//ポーズ機能
      StatusSave = "StatusPlay2";//復帰するときにきちんとこのステージに戻ってこれるよう、ステージの状態を保存します
      GameStatus = "StatusPause";
    }
  } else if (GameStatus == "StatusClear1") {//ステージひとつめクリア画面
    dispClear1();//クリア画面を表示
    if (mousePressed == true) {//次のステージへ
      setup();//値を初期化
      GameStatus = "StatusPlay2";
    }
  } else if (GameStatus == "StatusClear2") {//ステージふたつめクリア画面
    dispClear2();
  } else if (GameStatus == "StatusOver") {//ゲームオーバー画面
    dispOver();
    if (mousePressed == true) {//リトライ
      setup();
      GameStatus = "StatusPlay1";
    }
  } else if (GameStatus == "StatusPause") {//ポーズ画面
    dispPause();
    if (key=='d' || key == 'k') {//ゲームに復帰
      player5 = minim.loadFile("mariopause.wav");
      GameStatus = StatusSave;
      dx=ddx;//ここで変化量を元の値に戻す
      dy=ddy;
    }
  }
}

void dispPause() {//ポーズ画面表示用の関数
  player5.play();
  dx = 0;
  dy = 0;
  textAlign(CENTER);//テキストの座標の指定を中心にする
  textFont(font1, 50);
  text("Pause", width/2, height/2);
}

void dispStart() {//スタート画面表示用の関数
  background(255, 204, 185);
  noStroke();
  fill(255, 198, 185);
  check_pattern();
  textAlign(CENTER);//テキストの座標の指定を中心にする
  textFont(font1, 50); //フォントとサイズの指定
  fill(140, 79, 65);
  text("Breakout", width/2, height/2-20);
  textSize(20);
  text("Press Space Key!", width/2, height/2+30);
  text("Click the window", width/2, height/2+70);
  text("to get the Explanation", width/2, height/2+90);
}

void dispDescription() {//説明画面表示用の関数
  background(255, 204, 185);
  noStroke();
  fill(255, 198, 185);
  check_pattern();
  textAlign(CENTER);//テキストの座標の指定を中心にする
  textFont(font1, 28);//フォントとサイズの指定
  fill(140, 79, 65);
  text("Operations manual", width/2, 70);
  text("When you are ready", width/2, 450);
  text("Press Space Key!", width/2, 500);
  textSize(20);
  text("Space key", width/2, 150);
  text("Game Start", width/2, 180);
  text("f or j key", width/2, 230);
  text("Pause", width/2, 260);
  text("d or k key", width/2, 300);
  text("Return from Pause", width/2, 330);
}

void dispClear1() {//ゲームクリア画面表示用の関数
  player4.play();//ゲームクリア用の音楽
  mx = width/2-25;
  dx = 0; 
  dy = 0;
  fill(140, 79, 65);
  textAlign(CENTER);//テキストの座標の指定を中心にする
  textFont(font1, 40);//フォントとサイズの指定
  text("Stage1 Clear", width/2, height/2-20);
  textFont(font1, 20);//フォントとサイズの指定
  text("Total Score", width/2-60, height/2+40);
  pointsum1 = point1[0]+point1[1]+point1[2]+point1[3] +miscount1*1000+2000;//トータルスコアの計算
  text(pointsum1, width/2+80, height/2+40);
  text("Click to the Next Stage!", width/2, height/2+70);
  fill1 = 0;//ラケットやボールや文字を非表示に
  fill2 = 0;//スコアなどを表示する部分の背景を非表示に
}

void dispClear2() {//ゲームクリア画面表示用の関数
  player4.play();//ゲームクリア用の音楽
  mx = width/2-25;
  dx = 0; 
  dy = 0;
  fill(140, 79, 65);
  textAlign(CENTER);//テキストの座標の指定を中心にする
  textFont(font1, 48);//フォントとサイズの指定
  text("Complete!", width/2, height/2-20);
  textFont(font1, 20);//フォントとサイズの指定
  text("Total Score", width/2-60, height/2+40);
  pointsum2 = pointsum1 +point2[0]+point2[1]+point2[2]+point2[3]
    +miscount2*1000+3000;//トータルスコアの計算
  text(pointsum2, width/2+90, height/2+40);
  fill1 = 0;//ラケットやボールや文字を非表示に
  fill2 = 0;//スコアなどを表示する部分の背景を非表示に
}

void dispOver() {//ゲームオーバー画面表示用の関数
  player2.play();//ゲームオーバー用の音楽
  mx = width/2-25;
  x = aw; 
  y = ah;
  dx = 0; 
  dy = 0;
  fill(140, 79, 65);
  textAlign(CENTER);//テキストの座標の指定を中心にする
  textFont(font1, 45);//フォントとサイズの指定
  text("Game Over", width/2, height/2-20);
  textFont(font1, 20);//フォントとサイズの指定
  text("Total Score", width/2-50, height/2+40);
  text(pointsum, width/2+85, height/2+40);// ゲームオーバーの場合、ボーナスポイントはないのでゲーム中に計算されたスコアを表示
  text("Click the window to Retry!", width/2, height/2+70);
}


void stop() {
  player1.close();
  player2.close();
  player3.close();
  minim.stop();
  super.stop();
}