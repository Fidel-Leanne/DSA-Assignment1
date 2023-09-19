import ballerina/grpc;
import ballerina/protobuf;
import ballerina/lang.value as value1;
import ballerina/io;

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

type BorrowBook record {
    
};

@grpc:Descriptor {value: LIBRARY_DESC}
service "library_service" on ep {

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
            status: "not available"

             };

             string ISBN = addBook(Book);
       
    }
    remote function updateBook(Book value) returns Book|error {
        // BookRecord book = booksTable.get(value.ISBN);

        if (value.status === ""){
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
    remote function borrowBook(BorrowBookRequest value) returns BookRecord|error {
        Book book = booksTable.get(value.ISBN);

        if (book.status is null){
            return error("Book not found");
        }
        if (book.status != true){
            return error ("Book is not availbale");
        }
         book.status = false;

         booksTable.put(BookRecord);

         BorrowBook BorrowBook ={
            userID: " 221029397",
            ISBN: "9780743273565",
            
         };
        return book;

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

