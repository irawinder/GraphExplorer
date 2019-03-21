void initFile(){
  // The following data file lists an entry for each unique subject that a unique student is taking
  // Therefore, students taking multiple subjects occupy multiple rows of the CSV file
  Table file = loadTable("data/crs11noid-3-1-19_plusFAC.csv", "header");
  
  // Reference Table for Course Information
  //Table info = loadTable("data/courseinfo.csv", "header");
  Table info = loadTable("data/11_6_Course_Instructors_PLUS.csv", "header");
  
  // Add all subjects to arraylist of subjects
  subjects = new ArrayList<Subject>();
  for (int i=0; i<info.getRowCount(); i++) {
    
    String name    = "" + info.getString(i, 4);
    String number    = "" + info.getString(i, 1);
    String instructor = "" + info.getString(i, 2);
    String semester   = "" + info.getString(i, 8);
    String requirement   = "" + info.getString(i, 9);
    int units = info.getInt(i, 7);
    Subject current = new Subject(name, number, instructor, semester, requirement, units);
    
    // Check for repeat subject
    boolean repeat = false;
    for (Subject s: subjects) {
      if (s.name.equals(current.name)) {
        repeat = true;
        break;
      }
    }
    // If subject not already in list, add to end of list with current subject as their first
    if (!repeat) {
      subjects.add(current);
    }
  }
  
  // Add all of these people to an array list of People, students
  students = new ArrayList<Student>();
  for (int i=0; i<file.getRowCount(); i++) {
    String name    = "" + file.getString(i, 2) + ", " + file.getString(i, 3);
    String year    = "" + file.getString(i, 5);
    String subject = "" + file.getString(i, 1);
    String major   = "" + file.getString(i, 4);
    Student current = new Student(name, year, major);
    
    // Check for repeat students (who are taking multiple subjects)
    boolean repeat = false;
    for (Student s: students) {
      if (s.name.equals(current.name)) {
        repeat = true;
        s.addSubject(subject);
        break;
      }
    }
    // If student not already in list, add to end of list with current subject as their first
    if (!repeat) {
      current.addSubject(subject);
      students.add(current);
    }
  }
  println("Students: " + students.size());
  
  // Initialize Acquaintances based on subject
  subject = new ArrayList<Connection>();
  for (Student s1: students) {
    for (Student s2: students) {
      if (!s1.name.equals(s2.name)) { // people are not connected to themselves
        for (String sub1: s1.subjects) {
          for (String sub2: s2.subjects) {
            if (sub1.equals(sub2)) { // two people are connected when same subject
              Connection c = new Connection(s1, s2, "subject", sub1);
              s1.addConnection(c);
              subject.add(c);
            }
          }
        }
      }
    }
  }
  println("Class Acquaintanceships: " + subject.size());
  
  // Initialize Same-year Cohort Connections
  year = new ArrayList<Connection>();
  for (Student s1: students) {
    for (Student s2: students) {
      if (!s1.name.equals(s2.name)) { // people are not connected to themselves
        if (s1.year.equals(s2.year)) { // two people are connected when same 'year'
          Connection c = new Connection(s1, s2, "cohort", s1.year);
          //s1.addConnection(c);
          year.add(c);
        }
      }
    }
  }
  println("Cohort Edges: " + subject.size());
}

void initManually() {
  // Initialize array of People from our class
  Student[] p = new Student[28];
  p[0] = new Student("Zhang, Jenny", "1");
  p[1] = new Student("Levenson, Emily", "1");
  p[2] = new Student("Eain, Yun", "1");
  p[3] = new Student("Cong, Cleverina C", "2");
  p[4] = new Student("He, Jude", "2");
  p[5] = new Student("Liu, Emily", "2");
  p[6] = new Student("Hoffman, Meital H", "3");
  p[7] = new Student("Merced Hernandez, Hadrian", "3");
  p[8] = new Student("Vogel, Amy L", "3");
  p[9] = new Student("Langston, Christine M", "4");
  p[10] = new Student("Gong, Zoe P", "4");
  p[11] = new Student("Kohn, Jacob Elias", "G");
  p[12] = new Student("Dev, Jay", "G");
  p[13] = new Student("Nina Lutz", "G");
  p[14] = new Student("Wu, Yue", "G");
  p[15] = new Student("Ira Winder", "FAC");
  p[16] = new Student("Beavery McBeaver Beaver", "Eternally Young");
  p[17] = new Student("Daniel Yu", "3");
  p[18] = new Student("Titus Venverloo", "3");
  p[19] = new Student("Melanie Droogleever Fortuyn", "3");
  p[20] = new Student("Ajara Ceesay", "SPURS");
  p[21] = new Student("Sharlene Chiu", "4");
  p[22] = new Student("Helena Rong", "G");
  p[23] = new Student("Lara Shonkwiler", "2");
  p[24] = new Student("Nanako", "Panasonic");
  p[25] = new Student("Grace", "2");
  p[26] = new Student("Rosanne", "4");
  p[27] = new Student("Eric", "4");
  
  // Add all of these people to an array list of People, students
  students = new ArrayList<Student>();
  for (int i=0; i<p.length; i++) {
    students.add(p[i]);
  }
  
  // Initialize Frands and Acquaintances
  subject = new ArrayList<Connection>();
  subject.add(new Connection(p[15], p[13], "frands"));
  subject.add(new Connection(p[15], p[12], "frands"));
  subject.add(new Connection(p[15], p[6], "frands"));
  subject.add(new Connection(p[15], p[7], "frands"));
  subject.add(new Connection(p[15], p[8], "frands"));
  subject.add(new Connection(p[15], p[18], "frands"));
  subject.add(new Connection(p[15], p[19], "frands"));
  subject.add(new Connection(p[15], p[21], "frands"));
  subject.add(new Connection(p[15], p[11], "frands"));
  subject.add(new Connection(p[15], p[25], "frands"));
  subject.add(new Connection(p[13], p[26], "frands"));
  subject.add(new Connection(p[13], p[10], "frands"));
  subject.add(new Connection(p[13], p[7], "frands"));
  subject.add(new Connection(p[13], p[21], "frands"));
  subject.add(new Connection(p[13], p[19], "frands"));
  subject.add(new Connection(p[13], p[6], "frands"));
  subject.add(new Connection(p[13], p[7], "frands"));
  subject.add(new Connection(p[13], p[18], "frands"));
  subject.add(new Connection(p[8], p[6], "best frands"));
  subject.add(new Connection(p[8], p[9], "frands"));
  subject.add(new Connection(p[18], p[19], "frands"));
  subject.add(new Connection(p[18], p[21], "frands"));
  subject.add(new Connection(p[18], p[21], "frands"));
  subject.add(new Connection(p[27], p[9], "frands"));
  subject.add(new Connection(p[21], p[9], "frands"));
  subject.add(new Connection(p[21], p[19], "frands"));
  subject.add(new Connection(p[10], p[13], "frands"));
  subject.add(new Connection(p[7], p[5], "frands"));
  subject.add(new Connection(p[7], p[25], "frands"));
  subject.add(new Connection(p[22], p[14], "frands"));
  subject.add(new Connection(p[22], p[11], "frands"));
  
  // Initialize Same-year Cohort Relationships
  year = new ArrayList<Connection>();
  for (Student s1: students) {
    for (Student s2: students) {
      if (!s1.name.equals(s2.name)) { // people are not connected to themselves
        if (s1.year.equals(s2.year)) { // two people are connected when same 'year'
          year.add(new Connection(s1, s2, "cohort"));
        }
      }
    }
  }
}
