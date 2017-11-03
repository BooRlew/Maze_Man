int cols, rows;
int gridDimension;
int charX, charY;
float boxWidth, boxHeight;
float gridXOffset, gridYOffset;
String levelToLoad;
float state;
char tileType;
char[][] tiles;

void setup() {
  size (700, 700);
  //fullScreen();
  noStroke();
  state = 0;

  initializeValues();

  //declare Array
  int [][] grid = new int[cols][rows];
  



  //for (int i = 0; i < cols; i++){
  //  for(int j = 0; j < rows; j++){
  //    grid[i][j] = i;
  //  } 
  //}
}

void draw() {
  background(255, 0, 0);
  callLevel();

  drawGrid();
  displayChar();
}

void initializeValues(){
  gridDimension = 25;

  boxWidth = width/gridDimension;
  boxHeight = height/gridDimension;

  cols = int(width/boxWidth);
  rows = int(height/boxHeight);

  gridXOffset = (width%(boxWidth * cols))/2;
  gridYOffset = (height%(boxHeight * rows)/2);
  
  tiles = new char[cols][rows];
  
}

void displayChar(){
  charX = 0;
  charY = 1;
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      //ellipse
    }
  }
}

void drawGrid() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if (tiles[x][y] == '#') {
        fill(0);
      } else if(tiles[x][y] == 'S') {
        fill(0 ,200, 0);
      }else if(tiles[x][y] == 'E') {
        fill(255 ,0 , 0);
      }else if(tiles[x][y] == 'P') {
        fill(255 ,0 , 255);
      }else if(tiles[x][y] == 'O') {
        fill(255 ,100 , 255);
      }
      else{
        fill(255); 
      }
      rect(x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
    }
  }
}

void callLevel() {
  if (state == 0) {
    levelToLoad = "Level/1.txt";
    //print(levelToLoad);
    String lines[] = loadStrings(levelToLoad);
    for(int y=0; y < gridDimension; y++){
      for(int x=0; x < gridDimension; x++){
        tileType = lines[y].charAt(x);
        tiles[x][y] = tileType;
        //println(tileType);
      }
    }
  }
}