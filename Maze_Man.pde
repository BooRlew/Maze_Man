//Made by Richard
//Need to make character move .-.




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
  if (state != 0 && state != 1) {
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

  //Display Start Button
  if (mouseX > width/2 - 125.5 && mouseX < width/2 + 125.5 && mouseY < height/2 + 200 && mouseY > height/2 + 100) {
    image(buttonHovered, width/2 - 125.5, height/2 + 100);
    if (mousePressed) {
      //callCharStart();
      state = 2;
    }
  } else {
    image(button, width/2 - 125.5, height/2 + 100);
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
    if (movingUp) {
      charY--;
    }
    
    if (movingDown) {

        charY ++;
    }
    if(keyPressed){
    if (key == 'a'|| key == 'A') {

      if (tiles[charX - 1][charY] == '#') {
      } else {
        charX --;
      }
      //print(charX + " | ");
    }
    
    if (key == 'd'|| key == 'D') {

      if (tiles[charX+1][charY] == '#') {
      } else {
        charX ++;
      }
      //print(charX + " | ");
    }
}
}

void moveUp(){
        if (tiles[charX][charY-1] == '#') {
      } else {
        charY --;
      }
  
}

void drawGrid() {
  image(wallpaper, 0, 0, width, height); 

  loadLevel();

  //identify which box shows up as what
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tiles[x][y] == '#') {
        //fill(0, 150);
        image(wall, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      } else if (tiles[x][y] == 'S') {
        //fill(0, 200, 0, 80);
        image(start, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      } else if (tiles[x][y] == 'E') {
        //fill(255, 0, 0, 80);
        image(end, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      } else if (tiles[x][y] == 'P') {
        //fill(255, 0, 255, 80);
        image(portalEnter, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      } else if (tiles[x][y] == 'O') {
        //fill(150, 0, 255, 80);
        image(portalExit, x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
      } 
      //else {
      //fill(255, 0);
      //}
      //rect(x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
    }
  }
  displayChar();
}

void callCharStart() {
  if (state == 2) {
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
  if (state == 2) {
    levelToLoad = "Level/1.txt";

    //extracts the level data from text files
    String lines[] = loadStrings(levelToLoad);
    for (int y=0; y < gridDimension; y++) {
      for (int x=0; x < gridDimension; x++) {
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