int cols, rows;
int gridDimension;
float boxWidth, boxHeight;
float gridXOffset, gridYOffset;
String levelToLoad;

void setup() {
  size (700, 700);
  //fullScreen();
  noStroke();

  //set variable for grid dimensions
  gridDimension = 25;

  boxWidth = width/gridDimension;
  boxHeight = height/gridDimension;

  cols = int(width/boxWidth);
  rows = int(height/boxHeight);
  
  gridXOffset = (width%(boxWidth * cols))/2;
  gridYOffset = (height%(boxHeight * rows)/2);


  //declare Array
  int [][] grid = new int[cols][rows];
  
  
  //for (int i = 0; i < cols; i++){
  //  for(int j = 0; j < rows; j++){
  //    grid[i][j] = i;
  //  } 
  //}
}

void draw() {
  background(255, 0 ,0);

  drawGrid();
}

void drawGrid() {
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      if ((x + y) % 2 == 0) {
        fill(230);
      }else{
        fill(255); 
      }
      rect(x*boxWidth + gridXOffset, y*boxHeight + gridYOffset, boxWidth, boxHeight);
    }
  }
}

void callLevel(){
  
}