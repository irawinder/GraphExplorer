// A class Representing basic properties of a Person

class Person {
  
  String name;
  PVector screenLocation;
  int DIAMETER = 10;
  
  // True-False statement to track whether person is activated by mouse clicks
  boolean locked; // is person selected by mouse?
  
  Person(String _name) {
    name = _name;
    screenLocation = new PVector(width/2, height/2);
  }
  
  // Arrange my person some angle theta along a circle
  void circleLocation(PVector center, float radius, float theta) {
    screenLocation.x = center.x + radius*sin(theta);
    screenLocation.y = center.y + radius*cos(theta);
  }
  
  // Place my person randomly on the screen
  void randomLocation() {
    float x = random(0.8*width);
    float y = random(height);
    screenLocation = new PVector(x, y);
  }
  
  void draw() {
    noStroke(); fill(155);// Draws a solid colored Circle Representing my Person
    ellipse(screenLocation.x, screenLocation.y, DIAMETER, DIAMETER);
    
    // Draws a white outline of a circle on top of my solid color circle
    noFill(); stroke(255); // Solid White; no fill
    strokeWeight(5); // 5 pixels stroke width
    ellipse(screenLocation.x, screenLocation.y, DIAMETER, DIAMETER);
    
    // Draw Text Information about my person
    if (hoverEvent()) {
      fill(255); // Color Text White
      text(name, screenLocation.x + DIAMETER, screenLocation.y - DIAMETER);
    }
    
  }
  
  // Is person selected by mouse? 
  // Run this in mousePressed()
  boolean checkSelection() {
    
    // Checks if hovering over person
    if ( hoverEvent() ) {
      locked = true;
    } else {
      locked = false;
    }
    
    return locked;
  }
  
  void update() {
    
    // Update location of person if "locked on" with mouse
    if (locked) {
      screenLocation = new PVector(mouseX, mouseY);
    }
    
  }
  
  // Checks to see if mouse is hovering over person
  boolean hoverEvent() {
    if ( abs(mouseX - screenLocation.x) < DIAMETER && abs(mouseY - screenLocation.y) < DIAMETER ) {
      return true;
    } else {
      return false;
    }
  }
  
}

class Student extends Person {
  
  String year, major;
  ArrayList<String> subjects;
  ArrayList<Connection> connections;
  
  Student(String _name, String _year, String _major) {
    super(_name);
    year = _year;
    major = _major;
    subjects = new ArrayList<String>();
    connections = new ArrayList<Connection>();
  }
  
    Student(String _name, String _year) {
    super(_name);
    year = _year;
    major = "";
    subjects = new ArrayList<String>();
    connections = new ArrayList<Connection>();
  }
  
  void addSubject(String _subject) {
    // Check for repeats
    boolean repeat = false;
    for (String s: subjects) if (s.equals(_subject)) repeat = true;
    if (!repeat) subjects.add(_subject);
  }
  
  void addConnection(Connection c) {
    connections.add(c);
  }
  
  void draw() {
    noStroke();
    
    // What color is my person?
    if (year.equals("1")) {
      fill(#FF0000); // Red
    } else if (year.equals("2")) {
      fill(#00FF00); // Green
    } else if (year.equals("3")) {
      fill(#0000FF); // Blue
    } else if (year.equals("4")) {
      fill(#FFFF00); // Yellow
    } else if (year.equals("G")) {
      fill(#FF00FF); // Magenta
    } else {
      fill(#00FFFF); // Cyan
    }
    
    // Draws a solid colored Circle Representing my Person
    ellipse(screenLocation.x, screenLocation.y, DIAMETER, DIAMETER);
    
    // Draws a white outline of a circle on top of my solid color circle
    noFill(); stroke(255); // Solid White; no fill
    strokeWeight(1); // 5 pixels stroke width
    ellipse(screenLocation.x, screenLocation.y, DIAMETER, DIAMETER);
    
    // Draw Text Information about my person
    if (hoverEvent()) {
      fill(255); // Color Text White
      String sub = "";
      for (String s: subjects) sub += s + ", ";
      sub = sub.substring(0, sub.length()-2);
      text(name + "\nYear: " + year + "\nMajor: " + major + "\nSubjects: " + sub + "\nConnections: " + connections.size(), screenLocation.x + DIAMETER, screenLocation.y - DIAMETER);
    }
    
  }
}
