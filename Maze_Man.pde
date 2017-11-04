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

void setup() {
  size (800, 800);

  noStroke();
  state = 0;

  initializeValues();
  loadImages();

  //declare Array
  int [][] grid = new int[cols][rows];
}

void draw() {
  background(255, 0, 0);
  callLevel();

  if (state == 0) {
    displayMenu();
  }
  if (state != 0) {
    drawGrid();
    //displayChar();
  }
}

void loadImages() {
  background = loadImage("Image/MazeGameMenu.png");

  button = loadImage("Image/StartButton.png");
  buttonHovered = loadImage("Image/StartButtonHovered.png");

  wallpaper = loadImage("Image/wallpaper.jpg");
}

void displayMenu() {
  image(background, 0, 0, width, height);

  //Display Start Button
  if (mouseX > width/2 - 125.5 && mouseX < width/2 + 125.5 && mouseY < height/2 + 200 && mouseY > height/2 + 100) {
    image(buttonHovered, width/2 - 125.5, height/2 + 100);
    if (mousePressed) {
      callLevel();
      state = 1;
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
  fill(0, 200);
  ellipseMode(CORNER);
  ellipse(charX*boxWidth + gridXOffset, charY*boxHeight + gridYOffset, boxWidth, boxHeight);
  //if (keyPressed) {
  //  if (key == 'w'|| key == 'W') {
  //    charY --;
  //  } else if (key == 's'|| key == 'S') {
  //    charY ++;
  //  } else if (key == 'a'|| key == 'A') {
  //    charX --;
  //  } else if (key == 'd'|| key == 'D') {
  //    charX ++;
  //  }
  //}
}

void drawGrid() {
  image(wallpaper, 0, 0, width, height); 

  //identify which box shows up as what
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tiles[x][y] == '#') {
        fill(0, 150);
      } else if (tiles[x][y] == 'S') {
        fill(0, 200, 0, 80);
      } else if (tiles[x][y] == 'E') {
        fill(255, 0, 0, 80);
      } else if (tiles[x][y] == 'P') {
        fill(255, 0, 255, 80);
      } else if (tiles[x][y] == 'O') {
        fill(150, 0, 255, 80);
      } else {
        fill(255, 0);
      }
      rect(x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
    }
  }
  displayChar();
}

void callLevel() {
  if (state == 1) {
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

void keyPressed() {
  if (keyPressed) {
    if (key == 'w'|| key == 'W') {
      charY--;
    } else if (key == 's'|| key == 'S') {
      charY ++;
    } else if (key == 'a'|| key == 'A') {
      charX --;
    } else if (key == 'd'|| key == 'D') {
      charX ++;
    }
  }
}