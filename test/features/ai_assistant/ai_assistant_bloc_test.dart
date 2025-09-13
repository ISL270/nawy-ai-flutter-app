import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nawy_app/app/core/models/status.dart';
import 'package:nawy_app/app/features/ai_assistant/domain/ai_service.dart';
import 'package:nawy_app/app/features/ai_assistant/presentation/bloc/ai_assistant_bloc.dart';
import 'package:nawy_app/app/features/ai_assistant/presentation/models/assistant_message.dart';

class MockAiService extends Mock implements AiService {}

void main() {
  group('AiAssistantBloc', () {
    late AiAssistantBloc bloc;
    late MockAiService mockAiService;

    setUp(() {
      mockAiService = MockAiService();
      bloc = AiAssistantBloc(mockAiService);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is correct', () {
      expect(bloc.state, AiAssistantState.initial());
    });

    group('State convenience methods', () {
      test('isLoading returns correct value', () {
        final loadingState = AiAssistantState.initial().copyWith(status: const Loading());
        final successState = AiAssistantState.initial().copyWith(status: const Success(null));
        
        expect(loadingState.isLoading, true);
        expect(successState.isLoading, false);
      });

      test('hasError returns correct value', () {
        final errorState = AiAssistantState.initial().copyWith(status: const Failure('Error'));
        final successState = AiAssistantState.initial().copyWith(status: const Success(null));
        
        expect(errorState.hasError, true);
        expect(successState.hasError, false);
      });

      test('hasMessages returns correct value', () {
        final emptyState = AiAssistantState.initial();
        final withMessagesState = AiAssistantState.initial().copyWith(
          messages: [
            AssistantMessage(
              id: '1',
              text: 'Hello',
              isUser: true,
              timestamp: DateTime.now(),
            ),
          ],
        );
        
        expect(emptyState.hasMessages, false);
        expect(withMessagesState.hasMessages, true);
      });

      test('errorMessage returns correct value', () {
        final errorState = AiAssistantState.initial().copyWith(status: const Failure('Test error'));
        final successState = AiAssistantState.initial().copyWith(status: const Success(null));
        
        expect(errorState.errorMessage, equals('Test error'));
        expect(successState.errorMessage, isNull);
      });
    });

    group('State Equality', () {
      test('states with same properties should be equal', () {
        final state1 = AiAssistantState.initial();
        final state2 = AiAssistantState.initial();
        
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('states with different properties should not be equal', () {
        final state1 = AiAssistantState.initial();
        final state2 = AiAssistantState.initial().copyWith(status: const Loading());
        
        expect(state1, isNot(equals(state2)));
      });
    });
  });
}
