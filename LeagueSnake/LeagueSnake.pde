//*
// ***** SEGMENT CLASS *****
// This class will be used to represent each part of the moving snake.
//*

class Segment {

//Add x and y member variables. They will hold the corner location of each segment of the snake.
  int x;
  int y;
  
// Add a constructor with parameters to initialize each variable.
  Segment(int x, int y) {
    this.x= x;
    this.y= y;
  }


}


//*
// ***** GAME VARIABLES *****
// All the game variables that will be shared by the game methods are here
//*

  int foodX;
  Segment head;
  ArrayList<Segment> tail = new ArrayList<Segment>();
  int foodY;
  int directionOfSnake= RIGHT;
  int snakeX= 100;
  int snakeY= 100;
  
  int foodEaten= 0;
  


//*
// ***** SETUP METHODS *****
// These methods are called at the start of the game.
//*

void setup() {
   fill(255,255,255);
  size(500,500);
  frameRate(20);
   dropFood();
   head= new Segment(snakeX, snakeY);
   
   
  
}

void dropFood() {
  //Set the food in a new random location
    foodX = ((int)random(50)*10);
    foodY=((int) random(50)*10);
}



//*
// ***** DRAW METHODS *****
// These methods are used to draw the snake and its food 
//*

void draw() {
  background(100,100,100);
  drawFood();
  move();
  drawSnake();
  eat();
}

void drawFood() {
  //Draw the food
   fill(0,255,0);
  rect(foodX, foodY, 10, 10);
}

void drawSnake() {
  //Draw the head of the snake followed by its tail
   fill(255,0,0);
  rect(head.x, head.y, 10, 10);
  manageTail();
 
  
}


//*
// ***** TAIL MANAGEMENT METHODS *****
// These methods make sure the tail is the correct length.
//*

void drawTail() {
  //Draw each segment of the tail 
  for (Segment t: tail) {
     rect(t.x, t.y, 10, 10);
    
  }
  
  
}

void manageTail() {
  //After drawing the tail, add a new segment at the "start" of the tail and remove the one at the "end" 
  //This produces the illusion of the snake tail moving.
  checkTailCollision();
  drawTail();
  rect(head.x, head.y, 10, 10);
  tail.add(new Segment(head.x, head.y));
  tail.remove(0);
 
}

void checkTailCollision() {
  //If the snake crosses its own tail, shrink the tail back to one segment
  for (Segment t: tail) {
  if (head.x == t.x && head.y == t.y) {
    foodEaten= 1;
   tail= new ArrayList<Segment>();
   tail.add(new Segment(head.x, head.y));
    
    
  }
    
    
  }
}



//*
// ***** CONTROL METHODS *****
// These methods are used to change what is happening to the snake
//*

void keyPressed() {
  //Set the direction of the snake according to the arrow keys pressed
  if(key=='w' || keyCode==UP) {
    if (directionOfSnake!=DOWN) {
    directionOfSnake=UP;
    }
  }
  else if(key=='s' || keyCode==DOWN) {
    if (directionOfSnake!= UP) {
   directionOfSnake=DOWN; 
    }
  }
  else if(key=='d' || keyCode==RIGHT) {
    if (directionOfSnake!=LEFT) {
    directionOfSnake=RIGHT;
    }
  }
  else if(key=='a' || keyCode==LEFT) {
    if (directionOfSnake!=RIGHT) {
    directionOfSnake=LEFT;
    }
  }
}

void move() {
  //Change the location of the Snake head based on the direction it is moving.
   checkBoundaries();
    
  switch(directionOfSnake) {
  case UP:
    // move head up here 
    head.y-=10;
    
    break;
  case DOWN:
    // move head down here 
    head.y+=10;
    break;
  case LEFT:
   // figure it out 
   head.x-=10;
    break;
  case RIGHT:
    // mystery code goes here
    head.x+=10;
    break;
   
  }
  
}

void checkBoundaries() {
 //If the snake leaves the frame, make it reappear on the other side
 if(head.x>=width) {
   head.x=0;
 }
else if(head.x<=0) {
  head.x=width;
}
if(head.y>=height) {
  head.y=0;
}
else if(head.y<=0) {
  head.y=height;
}


}
void eat() {
  //When the snake eats the food, its tail should grow and more food appear
  if(head.x==foodX && head.y==foodY) {
    dropFood();
    foodEaten= foodEaten+1;
    tail.add(new Segment(head.x, head.y));
  }
  
}
