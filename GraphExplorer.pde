/* IceBreaker Network Visualization
 * 11.S195 Computational Urban Science Workshop
 * jiw@mit.edu
 *
 * This script allows you define and manipulate a graph representing people and their connections.
 */

// List of Students
ArrayList<Student> students;

// List of Subjects/Instructors
ArrayList<Subject> subjects;

// Connection between Common Subject (i.e. acquaintences)
ArrayList<Connection> subject;

// Connections between Common Years
ArrayList<Connection> year;

// Connections between Common Major
ArrayList<Connection> major;

// Display Grid Parameters
int grid_x;
int grid_y;
int grid_width;
int grid_height;
int cell_width;
int cell_height;
int line_height;

void setup() {
  
  // Set Screen Size to 800 x 700 pixels
  size(800, 800);
  
  // Set up Grid
  grid_x = 25;
  grid_y = 50;
  grid_width = int(0.5*width) - 50;
  grid_height = height - 75;
  cell_width = grid_width / 3;
  cell_height = grid_height / 5;
  line_height = 15;
  
  //initManually();
  initFile();
  
  // Arange the initial State of Subjects
  int[][] grid_counter = new int[3][3]; // 6, 11, other BY FA, SP, FA_SP
  for (int i=0; i<grid_counter.length; i++) {
    for (int j=0; j<grid_counter[0].length; j++) {
      grid_counter[i][j] = 0;
    }
  }
  for (Subject s: subjects) {
    int u = 0;
    int v = 0;
    // If FA, SP. or FA_SP
    if (s.semester.equals("FA")) u=0;
    if (s.semester.equals("SP")) u=1;
    if (s.semester.equals("FA_SP")) u=2;
    
    // If 6, 11, or other
    if (s.number.substring(0,2).equals("6.")) {
      v=0;
    } else if (s.number.substring(0,3).equals("11.")) {
      v=1; 
    } else { 
      v=2; 
    }
    
    grid_counter[u][v]++;
    s.screenLocation = getGridLoc(u, v, grid_counter[u][v]);
  }
  
  // Arrange all of the students in a cute little circle on the canvas
  int num_people = students.size();
  PVector center = new PVector(2*width/4, 2*height/4);
  float radius = 0.35*height;
  for (int i=0; i<num_people; i++) {
    Student s = students.get(i);
    float theta = (2*PI*i)/num_people;
    s.circleLocation(center, radius, theta);
  }
  
  // Arrange well-conected students seperately
  int JIT = 50;
  for (Student s: students) {
    if(s.connections.size() > 45 )
      s.screenLocation = new PVector(100 + random(-JIT, JIT), 100 + random(-JIT, JIT));
    if(s.year.equals("FAC"))
      s.screenLocation = new PVector(700 + random(-JIT, JIT), 100 + random(-JIT, JIT));
  }
  
  //// Arrange all of the people randomly
  //for (Student s: students) {
  //  s.randomLocation();
  //}
  
}

PVector getGridLoc(int u, int v, int grid_counter) {
  int nudge = 0;
  if (u==1 && v==1) nudge = -cell_height;
  PVector loc = new PVector(grid_x + cell_width*u, grid_y + 2*cell_height*v + grid_counter*line_height + nudge);
  //println(u, v, grid_counter, loc);
  return loc;
}

void draw() {
  background(0);
/* 
  //Draw connections by year
  for (Connection c: cohort) {
    c.draw();
  }
  
  // Draw Connections by Acquaintenceship
  for (Connection c: frands) {
    c.draw();
  }
*/  

/* 
  // Draw Nodes Representing People
  for (Student p: students) {
    p.update();
    if (p.connections.size() > 45) for (Connection c: p.connections) c.draw();
    p.draw();
  }
*/  
  
  // Draw Grid Lines
  fill(255);
  text("SP - Spring", grid_x + 0*cell_width - 5, grid_y - 10);
  text("FA - Fall", grid_x + 1*cell_width - 5, grid_y - 10);
  text("FA_SP - Both", grid_x + 2*cell_width - 5, grid_y - 10);
  
  text("SP - Spring", width/2 + 100, grid_y - 10);
  text("FA - Fall", 3*width/4 + 100, grid_y - 10);
  
  text("FSH", grid_width+15, 0.125*height);
  text("SPH", grid_width+15, 0.375*height);
  text("JUN", grid_width+15, 0.625*height);
  text("SEN", grid_width+15, 0.875*height);
  
  stroke(255, 100);
  line(0, 50, width, 50);
  
  line(cell_width, 0, cell_width, height);
  line(2*cell_width, 0, 2*cell_width, height);
  line(3*cell_width, 0, 3*cell_width, height);
  
  line(width/2, 0, width/2, height);
  line(3*width/4, 0, 3*width/4, height);
  line(grid_width, 0.25*height, width, 0.25*height);
  line(grid_width, 0.50*height, width, 0.50*height);
  line(grid_width, 0.75*height, width, 0.75*height);
  line(grid_width, 1.00*height-2, width, 1.00*height-2);
  
  
  // Draw Nodes Representing Subjects
  for (Subject s: subjects) {
    s.update();
    s.draw();
  }

 
}

// This function runs whenever a mouse button is pressed down
void mousePressed() {
  // Checks to see if you clicked a person
  for (Student p: students) {
    if (p.checkSelection() ) { 
      break;
    }
  }
  
  // Checks to see if you clicked a subject
  for (Subject s: subjects) {
    if (s.checkSelection() ) { 
      break;
    }
  }
}

// This function runs whenever a mouse button is released
void mouseReleased() {
  // Unselect all People
  for (Student p: students) {
    p.locked = false;
  }
  
  // Unselect all Subjects
  for (Subject s: subjects) {
    s.locked = false;
  }
}
