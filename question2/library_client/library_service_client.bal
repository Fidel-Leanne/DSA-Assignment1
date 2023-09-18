import ballerina/io;

library_serviceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    Book addBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: "ballerina"};
    AddBookResponse addBookResponse = check ep->addBook(addBookRequest);
    io:println(addBookResponse);

    Book updateBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: "ballerina"};
    check ep->updateBook(updateBookRequest);

    Book removeBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: "ballerina"};
    RemoveBookResponse removeBookResponse = check ep->removeBook(removeBookRequest);
    io:println(removeBookResponse);

    Book locateBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: "ballerina"};
    LocateBookResponse locateBookResponse = check ep->locateBook(locateBookRequest);
    io:println(locateBookResponse);

    BorrowBookRequest borrowBookRequest = {userID: "ballerina", ISBN: "ballerina"};
    check ep->borrowBook(borrowBookRequest);
    stream<

Book, error?> listAvailableBooksResponse = check ep->listAvailableBooks();
    check listAvailableBooksResponse.forEach(function(Book value) {
        io:println(value);
    });

    User createUserRequest = {userID: "ballerina", profile: "ballerina"};
    CreateUserStreamingClient createUserStreamingClient = check ep->createUser();
    check createUserStreamingClient->sendUser(createUserRequest);
    check createUserStreamingClient->complete();
    check createUserStreamingClient->receive();
}

