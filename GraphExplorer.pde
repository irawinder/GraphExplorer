/* IceBreaker Network Visualization
 * 11.S195 Computational Urban Science Workshop
 * jiw@mit.edu
 *
 * This script allows you define and manipulate a graph representing people and their connections.
 */

// List of Students
ArrayList<Student> students;

// Connection between Common Subject (i.e. acquaintences)
ArrayList<Connection> subject;

// Connections between Common Years
ArrayList<Connection> year;

// Connections between Common Major
ArrayList<Connection> major;

void setup() {
  
  // Set Screen Size to 800 x 700 pixels
  size(800, 700);
  
  //initManually();
  initFile();
  
  // Arrange all of the people in a cute little circle on the canvas
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
 
  // Draw Nodes Representing People
  for (Student p: students) {
    p.update();
    if (p.connections.size() > 45) for (Connection c: p.connections) c.draw();
    p.draw();
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
}

// This function runs whenever a mouse button is released
void mouseReleased() {
  // Unselect all People
  for (Student p: students) {
    p.locked = false;
  }
}
