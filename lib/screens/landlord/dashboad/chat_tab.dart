import 'package:flutter/material.dart';
import 'chat_detail.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({super.key});

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  static const Color _primary = Color(0xFFC87941);

  final List<_Conversation> _conversations = [
    _Conversation(
      name: 'Sarah Johnson',
      lastMessage: 'Hi, is the apartment still available? I\'d love to schedule a viewing this weekend if possible.',
      time: '2m ago',
      avatar: 'S',
      isUnread: true,
      property: 'Sunset Apartment',
    ),
    _Conversation(
      name: 'Mike Chen',
      lastMessage: 'I\'d like to schedule a viewing for the downtown studio. Are you free on Thursday?',
      time: '1h ago',
      avatar: 'M',
      isUnread: false,
      property: 'Downtown Studio',
    ),
    _Conversation(
      name: 'Emily Davis',
      lastMessage: 'Thank you for the information! I\'ll think about it and get back to you.',
      time: '3h ago',
      avatar: 'E',
      isUnread: false,
      property: 'Garden House',
    ),
    _Conversation(
      name: 'James Wilson',
      lastMessage: 'Can you tell me more about the parking situation at Lakeside Condo?',
      time: '1d ago',
      avatar: 'J',
      isUnread: false,
      property: 'Lakeside Condo',
    ),
    _Conversation(
      name: 'Anna Martinez',
      lastMessage: 'Perfect, see you tomorrow at 2pm!',
      time: '2d ago',
      avatar: 'A',
      isUnread: false,
      property: 'Sunset Apartment',
    ),
    _Conversation(
      name: 'David Kim',
      lastMessage: 'I\'m interested in the studio. Is it still available?',
      time: '3d ago',
      avatar: 'D',
      isUnread: false,
      property: 'Downtown Studio',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0A00),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Messages',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 0.5,
                      ),
                    ),
                    child: Icon(
                      Icons.search_rounded,
                      size: 20,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _conversations.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _conversations.length,
                      itemBuilder: (_, i) => _ConversationTile(
                        conversation: _conversations[i],
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ChatDetailScreen(
                                conversation: _conversations[i],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline_rounded,
            size: 64,
            color: Colors.white.withOpacity(0.15),
          ),
          const SizedBox(height: 16),
          Text(
            'No messages yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white.withOpacity(0.55),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'When tenants reach out, you\'ll see their messages here',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

class _Conversation {
  final String name;
  final String lastMessage;
  final String time;
  final String avatar;
  final bool isUnread;
  final String property;

  const _Conversation({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatar,
    required this.isUnread,
    required this.property,
  });
}

class _ConversationTile extends StatelessWidget {
  final _Conversation conversation;
  final VoidCallback onTap;

  const _ConversationTile({
    required this.conversation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: conversation.isUnread
              ? const Color(0xFFC87941).withOpacity(0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: conversation.isUnread
                    ? const Color(0xFFC87941).withOpacity(0.2)
                    : Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  conversation.avatar,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: conversation.isUnread
                        ? const Color(0xFFC87941)
                        : Colors.white.withOpacity(0.6),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        conversation.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: conversation.isUnread
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        conversation.time,
                        style: TextStyle(
                          fontSize: 11,
                          color: conversation.isUnread
                              ? const Color(0xFFC87941)
                              : Colors.white.withOpacity(0.35),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    conversation.property,
                    style: TextStyle(
                      fontSize: 11,
                      color: const Color(0xFFC87941).withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    conversation.lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.55),
                      fontWeight:
                          conversation.isUnread ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
