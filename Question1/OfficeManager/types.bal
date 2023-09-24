public type Staff record {
    readonly int staffNumber;
    string staffName;
    string title;
    int officeNumber;
   CourseList[] courseList; 
};

//CourseList[] courseList;
public type CourseList record {
    string courseCode;
    string courseName;
    int NQFLevel;
};
 
