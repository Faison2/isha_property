import 'package:flutter/material.dart';

class ChatDetailScreen extends StatefulWidget {
  final dynamic conversation;

  const ChatDetailScreen({super.key, required this.conversation});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  static const Color _primary = Color(0xFFC87941);
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();

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
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.conversation.name;
    final property = widget.conversation.property;
    final avatar = widget.conversation.avatar;

    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      appBar: _buildAppBar(name, property, avatar),
      body: Column(
        children: [
          _buildPropertyBanner(property),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _MessageBubble(message: _messages[i]),
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(String name, String property, String avatar) {
    return AppBar(
      backgroundColor: const Color(0xFF1A0A00),
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 0.5,
            ),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: Colors.white,
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                avatar,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFC87941),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                'Online',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.green.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.phone_outlined,
              size: 18,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          onPressed: () {},
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.more_horiz_rounded,
              size: 18,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildPropertyBanner(String property) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _primary.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.apartment_rounded,
            size: 18,
            color: Color(0xFFC87941),
          ),
          const SizedBox(width: 8),
          Text(
            'Inquiry about: ',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.55),
            ),
          ),
          Text(
            property,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFFC87941),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0A00),
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.08),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.attach_file_rounded,
                  size: 20,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 0.5,
                  ),
                ),
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                if (_messageController.text.trim().isNotEmpty) {
                  setState(() {
                    _messages.add(_ChatMessage(
                      text: _messageController.text.trim(),
                      isMe: true,
                      time: 'Just now',
                    ));
                    _messageController.clear();
                  });
                  Future.delayed(
                    const Duration(milliseconds: 100),
                    () => _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    ),
                  );
                }
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: _primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: _primary.withOpacity(0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.send_rounded,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  const _ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMe) const SizedBox(width: 32),
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: message.isMe
                    ? const Color(0xFFC87941)
                    : Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(
                    message.isMe ? 16 : 4,
                  ),
                  bottomRight: Radius.circular(
                    message.isMe ? 4 : 16,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: message.isMe
                          ? Colors.white
                          : Colors.white.withOpacity(0.9),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.time,
                    style: TextStyle(
                      fontSize: 10,
                      color: message.isMe
                          ? Colors.white.withOpacity(0.6)
                          : Colors.white.withOpacity(0.35),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isMe) const SizedBox(width: 32),
        ],
      ),
    );
  }
}
