const String APP_NAME = "Attendance System";

//View Text
const String LOADING = "Please Wait";
const String LOADING_REGISTERED_PAPER = "Getting Registered Papers";
const String LOADING_TIME = "Updating Class Timing";
const String LOADING_ATTENDANCE = "Fetching Your Attendance";
const String LOADING_NOTIFICATION = "Retrieving Notification";
const String TITLE_LOGIN = "Welcome\nback";
const String SUBTITLE_LOGIN = "Sign in to continue";
const String DO_NOT_HAVE_ACCOUNT = "Don't have an account?  ";
const String CONTACT_YOUR_COLLEGE = "Contact College";

const String HINT_EMAIL = "Enter Email";
const String HINT_PASSWORD = "Enter Password";

//Error
const String ERROR_NETWORK = "Please Check Your Internet Connection";
const String ERROR_EMAIL = "Please Check Your Email";
const String ERROR_PASSWORD = "Password Not Valid";
const String ERROR_LOGIN_FAILED = "Login Failed";
const String ERROR = "Error While Loading";

// Button
const String BUTTON_RETRY = "Retry";
const String BUTTON_LOGIN = "Sign in";

// SharedPreference Key Points
const String KEY_BATCH = "Batch";
const String KEY_BRANCH = "Branch";
const String KEY_ROLL = "RollNo";
const String KEY_NAME = "Name";

// Sqflite
const String DB_NAME = "AttendanceSystem";
const String TABLE_NAME = "Timing";
const String COL_ID = "id";
const String COL_PAPER = "paper";
const String COL_START_TIME = "start";
const String COL_END_TIME = "end";
const String COL_LAT = "lat";
const String COL_LON = "lon";
const String COL_DAY = "day";

// Firebase Key Points
const String COLLECTION_NOTIFICATION = "notification";
const String COLLECTION_ATTENDANCE = "attendance";
const String COLLECTION_REGISTERED_PAPER = "registeredPapers";
const String COLLECTION_QUERY = "query";
const String COLLECTION_STUDENT = "students";
const String COLLECTION_TIMING = "timing";
const String DB_NOTIFICATION_DATE = "Date";
const String DB_NOTIFICATION_TEXT = "Text";
const String DB_STUDENT_BRANCH = "Branch";
const String DB_STUDENT_ROLL = "Roll";
const String DB_STUDENT_NAME = "Name";

// WeekDay Name
const List<String> DAY = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];



//day: list[0],
//startTime: list[1].replaceAll(":", ""),
//endTime: list[2].replaceAll(":", ""),
//lat: list[3],
//lon: list[4],
// notification->IT2K16#943892742 -> Date & Text
// attendance -> IT2K16 -> map<String,Array> -> (String: Array<String> )
// registeredPapers -> IT2K16 -> String:Array
// students -> email -> Branch, Name, Roll;
// timing -> IT2k16 -> DBMS (Array -> )

