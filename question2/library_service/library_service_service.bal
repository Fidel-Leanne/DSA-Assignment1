import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}

service "library_service" on ep {

    remote function addBook(Book value) returns AddBookResponse|error {
        // Return the ISBN of the added book

    }
    remote function updateBook(Book value) returns error? {
    }
    remote function removeBook(Book value) returns RemoveBookResponse|error {
    }
    remote function locateBook(Book value) returns LocateBookResponse|error {
        if (books.hasKey(book.ISBN)) {
            return {location: books[book.ISBN].location, message: "Available"};
        } else {
            return {location: "", message: "Not Available"};
        }

    }
    remote function borrowBook(BorrowBookRequest value) returns error? {
    }
    remote function createUser(stream<User, grpc:Error?> clientStream) returns error? {

        error? e = userStream.forEach(function(User user) {
            users[user.userID] = user;
        });
    }
    remote function listAvailableBooks() returns stream<Book, error?>|error {
    }
}

