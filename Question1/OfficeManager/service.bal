import ballerina/http;

public table<Staff> key(staffNumber) staffTable = table [
    {staffNumber: 100, staffName: "Steven Tjiraso", courseList: [{courseCode: "DSA511S", courseName: "Data Structures & Algorithms", NQFLevel: 5}, {courseCode: "ICG511S", courseName: "Introduction to Computing", NQFLevel: 5}], officeNumber: 201, title: "Mr"},
    {staffNumber: 102, staffName: "Ndinelago Nashandi", courseList: [{courseCode: "DSA611S", courseName: "Distributed Systems", NQFLevel: 6}], officeNumber: 101, title: "Ms"},
    {staffNumber: 103, staffName: "Gereon Kapuire", courseList: [{courseCode: "DPG511S", courseName: "Database Programming", NQFLevel: 5}], officeNumber: 111, title: "Dr"},
    {staffNumber: 104, staffName: "Ambrose Azeta", courseList: [{courseCode: "PRG511S", courseName: "Programming 1", NQFLevel: 5}, {courseCode: "PRG611S", courseName: "Programming 2", NQFLevel: 6}], officeNumber: 111, title: "Dr"},
    {staffNumber: 105, staffName: "Victoria Shakela", courseList: [{courseCode: "ISS611S", courseName: "Information System Security Essentials", NQFLevel: 6}], officeNumber: 110, title: "Ms"}
];

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    resource function post addLecturer(@http:Payload Staff lecturer) returns http:Response|error {
        if lecturer.staffNumber is 0 {
            return error("staffNumber should not be empty!");
        }
        else if lecturer.staffName is "" {
            return error("staffName should not be empty!");
        }
        else if lecturer.title is "" {
            return error("title should not be empty!");
        }
        else if lecturer.officeNumber is 0 {
            return error("officeNumber should not be empty!");
        }
        if lecturer.courseList.length() === 0 {
            return error("courseList should not be empty!");
        }
        else {
            error? addNewStaff = staffTable.add(lecturer);
            if (addNewStaff is error) {
                return error("");
            } else {
                staffTable.add(lecturer);
                http:Response post_resp = new;
                post_resp.statusCode = http:STATUS_CREATED;
                post_resp.setPayload({id: lecturer.staffNumber});
                return post_resp;
            }
        }

    }

    // A resource for retrieving a list of all lecturers within the faculty
    resource function get allLecturers() returns Staff[]|error {
        return staffTable.toArray();
    }

    // A resource for retrieving all the lecturers that teach a certain course
    resource function get courseLecturer/[string searchCourse]() returns Staff[]|error {

        Staff[] staffList = [];
        foreach Staff staff in staffTable {

            var staffcourse = staff.courseList.filter((courseValue) => courseValue.courseCode === searchCourse);
            if staffcourse.length() > 0 {
                staffList.push(staff);
            }
        }
        if staffList.length() == 0 {
            return error(string `${searchCourse} does not have any lecturers assigned to it!`);
        } else {
            return staffList;
        }
    }

    // A resource for retrieving all the lecturers that sit in the same office
    resource function get officeLecturer/[int officeNumber]() returns Staff[]|error {
        Staff[] staffList = [];
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
    resource function get Lecturer/[int staffNumber]() returns Staff?|error {
        // Get the lecturer from the table.
        Staff? lecturer = staffTable[staffNumber];
        if lecturer is () {
            return error(string `Lecturer with staff number ${staffNumber} staffNumber not found!`);
        } else {
            // Return the lecturer.
            return lecturer;
        }
    }
    // resource function for updating an existing lecturers information
    resource function put updateLecturer(@http:Payload Staff lecturer) returns http:Response {

        // Get the lecturer from the table.
        boolean exists = staffTable.hasKey(lecturer.staffNumber);
        http:Response put_Response = new;

        if exists {
            //update lecturer
            staffTable.put(lecturer);
            //return success reponse
            put_Response.statusCode = http:STATUS_ACCEPTED;
            put_Response.setPayload("Lecturer Updated Successfully");
            return put_Response;
        }else {
            //return error

             put_Response.statusCode = http:STATUS_NOT_FOUND;
            put_Response.setPayload("Lecturer not found");
            return put_Response;
        }
    }
    resource function delete Lecturer/[int staffNumber]() returns http:Response {
        // Get the lecturer from the table.
        Staff? lecturer = staffTable[staffNumber];
        http:Response del_resp = new;

        // If the lecturer is not found, return an error.
        if lecturer == () {
            del_resp.statusCode = http:STATUS_NOT_FOUND;
            del_resp.setPayload("Not Found");
            return del_resp;
        } else {
            // Remove the lecturer from the table.
            Staff deleted = staffTable.remove(staffNumber);
            // Return success.
            del_resp.statusCode = http:STATUS_OK;
            del_resp.setPayload("Sucessfully deleted lecturer with staff number:" + deleted.staffNumber.toString());
            return del_resp;
        }

    }

}

