import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:nawy_app/app/core/models/status.dart';
import 'package:nawy_app/app/features/ai_assistant/domain/ai_service.dart';
import 'package:nawy_app/app/features/ai_assistant/presentation/models/assistant_message.dart';

part 'ai_assistant_event.dart';
part 'ai_assistant_state.dart';

class AiAssistantBloc extends Bloc<AiAssistantEvent, AiAssistantState> {
  final AiService _aiService;
  ChatSession? _currentChat;

  AiAssistantBloc(this._aiService) : super(AiAssistantState.initial()) {
    on<StartNewChatEvent>(_onStartNewChat);
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onStartNewChat(StartNewChatEvent event, Emitter<AiAssistantState> emit) async {
    try {
      _currentChat = _aiService.startNewChat();
      emit(state.copyWith(status: const Success(null), messages: []));
    } catch (error) {
      emit(state.copyWith(status: Failure('Failed to start new chat: $error')));
    }
  }

  Future<void> _onSendMessage(SendMessageEvent event, Emitter<AiAssistantState> emit) async {
    try {
      _currentChat ??= _aiService.startNewChat();

      // Add user message to chat
      final userMessage = AssistantMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: event.message,
        isUser: true,
        timestamp: DateTime.now(),
      );

      final updatedMessages = [userMessage, ...state.messages];
      emit(state.copyWith(status: const Loading(), messages: updatedMessages));

      // Send message to AI
      final response = await _aiService.sendMessage(_currentChat!, event.message);

      // Create AI response message
      final aiMessage = AssistantMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: response.text ?? 'Sorry, I couldn\'t process your request.',
        isUser: false,
        timestamp: DateTime.now(),
      );

      final finalMessages = [aiMessage, ...updatedMessages];
      emit(state.copyWith(status: const Success(null), messages: finalMessages));
    } catch (error) {
      // Handle error
      final errorMessage = AssistantMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'Sorry, I encountered an error: $error',
        isUser: false,
        timestamp: DateTime.now(),
      );

      final finalMessages = [errorMessage, ...state.messages];
      emit(
        state.copyWith(status: Failure('Failed to send message: $error'), messages: finalMessages),
      );
    }
  }
}
