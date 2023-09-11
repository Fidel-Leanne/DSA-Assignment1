import ballerina/http;

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {
    # A resource for generating greetings
    # + name - the input string name
    # + return - string name with hello message or error
    resource function get greeting(string name) returns string|error {
        // Send a response back to the caller.
        if name is "" {
            return error("name should not be empty!");
        }
        return "Hello, " + name;
    }
}

public table<Staff> key(staffNumber) staffTable = table[
    {staffNumber: 100, staffName: "Steven Tjiraso", courseList: [{courseCode: "DSA511S", courseName: "Data Structures & Algorithms", NQFLevel: 5},{courseCode: "ICG511S", courseName: "Introduction to Computing", NQFLevel: 5}], officeNumber: 201, title: "Mr"},
    {staffNumber: 102, staffName: "Ndinelago Nashandi", courseList: [{courseCode: "DSA611S", courseName: "Distributed Systems", NQFLevel: 6}], officeNumber: 101, title: "Ms"},
    {staffNumber: 103, staffName: "Gereon Kapuire", courseList: [{courseCode: "DPG511S", courseName: "Database Programming", NQFLevel: 5}],officeNumber: 111, title: "Dr"},
    {staffNumber: 104, staffName: "Ambrose Azeta", courseList: [{courseCode: "PRG511S", courseName: "Programming 1", NQFLevel: 5}, {courseCode: "PRG611S", courseName: "Programming 2", NQFLevel: 6}],officeNumber: 118, title: "Dr"},
    {staffNumber: 105, staffName: "Victoria Shakela", courseList: [{courseCode: "ISS611S", courseName: "Information System Security Essentials", NQFLevel: 6}],officeNumber: 110, title: "Ms"}
];

