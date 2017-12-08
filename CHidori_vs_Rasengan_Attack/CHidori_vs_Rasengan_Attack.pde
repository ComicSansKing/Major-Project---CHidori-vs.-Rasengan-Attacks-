//Paired Programming Assignment

//Evan, Talon, and Gavin
//Button code taken from bouncingBallDemo
//Known bugs: back button does not yet work


import processing.video.*;
import ddf.minim.*;


int state;
int playerHealth;
float player1X, player2X;
float playerY;
float movieDuration, movieTime;
PImage openingBackground, menuBackground, backgroundGameImage, optionsImage;

Minim minim;
AudioPlayer menu;
AudioPlayer buttonSound;

Animation naruto;
Animation sasuke;
Player player1;
Player player2;

Button startGame;
Button options;
Button back;

Movie openingMovie;


void setup() {

  fullScreen();



  //size(800,800);

  playerHealth = 200;

  player1X = 100;
  player2X = 1000;
  playerY = 600;



  player1 = new Player(player1X, playerY, 1, playerHealth, 25);
  player2 = new Player(player2X, playerY, 2, playerHealth, 25);
  naruto = new  Animation(1, player1);
  sasuke = new Animation(2, player2);

  openingMovie = new Movie(this, "Menu/Opening Movie.mp4");

  backgroundGameImage = loadImage("back.jpg");
  openingBackground = loadImage("Menu/Opening Image.jpg");
  menuBackground = loadImage("Menu/Menu Image.jpg");
  optionsImage = loadImage("Menu/optionsImage.png");

  backgroundGameImage.resize(width, height);
  openingBackground.resize(width, height);
  menuBackground.resize(width, height);
  optionsImage.resize(width, height);

  startGame = new Button (width/1.5, height/2.5, 0);
  options = new Button(width/1.5, (height/2.5 + height/4), 1);
  back = new Button(width/2.75, (height/2 + height/4), 2);

  minim = new Minim(this);
  menu = minim.loadFile("Menu/menu.mp3");
  buttonSound = minim.loadFile("Menu/buttonSound.mp3");
  buttonSound.setGain(30);

  playMovie();
}

void playMovie() {
  openingMovie.play();
  openingMovie.noLoop();

  movieDuration = openingMovie.duration();
  movieTime = openingMovie.time();
}

void stopMovie() {
  openingMovie.stop();
}


void movieEvent(Movie opening) {
  opening.read();
}

void playMenuMusic() {
  menu.play();
}

void stopMenuMusic() {
  menu.pause();
}

void startMenu() {
  background(openingBackground);
}

void draw() {
  reset();
  statePicker();
}

void reset() {
  if (back.state == 0 && startGame.state == 0 && options.state == 2) {
    stateMenu();
  }
}


void statePicker() {
  if (startGame.state == 0) { //start screen
    stateOpening();
  }  
  if (startGame.state == 1) { //in game
    stateGame();
  } 
  if (options.state == 2) {//options
    stateOptions();
    back.state = 0;
  }
  if (back.state == 3) {//back to menu
    startGame.state = 0;
    stateMenu();
    back.state = 0;
  }

  if (startGame.mouseIsOnButton() || options.mouseIsOnButton() || back.mouseIsOnButton()) {
    buttonSound.play();
  } else {
    buttonSound.loop();
    buttonSound.pause();
  }
}


void stateOpening() {
  image(openingMovie, 0, 0, width, height);
  startGame.calculator();
  startGame.display();
  options.calculator();
  options.display();
  if (millis() > 30500) {
    stateMenu();
  }
}

void stateMenu() {

  stopMovie();
  startMenu();
  playMenuMusic();

  options.calculator();
  options.display();

  startGame.calculator();
  startGame.display();
}

void stateGame() {

  background(backgroundGameImage);
  stopMenuMusic();
  player1.playerfunc(player2);
  player2.playerfunc(player1);
  player1.display();
  player2.display();
}

void stateOptions() {
  background(optionsImage);
  back.calculator();
  back.display();
}




void mousePressed() {
  startGame.mousePressed();
  options.mousePressed();
  back.mousePressed();
}



void keyPressed() {
  player1.keyPressed(); 
  player2.keyPressed();
}

void keyReleased() {
  player1.keyReleased(); 
  player2.keyReleased();
}