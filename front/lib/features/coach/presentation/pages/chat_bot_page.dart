import 'package:flutter/material.dart';
import 'package:mind_track/app/generated/l10n.dart';
import 'package:mind_track/app/injector.dart';
import 'package:mind_track/app/theme/mt_colors.dart';
import 'package:mind_track/features/coach/domain/entities/coach_response.dart';
import 'package:mind_track/features/coach/domain/repositories/coach_repository.dart';

Color _botPrimary = Color(0xFF2B6579);
Color _botBubble = Color(0xFFA0D8EF);
Color _botBubbleText = Color(0xFF235F73);

/// Chat con MindtrackBot (Gemini) siguiendo el diseño "ChatBot" de Figma.
class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final CoachRepository _coachRepository = Injector.get<CoachRepository>();
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<CoachChatMessage> _messages = <CoachChatMessage>[];
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _messages.add(_greetingMessage());
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  CoachChatMessage _greetingMessage() {
    return CoachChatMessage(
      role: 'model',
      content: S.current.chat_greeting,
      sentAt: DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildHeader(context),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.fromLTRB(12, 12, 12, 16),
                itemCount: _messages.length + (_isSending ? 2 : 1),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildDateChip();
                  }
                  final int messageIndex = index - 1;
                  if (messageIndex >= _messages.length) {
                    return _TypingBubble();
                  }
                  return _MessageBubble(message: _messages[messageIndex]);
                },
              ),
            ),
            _buildInputBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: context.mtColors.surfaceSubtle,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_rounded,
              size: 22,
              color: context.mtColors.textPrimary,
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _botBubble,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.smart_toy_outlined,
              size: 22,
              color: _botPrimary,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'MindtrackBot',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: _botPrimary,
                  ),
                ),
                Text(
                  _isSending ? S.current.chat_typing : S.current.chat_online,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    color: Color(0xFF42682C),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: S.current.chat_restart,
            onPressed: _isSending
                ? null
                : () {
                    setState(() {
                      _messages
                        ..clear()
                        ..add(_greetingMessage());
                    });
                  },
            icon: Icon(
              Icons.refresh_rounded,
              size: 22,
              color: context.mtColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: context.mtColors.borderSubtle,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          S.current.chat_today,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            color: context.mtColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 4, 12, 12),
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 4, 6, 4),
        decoration: BoxDecoration(
          color: context.mtColors.card,
          borderRadius: BorderRadius.circular(999),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _inputController,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
                style: TextStyle(
                  fontSize: 14,
                  color: context.mtColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: S.current.chat_input_hint,
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xFFC0C8CC)),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(width: 8),
            Material(
              color: _isSending ? Color(0xFFC0C8CC) : _botPrimary,
              shape: CircleBorder(),
              child: InkWell(
                onTap: _isSending ? null : _sendMessage,
                customBorder: CircleBorder(),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.send_rounded,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendMessage() async {
    final String text = _inputController.text.trim();
    if (text.isEmpty || _isSending) {
      return;
    }

    final List<CoachChatMessage> history = List<CoachChatMessage>.from(
      _messages,
    );
    setState(() {
      _messages.add(
        CoachChatMessage(role: 'user', content: text, sentAt: DateTime.now()),
      );
      _isSending = true;
    });
    _inputController.clear();
    _scrollToBottom();

    try {
      final String reply = await _coachRepository.sendChatMessage(
        message: text,
        history: history,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _messages.add(
          CoachChatMessage(
            role: 'model',
            content: reply,
            sentAt: DateTime.now(),
          ),
        );
        _isSending = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _isSending = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString().replaceFirst('Exception: ', '')),
        ),
      );
    }
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final CoachChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bool isUser = message.isUser;
    final String time = MaterialLocalizations.of(context).formatTimeOfDay(
      TimeOfDay.fromDateTime(message.sentAt),
      alwaysUse24HourFormat: false,
    );

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        child: Column(
          crossAxisAlignment: isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 4),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser ? context.mtColors.card : _botBubble,
                borderRadius: BorderRadius.circular(12),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isUser ? 0.04 : 0.02),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                message.content,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.45,
                  color: isUser ? context.mtColors.textPrimary : _botBubbleText,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4, right: 4, bottom: 12),
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: context.mtColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: _botBubble,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SizedBox(
          width: 32,
          height: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[_TypingDot(), _TypingDot(), _TypingDot()],
          ),
        ),
      ),
    );
  }
}

class _TypingDot extends StatelessWidget {
  _TypingDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: _botBubbleText,
        shape: BoxShape.circle,
      ),
    );
  }
}
