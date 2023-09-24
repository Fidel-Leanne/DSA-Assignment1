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

    remote function addBook(BookRecord value) returns BookRecord|error {
        if (!value.status) {
            return error("Book not available");
        }

        booksTable.put(value);

        return value;

    }
    remote function updateBook(BookRecord value) returns table<BookRecord> key(ISBN)|error {
        BookRecord book = booksTable.get(value.ISBN);

        if (!value.status) {
            return error("Book not found");
        }
        //remove book from the list 
        BookRecord book_ = booksTable.remove(value.ISBN);

        return booksTable;

    }

    remote function removeBook(Book value) returns table<BookRecord> key(ISBN)|error {
        BookRecord _ = booksTable.get(value.ISBN);

        if (!value.status) {
            return error("Book not found");
        }
        //remove book from the list 
        BookRecord book_ = booksTable.remove(value.ISBN);

        return booksTable;

    }

    remote function locateBook(Book value) returns string|error {
        BookRecord book = booksTable.get(value.ISBN);

        if (!value.status) {
            return error("Book not found");
        }
        if (book.status != true) {
            return error("Book is not available");
        } else {
            return book.location;
        }

    }
    remote function borrowBook(BorrowBookRequest value) returns string|error {
        string id = uuid:createType1AsString();

        if (value.userID === "" || value.ISBN === "") {
            return error("User id or isbn not provided");
        }

        error? borrowBook = borrowBookTable.add({id, ...value});
        if borrowBook is error {
            return error("Failed to borrow a Book");
        }
        return "Successfully borrowed a book";

    }
    remote function createUser(stream<user, grpc:Error?> clientStream) returns error? {

        error? e = clientStream.forEach(function(user usr) {
            // Validate the user data if necessary
            if (usr.userID == "" || (usr.profile != "student" && usr.profile != "librarian")) {
                return ();
            }

            // Check if user already exists
            user? existingUser = usersTable.get(usr.userID);
            if existingUser is user {
                return ();
            }

            // Add user to the table
            usersTable.add(usr);
        });

        // Return any error that might have occurred during the stream processing
        return e;
    }

    // Return any error that might have occurred during the stream processing

    remote function listAvailableBooks() returns stream<BookRecord, error?>|error {
        BookRecord[] availableBooks = [];

        // Iterate over the book entries in the table
        foreach var book in booksTable {
            if (book.status) {
                availableBooks.push(book);
            }
        }

        // Convert array to stream
        return availableBooks.toStream();
    }

}

