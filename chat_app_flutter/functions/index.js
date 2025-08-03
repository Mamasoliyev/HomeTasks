
const {onDocumentCreated} = require("firebase-functions/v2/firestore");
const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const {getMessaging} = require("firebase-admin/messaging");

initializeApp();

exports.sendMessageNotification = onDocumentCreated(
    "chat-messages/{chatId}/messages/{messageId}",
    async (event) => {
      if (!event.data) {
        console.log("❗ No message snapshot");
        return;
      }

      const message = event.data.data();
      const senderId = message.senderId;
      const receiverId = message.recieverId;

      if (!senderId || !receiverId) {
        console.log("❗ Missing senderId or receiverId");
        return;
      }

      const db = getFirestore();

      // ✅ Fetch sender name
      let senderName = "Someone";
      try {
        const senderSnap = await db.collection("users").doc(senderId).get();
        senderName = senderSnap.exists ? senderSnap.data().name : "Someone";
      } catch (e) {
        console.error("❌ Failed to get sender name", e);
      }

      // ✅ Fetch receiver FCM token
      const receiverSnap = await db.collection("users").doc(receiverId).get();
      const fcmToken = receiverSnap.exists ? receiverSnap.data().fcmToken : 
      null;

      if (!fcmToken) {
        console.log(`❗ No FCM token for user: ${receiverId}`);
        return;
      }

      const payload = {
        notification: {
          title: `New message from ${senderName}`,
          body: message.body || "You have a new message!",
        },
        token: fcmToken,
      };

      try {
        await getMessaging().send(payload);
        console.log("✅ Notification sent to", receiverId);
      } catch (err) {
        console.error("❌ Failed to send notification", err);
      }
    },
);
