class Subject {
  
  String name, number, instructor, semester, requirement;
  int units;
  PVector screenLocation;
  int DIAMETER = 10;
  
  // True-False statement to track whether person is activated by mouse clicks
  boolean locked; // is person selected by mouse?
  
  Subject(String _name, String _number, String _instructor, String _semester, String _requirement, int _units) {
    name = _name;
    number = _number;
    instructor = _instructor;
    semester = _semester;
    requirement = _requirement;
    units = _units;
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
    
    // Draw Text Information about my person
    color col = color(255);
    if (requirement.equals("REQ")) col = color(#00FF00);
    if (requirement.equals("ELEC")) col = color(#FFFF00);
    
    noStroke(); fill(col);// Draws a solid colored Circle Representing my Person
    ellipse(screenLocation.x, screenLocation.y, DIAMETER, DIAMETER);
    
    // Draws a white outline of a circle on top of my solid color circle
    noFill(); stroke(155); // Solid White; no fill
    strokeWeight(3); // 5 pixels stroke width
    ellipse(screenLocation.x, screenLocation.y, DIAMETER, DIAMETER);
    
    if (hoverEvent()) {
      String u = "NA";
      if (units > 0) u = "" + units;
      fill(col, 255);
      text(number + " " + name + "\n" + semester + ", " + u + " units" + "\n" + requirement + "\n" + instructor, screenLocation.x + DIAMETER, screenLocation.y + DIAMETER/2);
    } else {
      fill(col, 150); // Color Text White
      text(number, screenLocation.x + DIAMETER, screenLocation.y + DIAMETER/2);
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
