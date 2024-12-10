import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:quick_chat/models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  List<MessageModel> messagesList = [];

  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        'message': message,
        'createdAt': DateTime.now(),
        'id': email,
      });
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  void getMessages() {
    messages.orderBy('createdAt', descending: true).snapshots().listen(
      (event) {
        messagesList.clear();
        for (var doc in event.docs) {
          messagesList.add(MessageModel.fromJson(doc));
        }
        emit(ChatSuccess(messages: messagesList));
      },
    );
  }
}
