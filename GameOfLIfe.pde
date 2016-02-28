
Board b;

class Cell {
  int length, x, y;
  boolean alive;

  
  public Cell(int x, int y) {
    this.x = x;
    this.y = y;
    this.length = width/b.getLength();
    this.alive = false; 
  }
  
  public void display(){
    rect(this.length,this.length, this.length*x, this.length*y);
    if (this.alive){
      fill(0);
    } else {
      fill(255);
    }
  }  
  
  public boolean isAlive(){
    return this.alive;
  }
  
  public void setAlive(boolean alive){
    this.alive = alive;
  }
}

class Board {
  Cell[][] grid;
  Cell[][] bufferGrid;
  int length;
  
  public Board(int length) {
    this.length = length;
    grid = new Cell[length][length];
    bufferGrid  = new Cell[length][length];
    
    for (int row = 0; row < grid.length; row++) {
      for (int col = 0; col < grid[row].length; col++) {
        grid[row][col] = new Cell(row,col);
      }
    }
  }
  
  public int getNeighbors(int row, int col) {
    int sum = 0;
    
    if (row > 0 && row < length && col > 0 && col < length){
      for (int i = row - 1; i == row + 1; i++) {
        for (int j = col - 1; j == col + 1; j++) {
          if (i != row && j != col && grid[i][j].isAlive()){
            sum++;
          }
        }
      }
    } else if (row == 0 & col == 0){
      for (int i = row; i == row + 1; i++) {
        for (int j = col; j == col + 1; j++) {
          if (i != row && j != col && grid[i][j].isAlive()){
            sum++;
          }
        }
      }
    } else if (row == 0 && col == length) {
      for (int i = row; i == row + 1; i++) {
        for (int j = col - 1; j == col; j++) {
          if (i != row && j != col && grid[i][j].isAlive()){
            sum++;
          }
        }
      }
    } else if (row == length && col == 0){
      for (int i = row - 1; i == row; i++) {
        for (int j = col - 1; j == col + 1; j++) {
          if (i != row && j != col && grid[i][j].isAlive()){
            sum++;
          }
        }
      }
    } else if (row == length && col == length){
      for (int i = row - 1; i == row; i++) {
        for (int j = col - 1; j == col; j++) {
          if (i != row && j != col && grid[i][j].isAlive()){
            sum++;
          }
        }
      }
    } else if (row == 0){
      for (int i = row; i == row + 1; i++) {
        for (int j = col - 1; j == col + 1; j++) {
          if (i != row && j != col && grid[i][j].isAlive()){
            sum++;
          }
        }
      }
    } else if (row == length){
      for (int i = row - 1; i == row; i++) {
        for (int j = col - 1; j == col + 1; j++) {
          if (i != row && j != col && grid[i][j].isAlive()){
            sum++;
          }
        }
      }
    } else if (col == 0){
      for (int i = row - 1; i == row + 1; i++) {
        for (int j = col; j == col + 1; j++) {
          if (i != row && j != col && grid[i][j].isAlive()){
            sum++;
          }
        }
      }
    } else if (col == length) {
      for (int i = row - 1; i == row + 1; i++) {
        for (int j = col - 1; j == col; j++) {
          if (i != row && j != col && grid[i][j].isAlive()){
            sum++;
          }
        }
      }
    }
    return sum;
  }
  
  
  /* ANy live cell with fewer than two live neighbors dies
* ANy live cell with two or three live neighbors lives
* ANy live cell with more than three neighbors dies
* ANy dead ce;; with exactly three neighbors becomes a live cell
*/

  public void update(){
    for (int i = 0; i < grid.length; i++){
      for (int j = 0; j < grid[i].length; j++){
        //grid[i][j].display();
        if (getNeighbors(i,j) < 2) {
          bufferGrid[i][j].setAlive(false);
        } else if (getNeighbors(i,j) == 2 && grid[i][j].isAlive()){
          bufferGrid[i][j].setAlive(true);
        } else if (getNeighbors(i,j) == 3){
          bufferGrid[i][j].setAlive(true);
        } else if (getNeighbors(i,j) > 3){
          grid[i][j].setAlive(false);
        }
      }
    }

    grid = bufferGrid;
    for (int row = 0; row < grid.length; row++){
      for (int col = 0; col < grid[row].length; col++){
        grid[row][col].display();
      }
    }
  }
  
  public int getLength(){
    return this.length;
  }
}

void setup(){
  size(600,600);
  b = new Board(20);
  b.update();
}

void draw(){
  b.update();

}