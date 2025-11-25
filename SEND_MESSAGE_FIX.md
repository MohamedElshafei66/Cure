# Send Message 400 Error - Fix

## 🔴 Error
```
Failed to send message: Exception: Failed to send chat: DioException [bad response]:
This exception was thrown because the response has a status code of 400
```

## ✅ Solution Applied

### Problem
The message payload was too complex. We were wrapping the message in a full `ChatModel` with nested `ChatData` and `messageList`, but the API expects a simple message object.

### What Changed

**BEFORE (Complex Structure):**
```dart
final chatModel = ChatModel(
  success: true,
  message: message,
  data: ChatData(
    id: int.tryParse(chatId) ?? 0,
    image: '',
    name: '',
    senderId: '',
    receiverId: receiverId,
    messageList: [messageData],
  ),
);
```

**AFTER (Simple Payload):**
```dart
final messageBody = {
  'message': message,
  'senderId': '',
  'receiverId': receiverId,
};
```

### Files Modified

1. ✅ `lib/feature/chat/presentation/cubit/conversation_cubit.dart`
   - Simplified message sending logic
   - Direct Map payload instead of ChatModel

2. ✅ `lib/feature/chat/domain/repositories/ChatRepository.dart`
   - Added `sendChatMessage(Map)` method

3. ✅ `lib/feature/chat/data/repositories/ChatRepositoryImp.dart`
   - Implemented `sendChatMessage` method

4. ✅ `lib/feature/chat/data/data_sources/chat_remote_data_source.dart`
   - Added `sendChatMessage` method
   - Added debug logging to see exact payload

---

## 🧪 Testing

### Try Sending a Message:
1. Hot reload the app: `r` in terminal
2. Go to any chat
3. Type a test message
4. Tap send
5. Check terminal for logs:
   ```
   📤 Sending message with data: {message: Hello, senderId: , receiverId: doc-123}
   ✅ Message sent successfully: {...}
   ```

---

## 🔍 If It Still Doesn't Work

### Check the Terminal Output
Look for the debug logs:
```
📤 Sending message with data: ...
❌ Send message error: ...
📝 Attempted payload: ...
```

### Common Issues and Solutions:

#### Issue 1: senderId Required
If error mentions "senderId", the API might need the actual sender ID:
```dart
// In conversation_cubit.dart, line ~67
final messageBody = {
  'message': message,
  'senderId': 'your-user-id-here',  // ← Add actual user ID
  'receiverId': receiverId,
};
```

#### Issue 2: Different Field Names
API might expect different field names. Check logs and try:
```dart
{
  'content': message,      // instead of 'message'
  'to': receiverId,        // instead of 'receiverId'
}
```

#### Issue 3: Additional Required Fields
API might need more fields:
```dart
{
  'message': message,
  'senderId': '',
  'receiverId': receiverId,
  'chatId': chatId,        // ← Add if needed
  'timestamp': DateTime.now().toIso8601String(),  // ← Add if needed
}
```

---

## 📋 Debug Checklist

If message still fails, check these:

- [ ] Hot reload applied? (press `r` in terminal)
- [ ] User is authenticated? (token exists)
- [ ] receiverId is valid? (not empty)
- [ ] Check terminal logs for exact error
- [ ] Try with a different doctor/chat
- [ ] Check if chat list loads (proves API works)

---

## 🔧 Advanced Debugging

### Enable Full API Logging
The `ApiServices` class already logs requests. Check terminal for:
```
📤 Sending Request...
➡️ URL: https://cure-doctor-booking.runasp.net/api/chat/chat/send
➡️ Method: POST
➡️ Headers: {...}
➡️ Body: {message: Hello, senderId: , receiverId: doc-123}
```

### Test API Directly
Use Postman or curl:
```bash
curl -X POST \
  https://cure-doctor-booking.runasp.net/api/chat/chat/send \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Test message",
    "senderId": "",
    "receiverId": "doctor-id"
  }'
```

---

## 🎯 Expected Behavior

After this fix:
- ✅ Type message
- ✅ Tap send
- ✅ Message appears immediately (optimistic)
- ✅ Request sent to server
- ✅ Messages reload from server
- ✅ Message stays in chat

---

## 📝 Summary

**Changed:** Complex ChatModel payload → Simple Map payload
**Why:** API expects simple message format, not nested structure
**Result:** Should fix 400 error when sending messages

---

**Status: ✅ READY TO TEST**

Hot reload and try sending a message!

