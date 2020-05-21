const String APP_NAME = "Auto ERP System";

//View Text
const String LOADING = "Please Wait";
const String LOADING_REGISTERED_PAPER = "Getting Registered Papers";
const String LOADING_TIME = "Updating Class Timing";
const String LOADING_ATTENDANCE = "Fetching Your Attendance";
const String LOADING_NOTIFICATION = "Retrieving Notification";
const String TITLE_LOGIN = "Welcome\nback";
const String SUBTITLE_LOGIN = "Sign in to continue";
const String DO_NOT_HAVE_ACCOUNT = "Don't have an account? ";
const String CONTACT_YOUR_COLLEGE = "Contact College";
const String STEP1_TITLE = "Topic";
const String STEP2_TITLE = "Query";
const String STEP3_TITLE = "Additonal";
const String HINT_EMAIL = "Enter Email";
const String HINT_PASSWORD = "Enter Password";
const String HINT_RELATED = "Query Related To";
const String HINT_QUERY = "Enter Your Query";
const String HINT_ADDITIONAL = "Any additional detail (optional)";
const String HINT_SUBMITTED = "Query Submited";
const String HINT_WAIT_FOR_LOCATION = "Waiting For Location Permission";
const String HINT_AUTHENTICATING = "Authenticating";
const String HINT_GETTING_SUBJECT = "Getting Current Subject Name";
const String HINT_CHECKING_ATTENDANCE = "Cheking attendance already updated or not";
const String HINT_CHECKING_CLASSROOM = "Checking you are in classroom";
const String HINT_UPDATING_ATTENDANCE = "Updating Your Attendance";
const String HINT_UPDATED_ATTENDANCE = "Attendance Updated";
const String HINT_PRESS_TO_AUTH = "Press Me To Authenticate";

//Error
const String ERROR_NETWORK = "Please Check Your Internet Connection";
const String ERROR_FETCHING_DATA = "Error During Loading Data From Firebase";
const String ERROR_EMAIL = "Please Check Your Email";
const String ERROR_PASSWORD = "Password Not Valid";
const String ERROR_LOGIN_FAILED = "Login Failed";
const String ERROR_REQUIRED = "Required Field";
const String ERROR = "Error While Loading";
const String ERROR_NOT_ANY_CLASS = "You don't have any class now";
const String ERROR_ATTENDANCE_ALREADY_UPDATE = "Attendance Already Updated";
const String ERROR_NOT_IN_CLASSROOM = "You are not in classroom";
const String ERROR_FAILED_TO_UPDATE = "Failed To Update Attendance";

// Button
const String BUTTON_RETRY = "Retry";
const String BUTTON_LOGIN = "Sign in";
const String BUTTON_CONTINUE = "Continue";
const String BUTTON_CANCEL = "Prev";
const String BUTTON_SUBMIT = "Submit";

// SharedPreference Key Points
const String KEY_BATCH = "Batch";
const String KEY_BRANCH = "Branch";
const String KEY_ROLL = "RollNo";
const String KEY_NAME = "Name";
const String KEY_LAST_UPDATE = "Update";

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

// Others
const String APP_UNDER_DEVELOPMENT = "No Info Availabe, App Is Under Development !!!";
const String SPLIT_POINT = "#";


// Array
const List<String> APP_BAR_TITLE = [
  "Attendance",
  "Registered Papers",
  "Update Attendance",
  "Contact",
  "Notification",
];

const List<String> DAY = [
  'Mon',
  'Tue',
  'Wed',
  'Thu',
  'Fri',
  'Sat',
  'Sun',
];
