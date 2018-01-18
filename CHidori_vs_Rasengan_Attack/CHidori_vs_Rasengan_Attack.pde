//Major Project
//January 18, 2018

//Evan and Talon
//Sprite sheets from Neimad

//Button code taken from bouncingBallDemo
//Known bugs: collision 

//We deserve extra for experts for: extreme undertaking in regards to scale of project. Tried our best to make a true fighting game that includes the elements of any real one. 
//Many hours were poured into development, and elements such as the player class are impressive in the sense that it uses all other classes within it to do everything it needs.

import processing.video.*;
import ddf.minim.*;

//numbers
int state;
int playerHealth;
float player1X, player2X;
float playerY;
float movieDuration, movieTime;
int counter;

//images
PImage openingBackground, menuBackground, backgroundGameImage, optionsImage, groundImage;

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
  size(1600, 900); //do not change, resolution does not scale

  //player health and location set.
  playerHealth = 600;
  player1X = 100;
  player2X = 1600;
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
  groundImage = loadImage("Menu/ground.png");

  //resizes all backgrounds
  backgroundGameImage.resize(width, height);
  openingBackground.resize(width, height);
  menuBackground.resize(width, height);
  optionsImage.resize(width, height);
  groundImage.resize(width, 600);

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

  //COMMENT BACK IN IF NEEDED DURING PRESENTATION OR IF DEMONSTRATING IN FUTURE YEARS ;)
  //options.calculator();
  //options.display();
  //startGame.calculator();
  //startGame.display();
  //COMMENT BACK IN IF NEEDED DURING PRESENTATION OR IF DEMONSTRATING IN FUTURE YEARS ;)

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
  //if either play dies, stop the music, change the background, and display win text
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
  //calls ground image and sets mode to corner for display
  imageMode(CORNER);
  image(groundImage, 0, 346);
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