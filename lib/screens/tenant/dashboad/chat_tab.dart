import 'package:flutter/material.dart';

class _C {
  static const bg          = Color(0xFFFAF5F0);
  static const bgCard      = Color(0xFFFFFFFF);
  static const primary     = Color(0xFF7B6FD0);
  static const primaryLo   = Color(0x1A7B6FD0);
  static const text        = Color(0xFF1A1A1A);
  static const textSub     = Color(0xFF888888);
  static const textLight   = Color(0xFFAAAAAA);
  static const divider     = Color(0xFFF0EBE6);
  static const inputBorder = Color(0xFFE4D8CE);
  static const unreadBg    = Color(0xFFF3F0FF);
}

class TenantChatTab extends StatefulWidget {
  const TenantChatTab({super.key});

  @override
  State<TenantChatTab> createState() => _TenantChatTabState();
}

class _TenantChatTabState extends State<TenantChatTab> {
  final _searchController = TextEditingController();
  String _query = '';

  final _conversations = [
    _Conversation(name: 'John Doe', lastMessage: 'Saturday at 2pm works perfectly! I\'ll send you the address.', time: '2m ago', avatar: 'JD', isUnread: true, property: 'Sunset Apartment'),
    _Conversation(name: 'Sarah Williams', lastMessage: 'The apartment is still available. Would you like to schedule a viewing?', time: '1h ago', avatar: 'SW', isUnread: true, property: 'Downtown Studio'),
    _Conversation(name: 'Mike Chen', lastMessage: 'Yes, parking is included. Let me know if you have other questions.', time: '3h ago', avatar: 'MC', isUnread: false, property: 'Garden House'),
    _Conversation(name: 'Emily Davis', lastMessage: 'Thank you for your interest! The condo is available for move-in next month.', time: '1d ago', avatar: 'ED', isUnread: false, property: 'Lakeside Condo'),
  ];

  List<_Conversation> get _filtered => _query.isEmpty
      ? _conversations
      : _conversations.where((c) =>
          c.name.toLowerCase().contains(_query.toLowerCase()) ||
          c.property.toLowerCase().contains(_query.toLowerCase())).toList();

  int get _unreadCount => _conversations.where((c) => c.isUnread).length;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;

    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Messages', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: _C.text)),
                        const SizedBox(height: 2),
                        Text(
                          _unreadCount > 0 ? '$_unreadCount unread conversation${_unreadCount > 1 ? 's' : ''}' : 'All caught up',
                          style: const TextStyle(fontSize: 13, color: _C.textSub),
                        ),
                      ],
                    ),
                  ),
                  if (_unreadCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: _C.primaryLo, borderRadius: BorderRadius.circular(20)),
                      child: Text('$_unreadCount new', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _C.primary)),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: _C.bgCard,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: _C.inputBorder, width: 1),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _query = v),
                  style: const TextStyle(fontSize: 14, color: _C.text),
                  decoration: const InputDecoration(
                    hintText: 'Search conversations...',
                    hintStyle: TextStyle(fontSize: 14, color: _C.textLight),
                    prefixIcon: Icon(Icons.search_rounded, size: 20, color: _C.textLight),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filtered.isEmpty
                  ? _buildEmptyState()
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 110),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => Divider(height: 1, color: _C.divider),
                      itemBuilder: (_, i) => _ConversationTile(
                        conversation: filtered[i],
                        onTap: () {},
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
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(color: _C.primaryLo, shape: BoxShape.circle),
            child: const Icon(Icons.chat_bubble_outline_rounded, size: 36, color: _C.primary),
          ),
          const SizedBox(height: 18),
          const Text('No messages yet', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: _C.text)),
          const SizedBox(height: 6),
          const Text('When landlords respond you\'ll see them here', style: TextStyle(fontSize: 13, color: _C.textSub)),
        ],
      ),
    );
  }
}

class _Conversation {
  final String name, lastMessage, time, avatar, property;
  bool isUnread;
  _Conversation({required this.name, required this.lastMessage, required this.time, required this.avatar, required this.isUnread, required this.property});
}

class _ConversationTile extends StatelessWidget {
  final _Conversation conversation;
  final VoidCallback onTap;
  const _ConversationTile({required this.conversation, required this.onTap});

  Color _avatarColor(String initials) {
    const palette = [Color(0xFF7B6FD0), Color(0xFF5B50C8), Color(0xFF9B8FEC), Color(0xFF6B8FAB), Color(0xFF8B6B4A), Color(0xFFB5622A)];
    return palette[initials.codeUnitAt(0) % palette.length];
  }

  @override
  Widget build(BuildContext context) {
    final unread = conversation.isUnread;
    final avatarColor = _avatarColor(conversation.avatar);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: unread ? _C.unreadBg : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 50, height: 50,
              decoration: BoxDecoration(color: avatarColor, borderRadius: BorderRadius.circular(16)),
              child: Center(child: Text(conversation.avatar, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white))),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(conversation.name, style: TextStyle(fontSize: 15, fontWeight: unread ? FontWeight.w700 : FontWeight.w600, color: _C.text))),
                      Text(conversation.time, style: TextStyle(fontSize: 11, color: unread ? _C.primary : _C.textLight, fontWeight: unread ? FontWeight.w600 : FontWeight.w400)),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      const Icon(Icons.apartment_rounded, size: 11, color: _C.primary),
                      const SizedBox(width: 3),
                      Text(conversation.property, style: const TextStyle(fontSize: 11, color: _C.primary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(child: Text(conversation.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 13, color: unread ? _C.text : _C.textSub, fontWeight: unread ? FontWeight.w500 : FontWeight.w400))),
                      if (unread)
                        Container(width: 8, height: 8, margin: const EdgeInsets.only(left: 8), decoration: const BoxDecoration(color: _C.primary, shape: BoxShape.circle)),
                    ],
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
