import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:nawy_ai_app/app/core/injection/injection.dart';
import 'package:nawy_ai_app/app/core/network/network_cubit.dart';
import 'package:nawy_ai_app/app/features/ai_assistant/domain/ai_service.dart';
import 'package:nawy_ai_app/app/features/ai_assistant/presentation/bloc/ai_assistant_bloc.dart';
import 'package:nawy_ai_app/app/features/ai_assistant/presentation/models/assistant_message.dart';

class AiAssistantPage extends StatelessWidget {
  const AiAssistantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiAssistantBloc(getIt<AiService>())..add(const StartNewChatEvent()),
      child: const _AiAssistantView(),
    );
  }
}

class _AiAssistantView extends StatefulWidget {
  const _AiAssistantView();

  @override
  State<_AiAssistantView> createState() => _AiAssistantViewState();
}

class _AiAssistantViewState extends State<_AiAssistantView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();
  int _previousMessageCount = 0;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    // Store context in a local variable before any async operations
    final currentContext = context;

    // Check network connection
    final networkCubit = currentContext.read<NetworkCubit>();
    final isConnected = await networkCubit.checkConnection();

    // Check if widget is still mounted after async operation
    if (!mounted) return;

    if (!isConnected) {
      if (!currentContext.mounted) return;
      ScaffoldMessenger.of(currentContext).showSnackBar(
        const SnackBar(
          content: Text('Please check your internet connection and try again'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    if (message.isNotEmpty) {
      if (!mounted) return;
      currentContext.read<AiAssistantBloc>().add(SendMessageEvent(message));
      _messageController.clear();
      // Keep focus on the text field after sending
      _messageFocusNode.requestFocus();
      // Don't scroll here - let the listener handle it
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        // For reverse ListView, scroll to position 0 (which is the bottom)
        _scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nawy AI Assistant'),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 12),
            icon: const Icon(Icons.add_comment_outlined),
            onPressed: () {
              context.read<AiAssistantBloc>().add(const StartNewChatEvent());
            },
          ),
        ],
      ),
      body: BlocConsumer<AiAssistantBloc, AiAssistantState>(
        listener: (context, state) {
          // Only scroll when new messages are added
          if (state.messages.length > _previousMessageCount) {
            _previousMessageCount = state.messages.length;
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          if (state.status.isInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: state.messages.isEmpty
                    ? const Center(
                        child: Text(
                          'Ask me anything about properties!\n\nI can help you search for properties, find areas, compounds, and filter options.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: state.messages.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final message = state.messages[index];
                          return _AssistantBubble(message: message);
                        },
                      ),
              ),
              if (state.isLoading) const _TypingIndicator(),
              if (state.hasError)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          state.errorMessage ?? 'An error occurred',
                          style: TextStyle(color: Colors.red[600]),
                        ),
                      ),
                    ],
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        focusNode: _messageFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Type your message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.grey[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          _sendMessage();
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _sendMessage(),
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.send, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _TypingIndicator extends StatefulWidget {
  const _TypingIndicator();

  @override
  State<_TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<_TypingIndicator> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _dotAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    // Create staggered animations for 3 dots
    _dotAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0.4, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.2, 0.6 + index * 0.2, curve: Curves.easeInOut),
        ),
      );
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.smart_toy, color: Theme.of(context).primaryColor, size: 20),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...List.generate(3, (index) {
                  return AnimatedBuilder(
                    animation: _dotAnimations[index],
                    builder: (context, child) {
                      return Container(
                        margin: EdgeInsets.only(right: index < 2 ? 4 : 0),
                        child: Opacity(
                          opacity: _dotAnimations[index].value,
                          child: Transform.scale(
                            scale: _dotAnimations[index].value,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor.withValues(alpha: 0.7),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantBubble extends StatelessWidget {
  final AssistantMessage message;

  const _AssistantBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: Colors.grey[300], shape: BoxShape.circle),
              child: const Icon(Icons.smart_toy, color: Colors.grey),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
              ),
              child: MarkdownBody(
                data: message.text,
                styleSheet: MarkdownStyleSheet(
                  p: TextStyle(color: message.isUser ? Colors.white : Colors.black87, fontSize: 16),
                  strong: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  em: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black87,
                    fontStyle: FontStyle.italic,
                  ),
                  a: TextStyle(
                    color: message.isUser ? Colors.blue[200] : Colors.blue[700],
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTapLink: (text, href, title) {
                  if (href != null) {
                    // Handle link taps here if needed
                  }
                },
                selectable: true,
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }
}
