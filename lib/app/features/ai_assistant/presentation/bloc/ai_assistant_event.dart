part of 'ai_assistant_bloc.dart';

abstract class AiAssistantEvent extends Equatable {
  const AiAssistantEvent();

  @override
  List<Object> get props => [];
}

class StartNewChatEvent extends AiAssistantEvent {
  const StartNewChatEvent();
}

class SendMessageEvent extends AiAssistantEvent {
  final String message;

  const SendMessageEvent(this.message);

  @override
  List<Object> get props => [message];
}
