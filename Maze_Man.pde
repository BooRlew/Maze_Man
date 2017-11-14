//Made by Richard
//It is far to difficult to make levels so I oonly made 2.
//Need to replace any green with actual art




int cols, rows;
int gridDimension;
int charX, charY;
int waitTime, lastMoveTime;
int[][] grid;
int pX, pY, oX, oY;
//pX and pY are the XY co-ords for entrance protal. They are named because of the name in the text file. Same for oX and oY.

float boxWidth, boxHeight;
float gridXOffset, gridYOffset;
float state;

String levelToLoad;

char tileType;
char[][] tiles;

PImage background;
PImage button, buttonHovered;
PImage wallpaper;
PImage player, player1, player2, player3, character;
PImage wall, portalEnter, portalExit, start, end;

boolean movingUp, movingDown, movingLeft, movingRight;

void setup() {
  size (800, 800);

  noStroke();
  state = 5;

  movingUp = false;
  movingDown = false;
  movingLeft = false;
  movingRight = false;

  initializeValues();
  loadImages();
  character = player;

  //declare Array
  grid = new int[cols][rows];
}

void draw() {
  background(255, 0, 0);
  //callLevel();

  if (state == 1) {
    displayMenu();
    loadDiferentTiles();
  }
  if (state == 2) {
    characterSelect();
  }
  if (state == 5) {
    displayEnd();
  } else if (state >= 3) {
    detectWin();
    drawGrid();
    displayChar();
    moveChar();
  }
}

void loadImages() {
  background = loadImage("Image/MazeGameMenu.png");

  button = loadImage("Image/StartButton.png");
  buttonHovered = loadImage("Image/StartButtonHovered.png");

  player = loadImage("Image/Player.png");
  player1 = loadImage("Image/Player1.png");
  player2 = loadImage("Image/Player2.png");
  player3 = loadImage("Image/Player3.png");

  wall = loadImage("Image/Wall.png");

  portalEnter = loadImage("Image/PortalOpen.png");
  portalExit = loadImage("Image/PortalExit.png");

  start = loadImage("Image/Start.png");
  end = loadImage("Image/End.png");

  wallpaper = loadImage("Image/wallpaper.jpg");
}

void displayEnd() {
  background(0, 255, 0);
  fill(0, 200, 0);
  text("YOU WIN", 100, 100);
  homeButton();
}

void displayMenu() {
  image(background, 0, 0, width, height);
  //fill(0);

  //Change cursor based on if over a button
  if (mouseX > width/2 - 125.5 && mouseX < width/2 + 125.5 && mouseY < height/2 + 300 && mouseY > height/2 + 200 || mouseX > width/2 - 125.5 && mouseX < width/2 + 125.5 && mouseY < height/2 + 125 && mouseY > height/2 + 25) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }

  //Display Buttons

  //Start Button
  if (mouseX > width/2 - 125.5 && mouseX < width/2 + 125.5 && mouseY < height/2 + 125 && mouseY > height/2 + 25) {
    image(buttonHovered, width/2 - 125.5, height/2 + 25);
    rect(width/2, height/2 + 250, 250, 100);
    //cursor(HAND);

    if (mousePressed) {
      //callCharStart();
      cursor(ARROW);
      state = 3;
    }
  } else {
    image(button, width/2 - 125.5, height/2 + 25);
    //cursor(ARROW);
  }

  //Character Select Button
  if (mouseX > width/2 - 125.5 && mouseX < width/2 + 125.5 && mouseY < height/2 + 300 && mouseY > height/2 + 200) {
    //cursor(HAND);

    fill(0, 200, 0);
    rect(width/2, height/2 + 250, 250, 100);
    if (mousePressed) {
      //callCharStart();
      cursor(ARROW);
      state = 2;
    }
  } else {
    fill(0, 255, 0);
    rectMode(CENTER);
    rect(width/2, height/2 + 250, 250, 100);
    //cursor(ARROW);
  }
}

void characterSelect() {
  background(0, 255, 0);

  imageMode(CENTER);

  //hover over first choice
  if (mouseX > 50 && mouseX < 150 && mouseY < height/2 + 50 && mouseY > height/2 - 50) {
    image(player, 100, height/2, 110, 110);
    if (mousePressed) {
      character = player;
    }
  } else {
    image(player, 100, height/2);
  }
  //hover second choice
  if (mouseX > 250 && mouseX < 350 && mouseY < height/2 + 50 && mouseY > height/2 - 50) {
    image(player1, 300, height/2, 110, 110);
    if (mousePressed) {
      character = player1;
    }
  } else {
    image(player1, 300, height/2);
  }
  //hover thrid choice
  if (mouseX > 450 && mouseX < 550 && mouseY < height/2 + 50 && mouseY > height/2 - 50) {
    image(player2, 500, height/2, 110, 110);
    if (mousePressed) {
      character = player2;
    }
  } else {
    image(player2, 500, height/2);
  }
  //hover fourth choice
  if (mouseX > 650 && mouseX < 750 && mouseY < height/2 + 50 && mouseY > height/2 - 50) {
    image(player3, 700, height/2, 110, 110);
    if (mousePressed) {
      character = player3;
    }
  } else {
    image(player3, 700, height/2);
  }

  //display your choice
  image(character, width/2, height/4);

  imageMode(CORNER);

  homeButton();
}

void homeButton() {
  rectMode(CORNER);
  if (mouseX > 725 && mouseX < 775 && mouseY > 25 && mouseY < 75) {
    fill(0, 200, 0);
    if (mousePressed) {
      state = 1;
    }
  } else {
    fill(0, 240, 0);
  }
  rect(725, 25, 50, 50);
}


void initializeValues() {
  gridDimension = 25;

  boxWidth = width/gridDimension;
  boxHeight = height/gridDimension;

  cols = int(width/boxWidth);
  rows = int(height/boxHeight);

  gridXOffset = (width%(boxWidth * cols))/2;
  gridYOffset = (height%(boxHeight * rows)/2);

  tiles = new char[cols][rows];

  waitTime = 125;
}

void displayChar() {
  //character = player;
  image(character, charX*boxWidth + gridXOffset, charY*boxHeight + gridYOffset, boxWidth, boxHeight);
}

void moveChar() {
  if (millis() > lastMoveTime + waitTime) {
    if (movingUp && tiles[charX][charY - 1] != '#') {
      charY--;
      if (charX == pX && charY == pY ) {
        charX = oX;
        charY = oY;
      }
      lastMoveTime = millis();
    }
    if (movingDown && tiles[charX][charY + 1] != '#') {
      charY ++;
      if (charX == pX && charY == pY ) {
        charX = oX;
        charY = oY;
      }
      lastMoveTime = millis();
    }
    if (charX >= 1) {
      if (movingLeft  && tiles[charX - 1][charY] != '#') {
        charX --;
        if (charX == pX && charY == pY ) {
          charX = oX;
          charY = oY;
        }
        lastMoveTime = millis();
      }
    }
    if (charX <= 23) {
      if (movingRight  && tiles[charX + 1][charY] != '#') {
        charX ++;
        if (charX == pX && charY == pY ) {
          charX = oX;
          charY = oY;
        }
        lastMoveTime = millis();
      }
    }
  }
}

void detectWin() {
  if (tiles[charX][charY] ==  'E') {
    state++; 
    loadDiferentTiles();
    loadLevel();
  }
}



void drawGrid() {
  image(wallpaper, 0, 0, width, height); 

  loadLevel();

  //identify which box shows up as what
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tiles[x][y] == '#') {
        image(wall, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      } else if (tiles[x][y] == 'S') {
        image(start, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      } else if (tiles[x][y] == 'E') {
        image(end, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      } else if (tiles[x][y] == 'P') {
        image(portalEnter, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      } else if (tiles[x][y] == 'O') {
        image(portalExit, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      }
    }
  }
  displayChar();
}

void loadDiferentTiles() {
  if (state == 3) {
    levelToLoad = "Level/1.txt";
  } else if (state == 4) {
    levelToLoad = "Level/2.txt";
  } else {
    levelToLoad = "Level/blank.txt";
  }

  //extracts the level data from text files
  String lines[] = loadStrings(levelToLoad);
  for (int y=0; y < gridDimension; y++) {
    for (int x=0; x < gridDimension; x++) {
      tileType = lines[y].charAt(x);
      tiles[x][y] = tileType;

      //Finds the starting point
      if (tileType == 'S') {
        charX = x; 
        charY = y;
      }
      if (tileType == 'P') {
        pX = x; 
        pY = y;
      }
      if (tileType == 'O') {
        oX = x; 
        oY = y;
      }
    }
  }
}



void loadLevel() {
  if (state == 3) {
    levelToLoad = "Level/1.txt";
  } else if (state == 4) {
    levelToLoad = "Level/2.txt";
  } else {
    levelToLoad = "Level/blank.txt";
  }

  //extracts the level data from text files
  String lines[] = loadStrings(levelToLoad);
  for (int y=0; y < gridDimension; y++) {
    for (int x=0; x < gridDimension; x++) {

      //Designates each cell as a block
      tileType = lines[y].charAt(x);
      tiles[x][y] = tileType;
    }
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    movingUp = true;
  }
  if (key == 's' || key == 'S') {
    movingDown = true;
  }
  if (key == 'd' || key == 'D') {
    movingRight = true;
  }
  if (key == 'a' || key == 'A') {
    movingLeft = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    movingUp = false;
  }
  if (key == 's' || key == 'S') {
    movingDown = false;
  }
  if (key == 'd' || key == 'D') {
    movingRight = false;
  }
  if (key == 'a' || key == 'A') {
    movingLeft = false;
  }
}