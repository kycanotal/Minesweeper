

import de.bezier.guido.*;
public final static int NUM_ROWS = 20; 
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton [NUM_ROWS] [NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }



  setBombs();
}
public void setBombs()
{
  while (bombs.size() < NUM_BOMBS) {
    int row = (int) (Math.random() * NUM_ROWS);
    int col = (int) (Math.random() * NUM_COLS);
    if (!bombs.contains(buttons[row][col])) {
      bombs.add(buttons[row][col]);
      System.out.println(row + "," + col);
    }//your code
  }
  System.out.println(bombs);
}


public void draw ()
{

  background( 0 );
  if (isWon())
    displayWinningMessage();
}
public boolean isWon()
{
  for(int win = 0; win < bombs.size(); win++){
    
      if(bombs.get(win).isMarked() == false)//your code here
  return false;
    }
  return true;
  }
  //your code here
  

public void displayLosingMessage()
{
  
  for(int i = 0; i < bombs.size(); i++){
    bombs.get(i).clicked = true;
  }
  buttons[9][6].setLabel("G");
  buttons[9][7].setLabel("a");
  buttons[9][8].setLabel("m");
  buttons[9][9].setLabel("e");
  buttons[9][10].setLabel("");
  buttons[9][11].setLabel("O");
  buttons[9][12].setLabel("v");
  buttons[9][13].setLabel("e");
  buttons[9][14].setLabel("r");
  System.out.println("lose");//your code here
}
public void displayWinningMessage()
{
  
  buttons[9][6].setLabel("S");
  buttons[9][7].setLabel("t");
  buttons[9][8].setLabel("a");
  buttons[9][9].setLabel("g");
  buttons[9][10].setLabel("e");
  buttons[9][11].setLabel("");
  buttons[9][12].setLabel("C");
  buttons[9][13].setLabel("l");
  buttons[9][14].setLabel("e");
  buttons[9][15].setLabel("a");
  buttons[9][16].setLabel("r");
  buttons[9][17].setLabel("!");//your code here
}

public class MSButton
{
  private int r, c;
  private float x, y, width, height;
  private boolean clicked, marked;
  private String label;

  public MSButton ( int rr, int cc )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    r = rr;
    c = cc; 
    x = c*width;
    y = r*height;
    label = "";
    marked = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
  public boolean isMarked()
  {
    return marked;
  }
  public boolean isClicked()
  {
    return clicked;
  }
  // called by manager

  public void mousePressed () 
  {
    clicked = true;
    if(mouseButton == RIGHT){
    marked  = !marked;
    if(marked == false)
    clicked = false;
    }
    else if(bombs.contains(this)){
      displayLosingMessage();
      System.out.println("Bomb!");
    }
    else if (countBombs(r,c) > 0)
    setLabel("" +countBombs(r,c));
    else {
      if(isValid(r, c + 1) == true && buttons[r][c+1].isClicked() == false)
        buttons[r][c+1].mousePressed();
      if(isValid(r,c-1) == true && buttons[r][c-1].isClicked() == false)
        buttons[r][c-1].mousePressed();
      if(isValid(r+1,c) == true && buttons[r+1][c].isClicked() == false)
        buttons[r+1][c].mousePressed();
      if(isValid(r+1,c+1) == true && buttons[r+1][c+1].isClicked() == false)
        buttons[r+1][c+1].mousePressed();
      if(isValid(r+1,c-1) == true && buttons[r+1][c-1].isClicked() == false)
        buttons[r+1][c-1].mousePressed();
      if(isValid(r-1,c) == true && buttons[r-1][c].isClicked() == false)
        buttons[r-1][c].mousePressed();
      if(isValid(r-1,c+1) == true && buttons[r-1][c+1].isClicked() == false)
        buttons[r-1][c+1].mousePressed();
      if(isValid(r-1,c-1) == true && buttons[r-1][c-1].isClicked() == false)
        buttons[r-1][c-1].mousePressed();

    }//your code here
  }

  public void draw () 
  {    
    if (marked)
      fill(0);
    else if ( clicked && bombs.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(label, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    label = newLabel;
  }
  public boolean isValid(int r, int c)
  {
    if(r >= 0 && r < 20 && c >= 0 && c < 20)
    return true;//your code here
    else return false;
  }
  public int countBombs(int row, int col)
  {
    int numBombs = 0;
    if(isValid(row,col+1) == true && bombs.contains(buttons[row][col + 1]))
      numBombs++;
    if(isValid(row,col-1) == true && bombs.contains(buttons[row][col - 1]))
      numBombs++;
    if(isValid(row + 1,col) == true && bombs.contains(buttons[row+1][col]))
      numBombs++;
    if(isValid(row + 1,col + 1) == true && bombs.contains(buttons[row+1][col+1]))
      numBombs++; 
    if(isValid(row + 1,col - 1) == true && bombs.contains(buttons[row+1][col-1]))
      numBombs++;
    if(isValid(row - 1,col) == true && bombs.contains(buttons[row-1][col]))
      numBombs++;
    if(isValid(row - 1, col + 1) == true && bombs.contains(buttons[row-1][col+1]))
      numBombs++;
    if(isValid(row - 1, col - 1)== true && bombs.contains(buttons[row-1][col-1]))
      numBombs++; //your code here
    return numBombs;
  }
}


