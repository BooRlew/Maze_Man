//Made by Richard
//Need to make Character select screen




int cols, rows;
int gridDimension;
int charX, charY;
float boxWidth, boxHeight;
float gridXOffset, gridYOffset;
String levelToLoad;
float state;
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
  state = 0;

  movingUp = false;
  movingDown = false;
  movingLeft = false;
  movingRight = false;

  initializeValues();
  loadImages();

  //declare Array
  int [][] grid = new int[cols][rows];
}

void draw() {
  background(255, 0, 0);
  //callLevel();

  if (state == 0) {
    displayMenu();
    callCharStart();
  }
  if (state == 2) {
  }
  if (state >= 3) {
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

void displayMenu() {
  image(background, 0, 0, width, height);
  fill(0);

  //Display Buttons
  
  //Start Button
  if (mouseX > width/2 - 125.5 && mouseX < width/2 + 125.5 && mouseY < height/2 + 125 && mouseY > height/2 + 25) {
    image(buttonHovered, width/2 - 125.5, height/2 + 25);
    rect(width/2, height/2 + 250, 250, 100);
    cursor(HAND);
    if (mousePressed) {
      //callCharStart();
      cursor(ARROW);
      state = 3;
    }
  }
  
  //Character Select Button
  else if (mouseX > width/2 - 125.5 && mouseX < width/2 + 125.5 && mouseY < height/2 + 300 && mouseY > height/2 + 200) {
    image(button, width/2 - 125.5, height/2 + 25);
    cursor(HAND);

    fill(50);
    rect(width/2, height/2 + 250, 250, 100);
    if (mousePressed) {
      //callCharStart();
      cursor(ARROW);
      state = 2;
    } else {
      image(button, width/2 - 125.5, height/2 + 25);
      rectMode(CENTER);
      rect(width/2, height/2 + 250, 250, 100);
      cursor(ARROW);
    }
  }
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
}

void displayChar() {
  character = player;
  image(character, charX*boxWidth + gridXOffset, charY*boxHeight + gridYOffset, boxWidth, boxHeight);
}

void moveChar() {
  if (movingUp && tiles[charX][charY - 1] != '#') {
    charY--;
  }
  if (movingDown && tiles[charX][charY + 1] != '#') {
    charY ++;
  }
  if (movingLeft  && tiles[charX - 1][charY] != '#') {
    charX --;
  }
  if (movingRight  && tiles[charX + 1][charY] != '#') {
    charX ++;
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

void callCharStart() {
  if (state == 3) {
    levelToLoad = "Level/1.txt";

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
      }
    }
  }
}

void loadLevel() {
  if (state == 3) {
    levelToLoad = "Level/1.txt";

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