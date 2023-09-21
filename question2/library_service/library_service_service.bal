import ballerina/grpc;
import ballerina/uuid;

listener grpc:Listener ep = new (9090);

type BookRecord record {
    readonly string ISBN;
    string title;
    string author_1;
    string author_2?;
    string location;
    boolean status;
};

type user record {
    readonly string userID;
    string profile;
};

type BorrowBook record {|
    readonly string id;
    string userID;
    string ISBN;
|};

table<BookRecord> key(ISBN) booksTable = table [
    {title: "The Great Gatbsy", author_1: "F.Scott Fitzgerald", location: "Shelf a", ISBN: "9780743273565", status: true},
    {title: "Moby Dick", author_1: "Herman Melville", location: "Shelf B", ISBN: "9781853260087", status: false},
    {title: "pride and Prejudice", author_1: "Jane Austen", author_2: "Another Author", location: "Shelf C", ISBN: "9781853260001", status: true}
];

table<user> key(userID) usersTable = table [
    {userID: "U101", profile: "student"},
    {userID: "U102", profile: "librarian"}
];

table<BorrowBook> borrowedBooksTable = table [
    {userID: "U101", ISBN: "9781853260087", id: "1"}
];

table<BorrowBook> key(id) borrowBookTable = table [];

@grpc:Descriptor {value: LIBRARY_DESC}
service "library_service" on ep {

    remote function addBook(BookRecord value) returns string {

    }
    remote function updateBook(BookRecord value) returns BookRecord|error {

    }

    remote function removeBook(Book value) returns table<BookRecord> key(ISBN)|error {

    }

    remote function locateBook(Book value) returns string|error {

    }
    remote function borrowBook(BorrowBookRequest value) returns string|error {

    }
    remote function createUser(stream<user, grpc:Error?> clientStream) returns error? {

    }

    // Return any error that might have occurred during the stream processing

    remote function listAvailableBooks() returns stream<BookRecord, error?>|error {

    }

}

