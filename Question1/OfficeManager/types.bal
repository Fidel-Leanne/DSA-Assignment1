
public type Staff record {
    readonly int staffNumber;
    int officeNumber;
    string staffName;
    string title;
    Course[] courseList;
};

public type Course record {
    readonly string courseCode;
    string courseName;
    int NQFLevel;
};
