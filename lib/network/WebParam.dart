// class WebParam {
//   static String EMAIL = "Email";
//   static String PASSWORD = "Password";
//   static String FIREBASETOKEN = "deviceToken";//charbel
//   static String IDENTIFIER="Identifier";
//   static String FILTER="filters";
//   static String NOTE = "note";
//   static String ID = "id";
//   static String QRCODEPARAMM="imei";
//   // static String PATIENTID="patientId";
//
//   static Map<String, dynamic> LoginParams(
//       String email, String pass,String fbt) {
//     var map = new Map<String, String>();
//     map[EMAIL] = email;
//     map[PASSWORD] = pass;
//     map[FIREBASETOKEN] = fbt;
//     print(map);
//     return map;
//   }
//   static Map<String, dynamic> ResetParams(
//       String identifier) {
//     var map = new Map<String, String>();
//     map[IDENTIFIER] = identifier;
//
//     print(map);
//     return map;
//   }
//   static Map<String, dynamic> ResetPassParams(
//       String email) {
//     var map = new Map<String, String>();
//     map[EMAIL] = email;
//     print(map);
//     return map;
//   }
//   static Map<String, List<String>> FilterParams(
//       List<String> filters) {
//     var map = new Map<String,List<String>>();
//    map[FILTER]=filters;
//     print(map);
//     return map;
//   }
//   static Map<String,dynamic>AddNote(String noteValue){
//     var note = new Map<String,dynamic>();
//
//     note[NOTE]=noteValue;
//     return note;
//   }
//   static Map<String,dynamic>? IDPARAMS(String id){
//     var mapid = new Map<String,String>();
//
//     mapid[ID]=id;
//     return mapid;
//   }
//   static Map<String, dynamic> QRCODEPARAM(
//        String IMEI ,) {
//     var mapqr = new Map<String, String>();
//     mapqr[QRCODEPARAMM] = IMEI;
//     // mapqr[PATIENTID] = patId;
//
//     print(mapqr);
//     return mapqr;
//   }
// }
