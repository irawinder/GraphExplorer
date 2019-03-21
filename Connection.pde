// A Class Representing directional connections between People objects

class Connection {
  Student origin, destination;
  String type, value;
  
  Connection (Student _origin, Student _destination, String _type, String _value) {
    origin = _origin;
    destination = _destination;
    type = _type;
    value = _value;
  }
  
  Connection (Student _origin, Student _destination, String _type) {
    origin = _origin;
    destination = _destination;
    type = _type;
    value = _type;
  }
  
  // Draw a line between the two people that are connected
  void draw() {
    
    float x1 = origin.screenLocation.x;
    float y1 = origin.screenLocation.y;
    float x2 = destination.screenLocation.x;
    float y2 = destination.screenLocation.y;
    
    strokeWeight(1); // Line weight of 5 pixels
    if (type.equals("cohort")) {
      stroke(#00CC00, 50); // Transparent Green
    } else {
      stroke(255, 50); // Transparent White
    }
    line(x1, y1, x2, y2);
    
    // Print Edge Type to Canvas
    //fill(255, 255); // Solid White
    //text(value, (x1+x2)/2 + 20, (y1+y2)/2);
  }
}
