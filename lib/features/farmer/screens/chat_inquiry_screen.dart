import 'package:flutter/material.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_app_bar.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_text_field.dart';
import 'package:poultry_supply_chain_app/common/widgets/custom_button.dart';

class ChatInquiryScreen extends StatefulWidget {
  const ChatInquiryScreen({super.key});

  @override
  State<ChatInquiryScreen> createState() => _ChatInquiryScreenState();
}

class _ChatInquiryScreenState extends State<ChatInquiryScreen> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    // Process sending message (mock for now)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message sent!')),
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chat/Inquiry'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                // Mock chat messages
                children: [
                  ListTile(title: Text('Owner: How much stock do you have?')),
                  ListTile(title: Text('You: I have 150 kg available.')),
                ],
              ),
            ),
            CustomTextField(
              controller: _messageController,
              labelText: 'Type your message...',
              hintText: 'Enter your message',
            ),
            const SizedBox(height: 10),
            CustomButton(
              icon: Icons.chat,
              text: 'Send',
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}