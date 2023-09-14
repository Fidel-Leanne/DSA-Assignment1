import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "library_service" on ep {

    remote function addBook(Book value) returns AddBookResponse|error {
    }
    remote function updateBook(Book value) returns error? {
    }
    remote function removeBook(Book value) returns RemoveBookResponse|error {
    }
    remote function locateBook(Book value) returns LocateBookResponse|error {
    }
    remote function borrowBook(BorrowBookRequest value) returns error? {
    }
    remote function createUser(stream<User, grpc:Error?> clientStream) returns error? {
    }
    remote function listAvailableBooks() returns stream<Book, error?>|error {
    }
}

