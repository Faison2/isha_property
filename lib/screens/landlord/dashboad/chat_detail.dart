import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ── Palette ───────────────────────────────────────────────────────────────────
class _C {
  static const bg          = Color(0xFFFAF5F0);
  static const bgCard      = Color(0xFFFFFFFF);
  static const primary     = Color(0xFFB5622A);
  static const primaryLo   = Color(0x1AB5622A);
  static const text        = Color(0xFF1A1A1A);
  static const textSub     = Color(0xFF888888);
  static const textLight   = Color(0xFFAAAAAA);
  static const divider     = Color(0xFFF0EBE6);
  static const inputBg     = Color(0xFFF5EFE9);
  static const inputBorder = Color(0xFFE4D8CE);

  // Bubble colours
  static const bubbleMe      = Color(0xFFB5622A); // terracotta — sent
  static const bubbleThem    = Color(0xFFFFFFFF); // white card — received
  static const bubbleThemBdr = Color(0xFFF0EBE6);
}

class ChatDetailScreen extends StatefulWidget {
  final dynamic conversation;

  const ChatDetailScreen({super.key, required this.conversation});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _messageController = TextEditingController();
  final _scrollController  = ScrollController();
  final _focusNode         = FocusNode();

  final List<_ChatMessage> _messages = [
    _ChatMessage(
      text: 'Hi there! I\'m interested in the Sunset Apartment.',
      isMe: false,
      time: '10:30 AM',
    ),
    _ChatMessage(
      text: 'Hello! Thanks for reaching out. The apartment is still available. Would you like to schedule a viewing?',
      isMe: true,
      time: '10:32 AM',
    ),
    _ChatMessage(
      text: 'Yes, I\'d love to! Are you free this Saturday around 2pm?',
      isMe: false,
      time: '10:35 AM',
    ),
    _ChatMessage(
      text: 'Saturday at 2pm works perfectly. I\'ll send you the address. Do you have any questions about the property in the meantime?',
      isMe: true,
      time: '10:38 AM',
    ),
    _ChatMessage(
      text: 'Great, thank you! One question — is parking included?',
      isMe: false,
      time: '10:40 AM',
    ),
    _ChatMessage(
      text: 'Yes, there\'s one dedicated parking spot included in the rent. There\'s also street parking available for guests.',
      isMe: true,
      time: '10:42 AM',
    ),
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(text: text, isMe: true, time: 'Just now'));
      _messageController.clear();
    });
    Future.delayed(const Duration(milliseconds: 80), _scrollToBottom);
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final name     = widget.conversation.name     as String;
    final property = widget.conversation.property as String;
    final avatar   = widget.conversation.avatar   as String;

    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context, name, property, avatar),
            _buildPropertyBanner(property),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) {
                  final msg = _messages[i];
                  final showDate = i == 0 ||
                      _messages[i - 1].isMe != msg.isMe;
                  return _MessageBubble(
                      message: msg, showAvatar: showDate && !msg.isMe);
                },
              ),
            ),
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  // ── App bar ───────────────────────────────────────────────────────────────

  Widget _buildAppBar(
      BuildContext context, String name, String property, String avatar) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 10, 12, 10),
      decoration: BoxDecoration(
        color: _C.bgCard,
        border: Border(bottom: BorderSide(color: _C.divider, width: 1)),
      ),
      child: Row(
        children: [
          // Back
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: _C.inputBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _C.inputBorder, width: 1),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  size: 17, color: _C.text),
            ),
          ),
          const SizedBox(width: 10),

          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _C.primary,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: Text(
                avatar.length > 1 ? avatar.substring(0, 2) : avatar,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Name + online
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: _C.text,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2E7D52),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Online',
                      style: TextStyle(fontSize: 11, color: Color(0xFF2E7D52)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Actions
          _AppBarAction(
              icon: Icons.phone_outlined, onTap: () {}),
          const SizedBox(width: 6),
          _AppBarAction(
              icon: Icons.more_horiz_rounded, onTap: () {}),
        ],
      ),
    );
  }

  // ── Property banner ───────────────────────────────────────────────────────

  Widget _buildPropertyBanner(String property) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: _C.primaryLo,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _C.primary.withOpacity(0.18), width: 1),
      ),
      child: Row(
        children: [
          const Icon(Icons.apartment_rounded, size: 16, color: _C.primary),
          const SizedBox(width: 8),
          const Text(
            'Inquiry about: ',
            style: TextStyle(fontSize: 12, color: _C.textSub),
          ),
          Expanded(
            child: Text(
              property,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: _C.primary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'View',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _C.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Input bar ─────────────────────────────────────────────────────────────

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
      decoration: BoxDecoration(
        color: _C.bgCard,
        border: Border(top: BorderSide(color: _C.divider, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Attach
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _C.inputBg,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: _C.inputBorder, width: 1),
                  ),
                  child: const Icon(Icons.attach_file_rounded,
                      size: 20, color: _C.textSub),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Text input
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 42, maxHeight: 120),
                decoration: BoxDecoration(
                  color: _C.inputBg,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _C.inputBorder, width: 1),
                ),
                child: TextField(
                  controller: _messageController,
                  focusNode: _focusNode,
                  maxLines: null,
                  style: const TextStyle(fontSize: 14, color: _C.text),
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle:
                    TextStyle(fontSize: 14, color: _C.textLight),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 14, vertical: 11),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Send
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: GestureDetector(
                onTap: _sendMessage,
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: _C.primary,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        color: _C.primary.withOpacity(0.30),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.send_rounded,
                      size: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── App bar icon button ───────────────────────────────────────────────────────

class _AppBarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _AppBarAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: _C.inputBg,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: _C.inputBorder, width: 1),
        ),
        child: Icon(icon, size: 18, color: _C.textSub),
      ),
    );
  }
}

// ── Data model ───────────────────────────────────────────────────────────────

class _ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  const _ChatMessage(
      {required this.text, required this.isMe, required this.time});
}

// ── Message bubble ────────────────────────────────────────────────────────────

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;
  final bool showAvatar;

  const _MessageBubble(
      {required this.message, this.showAvatar = false});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Padding(
      padding: EdgeInsets.only(
        top: 3,
        bottom: 3,
        left: isMe ? 60 : 0,
        right: isMe ? 0 : 60,
      ),
      child: Row(
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Received avatar dot
          if (!isMe)
            Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(right: 6, bottom: 2),
              decoration: BoxDecoration(
                color: _C.primary,
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Center(
                child: Icon(Icons.person_rounded,
                    size: 16, color: Colors.white),
              ),
            ),

          // Bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? _C.bubbleMe : _C.bubbleThem,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 16),
                ),
                border: isMe
                    ? null
                    : Border.all(color: _C.bubbleThemBdr, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isMe ? 0.10 : 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: isMe ? Colors.white : _C.text,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 10,
                        color: isMe
                            ? Colors.white.withOpacity(0.65)
                            : _C.textLight,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}