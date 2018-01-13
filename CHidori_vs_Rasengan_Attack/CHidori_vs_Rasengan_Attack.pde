//Major Project

//Evan and Talon
//Button code taken from bouncingBallDemo
//Known bugs: collision 

import processing.video.*;
import ddf.minim.*;

//numbers
int state;
int playerHealth;
float player1X, player2X;
float playerY;
float movieDuration, movieTime;
int counter = 0;

//images
PImage openingBackground, menuBackground, backgroundGameImage, optionsImage;

//audio
Minim minim;
AudioPlayer menu;
AudioPlayer buttonSound;
AudioPlayer gameMusic;

//players
Player player1;
Player player2;

//buttons
Button startGame;
Button options;
Button back;

//movie
Movie openingMovie;

void setup() {
  fullScreen();
  //size(800,800);

  //player health and location set.
  playerHealth = 600;
  player1X = 100;
  player2X = 1000;
  playerY = 600;

  //player location set as well as animation
  player1 = new Player(player1X, playerY, 1, playerHealth, 110, 0);
  player2 = new Player(player2X, playerY, 2, playerHealth, 110, 0);


  //loads movie
  openingMovie = new Movie(this, "Menu/Opening Movie.mp4");

  //loads all backgrounds
  backgroundGameImage = loadImage("back.jpg");
  openingBackground = loadImage("Menu/Opening Image.jpg");
  menuBackground = loadImage("Menu/Menu Image.jpg");
  optionsImage = loadImage("Menu/optionsImage.png");

  //resizes all backgrounds
  backgroundGameImage.resize(width, height);
  openingBackground.resize(width, height);
  menuBackground.resize(width, height);
  optionsImage.resize(width, height);

  //creates button locations
  startGame = new Button (width/1.5, height/2.5, 0);
  options = new Button(width/1.5, (height/2.5 + height/4), 1);
  back = new Button(width/2.75, height/2, 2);

  //loads sounds
  minim = new Minim(this);
  menu = minim.loadFile("Menu/menu.mp3");
  buttonSound = minim.loadFile("Menu/buttonSound.mp3");
  buttonSound.setGain(30);
  gameMusic = minim.loadFile("Menu/game.mp3");

  //starts movie function
  playMovie();
}

void playMovie() {
  //plays movie and stops from looping
  openingMovie.play();
  openingMovie.noLoop();

  //sets variables for movie being done later
  movieDuration = openingMovie.duration();
  movieTime = openingMovie.time();
}

void stopMovie() {
  openingMovie.stop();
}

void movieEvent(Movie opening) {
  //auto calls, reads the file to load
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
  //starts states, reset doesn't work yet

  reset();
  statePicker();
  deathCheck();
}

void reset() {
  //doesn't work yet
  if (back.state == 3 && startGame.state == 0 && options.state == 2) {
    stateMenu();
    options.state = 0;
    back.state = 0;
  }
}


void statePicker() {
  //if any of these states are true load this function
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
    reset();
  }

  //if any are true then play the sound
  if (startGame.mouseIsOnButton() || options.mouseIsOnButton() || back.mouseIsOnButton()) {
    if (startGame.state == 0 || options.state == 2) {
      buttonSound.play();
    }
    //else stop and loop so it restarts
  } else {
    buttonSound.loop();
    buttonSound.pause();
  }
}

void stateOpening() {
  //loads movie

  image(openingMovie, 0, 0, width, height);
  options.calculator();
  options.display();

  startGame.calculator();
  startGame.display();
  //if enough time passes then start menu
  if (millis() > 30500) {
    stateMenu();
  }
}

void stateMenu() {
  //load buttons, start music, stop the movie
  stopMovie();
  startMenu();
  playMenuMusic();

  options.calculator();
  options.display();

  startGame.calculator();
  startGame.display();
}

void stateGame() {
  //sets background, stops music, and calls players
  background(backgroundGameImage);
  stopMenuMusic();
  gameMusic.play();
  player1.playerFunc(player2);
  player2.playerFunc(player1);
  player1.display();
  player2.display();
  ground();
}

void stateOptions() {
  //loads image, displays button
  background(optionsImage);
  back.calculator();
  back.display();
}

void deathCheck() {
  if (player1.death == 1) {
    gameMusic.pause();
    background(0, 34, 160);
    textAlign(CENTER);
    fill(255);
    textSize(50);
    text("Sasuke Wins", width/2, height/2);
  }
  if (player2.death == 1) {
    gameMusic.pause();
    background(252, 176, 45);
    textAlign(CENTER);
    fill(255);
    textSize(50);
    text("Naruto Wins", width/2, height/2);
  }
}

void ground() {
  rectMode(CORNER);
  fill(11, 81, 2);
  rect(0, 700, width, height);
  rectMode(CENTER);
}

void mousePressed() {
  //if mouse pressed call button
  startGame.mousePressed();
  options.mousePressed();
  back.mousePressed();
}

void keyPressed() {
  //if key pressed call in player
  player1.keyPressed(); 
  player2.keyPressed();
}

void keyReleased() {
  //if key released call in player
  player1.keyReleased(); 
  player2.keyReleased();
}