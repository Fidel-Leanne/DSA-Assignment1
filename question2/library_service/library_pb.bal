import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;

public const string LIBRARY_DESC = "0A0D6C6962726172792E70726F746F12076C6962726172791A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F229A010A04426F6F6B12140A057469746C6518012001280952057469746C6512190A08617574686F725F311802200128095207617574686F723112190A08617574686F725F321803200128095207617574686F7232121A0A086C6F636174696F6E18042001280952086C6F636174696F6E12120A044953424E18052001280952044953424E12160A06737461747573180620012808520673746174757322250A0F416464426F6F6B526573706F6E736512120A044953424E18012001280952044953424E22390A1252656D6F7665426F6F6B526573706F6E736512230A05626F6F6B7318012003280B320D2E6C6962726172792E426F6F6B5205626F6F6B73224A0A124C6F63617465426F6F6B526573706F6E7365121A0A086C6F636174696F6E18012001280952086C6F636174696F6E12180A076D65737361676518022001280952076D657373616765223F0A11426F72726F77426F6F6B5265717565737412160A06757365724944180120012809520675736572494412120A044953424E18022001280952044953424E22380A045573657212160A06757365724944180120012809520675736572494412180A0770726F66696C65180220012809520770726F66696C6532A6030A0F6C6962726172795F7365727669636512320A07616464426F6F6B120D2E6C6962726172792E426F6F6B1A182E6C6962726172792E416464426F6F6B526573706F6E736512350A0A63726561746555736572120D2E6C6962726172792E557365721A162E676F6F676C652E70726F746F6275662E456D707479280112330A0A757064617465426F6F6B120D2E6C6962726172792E426F6F6B1A162E676F6F676C652E70726F746F6275662E456D70747912380A0A72656D6F7665426F6F6B120D2E6C6962726172792E426F6F6B1A1B2E6C6962726172792E52656D6F7665426F6F6B526573706F6E7365123D0A126C697374417661696C61626C65426F6F6B7312162E676F6F676C652E70726F746F6275662E456D7074791A0D2E6C6962726172792E426F6F6B300112380A0A6C6F63617465426F6F6B120D2E6C6962726172792E426F6F6B1A1B2E6C6962726172792E4C6F63617465426F6F6B526573706F6E736512400A0A626F72726F77426F6F6B121A2E6C6962726172792E426F72726F77426F6F6B526571756573741A162E676F6F676C652E70726F746F6275662E456D707479620670726F746F33";

public isolated client class library_serviceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function addBook(Book|ContextBook req) returns AddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.library_service/addBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddBookResponse>result;
    }

    isolated remote function addBookContext(Book|ContextBook req) returns ContextAddBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.library_service/addBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddBookResponse>result, headers: respHeaders};
    }

    isolated remote function updateBook(Book|ContextBook req) returns grpc:Error? {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        _ = check self.grpcClient->executeSimpleRPC("library.library_service/updateBook", message, headers);
    }

    isolated remote function updateBookContext(Book|ContextBook req) returns empty:ContextNil|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.library_service/updateBook", message, headers);
        [anydata, map<string|string[]>] [_, respHeaders] = payload;
        return {headers: respHeaders};
    }

    isolated remote function removeBook(Book|ContextBook req) returns RemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.library_service/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveBookResponse>result;
    }

    isolated remote function removeBookContext(Book|ContextBook req) returns ContextRemoveBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.library_service/removeBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveBookResponse>result, headers: respHeaders};
    }

    isolated remote function locateBook(Book|ContextBook req) returns LocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.library_service/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <LocateBookResponse>result;
    }

    isolated remote function locateBookContext(Book|ContextBook req) returns ContextLocateBookResponse|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.library_service/locateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <LocateBookResponse>result, headers: respHeaders};
    }

    isolated remote function borrowBook(BorrowBookRequest|ContextBorrowBookRequest req) returns grpc:Error? {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        _ = check self.grpcClient->executeSimpleRPC("library.library_service/borrowBook", message, headers);
    }

    isolated remote function borrowBookContext(BorrowBookRequest|ContextBorrowBookRequest req) returns empty:ContextNil|grpc:Error {
        map<string|string[]> headers = {};
        BorrowBookRequest message;
        if req is ContextBorrowBookRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.library_service/borrowBook", message, headers);
        [anydata, map<string|string[]>] [_, respHeaders] = payload;
        return {headers: respHeaders};
    }

    isolated remote function createUser() returns CreateUserStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("library.library_service/createUser");
        return new CreateUserStreamingClient(sClient);
    }

    isolated remote function listAvailableBooks() returns stream<Book, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("library.library_service/listAvailableBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        BookStream outputStream = new BookStream(result);
        return new stream<Book, grpc:Error?>(outputStream);
    }

    isolated remote function listAvailableBooksContext() returns ContextBookStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("library.library_service/listAvailableBooks", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        BookStream outputStream = new BookStream(result);
        return {content: new stream<Book, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public client class CreateUserStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receive() returns grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            _ = response;
        }
    }

    isolated remote function receiveContextNil() returns empty:ContextNil|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [_, headers] = response;
            return {headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public class BookStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Book value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Book value;|} nextRecord = {value: <Book>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class Library_serviceNilCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class Library_serviceLocateBookResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendLocateBookResponse(LocateBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextLocateBookResponse(ContextLocateBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class Library_serviceRemoveBookResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendRemoveBookResponse(RemoveBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextRemoveBookResponse(ContextRemoveBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class Library_serviceBookCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBook(Book response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBook(ContextBook response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class Library_serviceAddBookResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddBookResponse(AddBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddBookResponse(ContextAddBookResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextBookStream record {|
    stream<Book, error?> content;
    map<string|string[]> headers;
|};

public type ContextLocateBookResponse record {|
    LocateBookResponse content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    Book content;
    map<string|string[]> headers;
|};

public type ContextBorrowBookRequest record {|
    BorrowBookRequest content;
    map<string|string[]> headers;
|};

public type ContextAddBookResponse record {|
    AddBookResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveBookResponse record {|
    RemoveBookResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateBookResponse record {|
    string location = "";
    string message = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type User record {|
    string userID = "";
    string profile = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Book record {|
    string title = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    readonly string ISBN = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowBookRequest record {|
    string userID = "";
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type AddBookResponse record {|
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type RemoveBookResponse record {|
    Book[] books = [];
|};

