import ballerina/io;

library_serviceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    Book addBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    AddBookResponse addBookResponse = check ep->addBook(addBookRequest);
    io:println(addBookResponse);

    Book updateBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    string updateBookResponse = check ep->updateBook(updateBookRequest);
    io:println(updateBookResponse);

    Book removeBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    RemoveBookResponse removeBookResponse = check ep->removeBook(removeBookRequest);
    io:println(removeBookResponse);

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
}

