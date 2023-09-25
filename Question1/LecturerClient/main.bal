import ballerina/io;
import yourmodule;

function main() returns error? {
    // Initialize the client
    yourmodule:Client client = new yourmodule:Client();

    while (true) {
        // Display a menu for the user
        io:println("Choose an option:");
        io:println("1. Add Lecturer");
        io:println("2. Get All Lecturers");
        io:println("3. Search for a Course Lecturer");
        io:println("4. Search for an Office Lecturer");
        io:println("5. Search for a Lecturer by Staff Number");
        io:println("6. Delete a Lecturer by Staff Number");
        io:println("7. Update a Lecturer");
        io:println("8. Exit");

        // Read user's choice
        string choice = io:readln("Enter your choice: ");

        match choice {
            "1" => {
                // User wants to add a lecturer
                json payload = io:readln("Enter lecturer details (JSON format): ");
                var response = client.addLecturer(payload);
                io:println("Response:");
                io:println(response);
            }
            "2" => {
                // User wants to get all lecturers
                var response = client.allLecturers();
                io:println("Response:");
                io:println(response);
            }
            "3" => {
                // User wants to search for a course lecturer
                string searchCourse = io:readln("Enter the course name: ");
                var response = client.courseLecturer(searchCourse);
                io:println("Response:");
                io:println(response);
            }
            // Add similar cases for other functions
            "8" => {
                // User wants to exit
                io:println("Exiting...");
                break;
            }
            _ => {
                io:println("Invalid choice. Please try again.");
            }
        }
    }
    return ();
}
