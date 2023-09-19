import ballerina/grpc;
<<<<<<< HEAD
import ballerina/protobuf;
import ballerina/lang.value as value1;
import ballerina/io;
import ballerina/uuid;
=======
>>>>>>> 8664b8a9d6190d685fcf6e1b2fdc2311d561f844

listener grpc:Listener ep = new (9090);

type BookRecord record {
    readonly string ISBN;
    string title;
    string author_1;
    string author_2?;
    string location;
    boolean status;
};

table<Book> key(ISBN) booksTable = table[
    {title: "The Great Gatbsy", author_1: "F.Scott Fitzgerald", location: "Shelf a", ISBN: "9780743273565", status: true},
    {title: "Moby Dick",author_1: "Herman Melville", location: "Shelf B", ISBN: "9781853260087", status: false},
    {title: "pride and Prejudice", author_1: "Jane Austen", author_2: "Another Author", location: "Shelf C",ISBN: "9781853260001", status: true}
];

type BorrowBook record {|
readonly string id;
string userID;
string ISBN;
|};

table<BorrowBook> key(id) borrowBookTable = table[];




@grpc:Descriptor {value: LIBRARY_DESC}
service "library_service" on ep {

<<<<<<< HEAD
    remote function addBook(Book value) returns string {
        booksTable.add(value);
        return value.ISBN;
        
        //create a record 
        Book book ={
            title: "Mpho Search ",
            author_1: "Sandra Braude",
            author_2: "Thandeka Sibanda",
            location: "Shelf D ",
            ISBN: "9780195709612",
            status: false

             };

             string ISBN = addBook(Book);
       
    }
    remote function updateBook(Book value) returns Book|error {
        // BookRecord book = booksTable.get(value.ISBN);

        if (value.status is null){
            return error ("Book not available");
        }

        
        booksTable.put(value);

        return value;
        

        }


    
    remote function removeBook(Book value) returns table<Book> key(ISBN)|error {
        Book book = booksTable.get(value.ISBN);

        if (book.status is null){
            return  error ("Book not found");
        }
        //remove book from the list 
        Book book_ = booksTable.remove(value.ISBN);

        return booksTable;
        
    
=======
    remote function addBook(Book value) returns AddBookResponse|error {
    }
    remote function updateBook(Book value) returns error? {
>>>>>>> 8664b8a9d6190d685fcf6e1b2fdc2311d561f844
    }
    remote function locateBook(Book value) returns string|error {

        Book book = booksTable.get(value.ISBN);

        if (book.status is null){
            return error ("Book not found")
        }
        if (book.status != true){
            return error ("Book is not available");
        }else{
            return book.location;
        }
    
    }
    remote function borrowBook(BorrowBookRequest value) returns string|error {
        
        string id = uuid:createType1AsString();

        if (value.userID is null || value.ISBN is null){
            return error("User id or isbn not provided");
        }

        error? borrowBook = borrowBookTable.add({id, ...value});
        if borrowBook is error{
            return error("Failed to borrow a Book");
        }
        return "Successfully borrowed a book";

    }
    remote function createUser(stream<User, grpc:Error?> clientStream) returns error? {

    }
    remote function listAvailableBooks() returns stream<Book, error?>|error {
        stream<Book, error?> booksStream = new stream<Book, error?>();
        
    }

}

function addBook(typedesc<Book> t) returns string {
    return "";
}

