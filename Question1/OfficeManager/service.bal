import ballerina/http;

public table<Staff> key(staffNumber) staffTable = table[
        {staffNumber: 100, staffName: "Steven Tjiraso", courseList: [{courseCode: "DSA511S", courseName: "Data Structures & Algorithms", NQFLevel: 5},{courseCode: "ICG511S", courseName: "Introduction to Computing", NQFLevel: 5}], officeNumber: 201, title: "Mr"},
        {staffNumber: 102, staffName: "Ndinelago Nashandi", courseList: [{courseCode: "DSA611S", courseName: "Distributed Systems", NQFLevel: 6}], officeNumber: 101, title: "Ms"},
        {staffNumber: 103, staffName: "Gereon Kapuire", courseList: [{courseCode: "DPG511S", courseName: "Database Programming", NQFLevel: 5}],officeNumber: 111, title: "Dr"},
        {staffNumber: 104, staffName: "Ambrose Azeta", courseList: [{courseCode: "PRG511S", courseName: "Programming 1", NQFLevel: 5}, {courseCode: "PRG611S", courseName: "Programming 2", NQFLevel: 6}],officeNumber: 111, title: "Dr"},
        {staffNumber: 105, staffName: "Victoria Shakela", courseList: [{courseCode: "ISS611S", courseName: "Information System Security Essentials", NQFLevel: 6}],officeNumber: 110, title: "Ms"}
    ];

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error

    resource function post addLecturer(int staffNumber, string staffName, string title, int officeNumber, CourseList courseList) returns Staff|error {
        if staffNumber is "" {
            return error("staffNumber should not be empty!");
        }
        if staffName is "" {
            return error("staffName should not be empty!");
        }
        if title is "" {
            return error("title should not be empty!");
        }
        if officeNumber is "" {
            return error("officeNumber should not be empty!");
        }
        if courseList is ""{
            return error("courseList should not be empty!");
    }

    //  lecturer object created
        Staff newLecturer = {
            staffNumber: staffNumber,
            staffName: staffName,
            title: title,
            officeNumber: officeNumber,
            courseList: [courseList]
        };
    }

    // A resource for retrieving a list of all lecturers within the faculty
    resource function get allLecturers() returns Staff[]|error {
        return staffTable.toArray();
    }

    // A resource for retrieving all the lecturers that teach a certain course
    resource function get courseLecturer(CourseList courseList) returns Staff[]|error {
        Staff[] staffList;
        foreach Staff staff in staffTable {
            if staff.courseList.indexOf(courseList) != (){
               staffList.push(staff);
            }
        }
        if staffList.length()==0{
            return error(string `${courseList.courseCode} does not have any lecturers assigned to it!`);
        } else {
            return staffList;
        }
    }

    // A resource for retrieving all the lecturers that sit in the same office
    resource function get officeLecturer(int officeNumber) returns Staff[]|error {
        Staff[] staffList;
        foreach Staff staff in staffTable {
            if staff.officeNumber == officeNumber {
               staffList.push(staff);
            }
        }
        if staffList.length() == 0 {
            return error(string `${officeNumber} does not have any lecturers assigned to it!`);
        } else {
            return staffList;
        }
    }
    // A resource for getting a lecturer by staff number.
    resource function get Lecturer(int staffNumber) returns Staff?|error {
        // Get the lecturer from the table.
        Staff? lecturer = staffTable[staffNumber];
        if lecturer is error {
            return error(string `Lecturer with staff number ${staffNumber} staffNumber not found!`);
        }
        // Return the lecturer.
        return lecturer;
    }


// resource function for updating an existing lecturers information
resource function put updateLecturer(int staffNumber, string staffName, string title, string officeNumber, CourseList[] courseList ) returns Staff|error {
    // Get the lecturer from the table.
    Staff? lecturer = staffTable[staffNumber];

    // If the lecturer is not found, return an error.
    if lecturer is error {
        return error(string `Lecturer with staff number ${staffNumber} staffNumber not found!`);
    }
}

resource function delete Lecturer(int staffNumber) returns error? {
  // Get the lecturer from the table.
  Staff? lecturer = staffTable[staffNumber];

  // If the lecturer is not found, return an error.
  if lecturer is error {
    return error(string `Lecturer with staff number ${staffNumber} staffNumber not found`);
  }

  // Remove the lecturer from the table.
  Staff remove = staffTable.remove( staffNumber);

  // Return success.
  return nil;
}


}





