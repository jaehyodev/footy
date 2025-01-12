const functions = require("firebase-functions");
const admin = require("firebase-admin");

var serviceAccount = require("./footy-dba5b-firebase-adminsdk-1cdrk-0d416172b0.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.createCustomToken = functions.https.onRequest(
  async (request, response) => {
    const user = request.body;

    const uid = `kakao:${user.uid}`;
    const updateParams = {
      email: user.email,
    };

    try {
      await admin.auth().updateUser(uid, updateParams);
    } catch (e) {
      updateParams["uid"] = uid;
      await admin.auth().createUser(updateParams);
    }

    const token = await admin.auth().createCustomToken(uid);

    response.send(token);
  }
);
