part of 'ai_assistant_bloc.dart';

final class AiAssistantState extends Equatable {
  // Overall loading/error status
  final VoidStatus status;

  // Chat messages
  final List<AssistantMessage> messages;

  const AiAssistantState._({
    required this.status,
    required this.messages,
  });

  // Factory constructor for initial state
  const AiAssistantState._initial()
    : this._(
        status: const Initial(),
        messages: const [],
      );

  // Factory constructor - use this instead of default constructor
  factory AiAssistantState.initial() => AiAssistantState._initial();

  AiAssistantState _copyWith({
    VoidStatus? status,
    List<AssistantMessage>? messages,
  }) {
    return AiAssistantState._(
      status: status ?? this.status,
      messages: messages ?? this.messages,
    );
  }

  // Public copyWith method
  AiAssistantState copyWith({
    VoidStatus? status,
    List<AssistantMessage>? messages,
  }) {
    return _copyWith(
      status: status,
      messages: messages,
    );
  }

  // Convenience getters for checking states
  bool get isLoading => status.isLoading;
  bool get hasError => status.isFailure;
  bool get hasMessages => messages.isNotEmpty;

  // Error message getter
  String? get errorMessage => status.isFailure ? (status as Failure).message : null;

  @override
  List<Object?> get props => [status, messages];
}
