import ballerina/io;

library_serviceClient ep = check new ("http://localhost:9090");

type user record {

};

public function main() returns error? {
    //     Book addBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    //     AddBookResponse addBookResponse = check ep->addBook(addBookRequest);
    //     io:println(addBookResponse);

    //     Book updateBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};

    //     Book removeBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};

    //     Book locateBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    //     LocateBookResponse locateBookResponse = check ep->locateBook(locateBookRequest);
    //     io:println(locateBookResponse);

    //     BorrowBookRequest borrowBookRequest = {userID: "ballerina", ISBN: "ballerina"};
    //     string borrowBookResponse = check ep->borrowBook(borrowBookRequest);
    //     io:println(borrowBookResponse);
    //     stream<

    // Book, error?> listAvailableBooksResponse = check ep->listAvailableBooks();
    //     check listAvailableBooksResponse.forEach(function(Book value) {
    //         io:println(value);
    //     });

    //     User createUserRequest = {userID: "ballerina", profile: "ballerina"};
    //     CreateUserStreamingClient createUserStreamingClient = check ep->createUser();
    //     check createUserStreamingClient->sendUser(createUserRequest);
    //     check createUserStreamingClient->complete();
    //     string? createUserResponse = check createUserStreamingClient->receiveString();
    //     io:println(createUserResponse);

    while (true) {
        io:println("\nLibrary System:");
        io:println("1. Add Book");
        io:println("2. Update Book");
        io:println("3. Remove Book");
        io:println("4. Locate Book");
        io:println("5. Borrow Book");
        io:println("6. Create User");
        io:println("7. List Available Books");

        // ... Add other options ...
        io:println("9. Exit");

        string choice = io:readln("Enter your choice: ");

        if (choice == "1") {
            Book book = {};
            book.title = io:readln("Enter book title: ");
            book.author_1 = io:readln("Enter primary author: ");
            book.author_2 = io:readln("Enter secondary author (Press Enter to skip): ");
            // ... Capture other book details ...
            AddBookResponse response = check ep->addBook(book);
            io:println(response);
        } else if (choice == "2") {
            // Handle update book

            string isbnToUpdate = io:readln("Enter the ISBN of the book you wish to update: ");

            // Check if the book exists
            // Ideally, we'd have an endpoint on the server to check this, but since we don't,
            // we'll skip this step here for simplicity. In a real-world scenario, always check first.

            Book updatedBook = {};
            updatedBook.ISBN = isbnToUpdate;
            updatedBook.title = io:readln("Enter new title (or press Enter to skip): ");
            updatedBook.author_1 = io:readln("Enter new primary author (or press Enter to skip): ");
            string secondaryAuthor = io:readln("Enter new secondary author (or press Enter to skip): ");
            if (secondaryAuthor != "") {
                updatedBook.author_2 = secondaryAuthor;
            }
            updatedBook.location = io:readln("Enter new location (or press Enter to skip): ");
            string statusInput = io:readln("Is the book available? (yes/no): ");
            updatedBook.status = (statusInput.toLowerAscii() == "yes") ? true : false;

            // Send updated details to the server
            string updateBookResponse = check ep->updateBook(updatedBook);
            io:println(updateBookResponse);
        }

        else if (choice == "3") {
            // Handle remove book

            string isbnToRemove = io:readln("Enter the ISBN of the book you wish to remove: ");

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
        else if (choice == "4") {
            // Locate a book

            string isbnToLocate = io:readln("Enter the ISBN of the book you wish to locate: ");
            Book locateRequest = {ISBN: isbnToLocate};
            LocateBookResponse|error locateResult = ep->locateBook(locateRequest);

            if (locateResult is LocateBookResponse) {
                io:println("The book is located at:", locateResult.location);
            } else {
                io:println("Error locating the book:", locateResult.message());
            }

        } else if (choice == "5") {
            // Borrow a book

            string userID = io:readln("Enter your user ID: ");
            string isbnToBorrow = io:readln("Enter the ISBN of the book you wish to borrow: ");
            BorrowBookRequest borrowRequest = {userID: userID, ISBN: isbnToBorrow};

            string|error borrowResult = ep->borrowBook(borrowRequest);

            if (borrowResult is string) {
                io:println(borrowResult);
            } else {
                io:println("Error borrowing the book:", borrowResult.message());
            }
        }
        //else if (choice == "6") {
        //     // Create a user

        //     string userID = io:readln("Enter user ID: ");
        //     string profile = io:readln("Enter user profile (student or librarian): ");
        //     user newUser = {userID, profile};

        //     User|error convertedUser = newUser.cloneWithType(User);
        //     if (convertedUser is User) {
        //         CreateUserStreamingClient userClient = check ep->createUser();
        //         check userClient->sendUser(convertedUser);
        //         check userClient->complete();
        //         string? createUserResponse = check userClient->receiveString();
        //         io:println(createUserResponse);
        //     } else {
        //         io:println("Failed to convert user data to the expected type.");
        //     }
        // } 
        else if (choice == "7") {
            // List available books

            stream<Book, error?>|error availableBooksResponse = ep->listAvailableBooks();

            if (availableBooksResponse is stream<Book, error?>) {
                _ = check availableBooksResponse.forEach(function(Book book) {
                    io:println(book);
                });
            } else {
                io:println("Error listing available books:", availableBooksResponse.message());
            }

        }

        // ... Rest of your code ...

        else if (choice == "9") {
            break;
        } else {
            io:println("Invalid choice! Please try again.");
        }
    }
}

