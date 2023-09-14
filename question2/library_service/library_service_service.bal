import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "library_service" on ep {

    remote function addBook(Book value) returns AddBookResponse|error {
        //create a record 
        Book book ={
            title: "request.title",
            author_1: "request.author_1",
            author_2: "request.author_2",
            location: "request.location",
            ISBN: "request.ISBN",
            status: "true"
        

        };
        //Adding a book to the library collection
        library.addBook(book);

        //response message
        AddBookResponse response= {
            ISBN: book.ISBN
        };
        return response;

    }
    remote function updateBook(Book value) returns error? {
        library.updateBook(Book);

        
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

