const String APP_NAME = "Attendance System";

// SharedPreference Key Points
const String KEY_BATCH = "Batch";
const String KEY_BRANCH = "Branch";
const String KEY_ROLL = "RollNo";

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
const String COLLECTION_REGISTERED_PAPER = "paper";
const String COLLECTION_QUERY = "query";

const String DB_NOTIFICATION_DATE = "Date";
const String DB_NOTIFICATION_TEXT = "Text";

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
