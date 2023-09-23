import ballerina/io;

library_serviceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    Book addBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    AddBookResponse addBookResponse = check ep->addBook(addBookRequest);
    io:println(addBookResponse);

    Book updateBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};

    Book removeBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};

    Book locateBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    LocateBookResponse locateBookResponse = check ep->locateBook(locateBookRequest);
    io:println(locateBookResponse);

    BorrowBookRequest borrowBookRequest = {userID: "ballerina", ISBN: "ballerina"};
    string borrowBookResponse = check ep->borrowBook(borrowBookRequest);
    io:println(borrowBookResponse);
    stream<

Book, error?> listAvailableBooksResponse = check ep->listAvailableBooks();
    check listAvailableBooksResponse.forEach(function(Book value) {
        io:println(value);
    });

    User createUserRequest = {userID: "ballerina", profile: "ballerina"};
    CreateUserStreamingClient createUserStreamingClient = check ep->createUser();
    check createUserStreamingClient->sendUser(createUserRequest);
    check createUserStreamingClient->complete();
    string? createUserResponse = check createUserStreamingClient->receiveString();
    io:println(createUserResponse);

    while (true) {
        io:println("\nLibrary System:");
        io:println("1. Add Book");
        io:println("2. Update Book");
        io:println("3. Remove Book");
        // ... Add other options ...
        io:println("9. Exit");

        string choice = check io:readln("Enter your choice: ");

        if (choice == "1") {
            Book book = {};
            book.title = check io:readln("Enter book title: ");
            book.author_1 = check io:readln("Enter primary author: ");
            book.author_2 = check io:readln("Enter secondary author (Press Enter to skip): ");
            // ... Capture other book details ...
            AddBookResponse response = check ep->addBook(book);
            io:println(response);
        } else if (choice == "2") {
            // Handle update book

            string isbnToUpdate = check io:readln("Enter the ISBN of the book you wish to update: ");

            // Check if the book exists
            // Ideally, we'd have an endpoint on the server to check this, but since we don't,
            // we'll skip this step here for simplicity. In a real-world scenario, always check first.

            Book updatedBook = {};
            updatedBook.ISBN = isbnToUpdate;
            updatedBook.title = check io:readln("Enter new title (or press Enter to skip): ");
            updatedBook.author_1 = check io:readln("Enter new primary author (or press Enter to skip): ");
            string secondaryAuthor = check io:readln("Enter new secondary author (or press Enter to skip): ");
            if (secondaryAuthor != "") {
                updatedBook.author_2 = secondaryAuthor;
            }
            updatedBook.location = check io:readln("Enter new location (or press Enter to skip): ");
            string statusInput = check io:readln("Is the book available? (yes/no): ");
            updatedBook.status = (statusInput.toLowerAscii() == "yes") ? true : false;

            // Send updated details to the server
            string updateBookResponse = check ep->updateBook(updatedBook);
            io:println(updateBookResponse);
        }

        else if (choice == "3") {
            // Handle remove book

            string isbnToRemove = check io:readln("Enter the ISBN of the book you wish to remove: ");

            // Construct the book removal request
            Book removeRequest = {ISBN: isbnToRemove};

            // Send the remove request to the server
            RemoveBookResponse removeBookResponse = check ep->removeBook(removeRequest);

            // Display the books that remain after removal (assuming the server returns this list)
            io:println("Books remaining in the library:");
            foreach Book book in removeBookResponse.books {
                io:println("Title:", book.title, "ISBN:", book.ISBN);
            }
        }
        // ... Handle other choices ...
        else if (choice == "9") {
            break;
        } else {
            io:println("Invalid choice! Please try again.");
        }
    }
}

