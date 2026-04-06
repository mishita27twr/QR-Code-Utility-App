import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'history_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryItem> _history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  // This ensures that every time you click the History tab, the list refreshes
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadHistory(); 
  }

  Future<void> _loadHistory() async {
    final data = await HistoryService.getHistory();
    // Sort by newest first just in case
    data.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    if (mounted) {
      setState(() => _history = data);
    }
  }

  Future<void> _delete(int index) async {
    // Show a confirmation dialog (Optional but professional)
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item?'),
        content: const Text('This will remove this item from your history.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    ) ?? false;

    if (confirm) {
      await HistoryService.deleteItem(index);
      _loadHistory(); // Refresh the list
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved History'),
        centerTitle: true,
        // Manual refresh button in case the tab-switch didn't trigger
        actions: [
          IconButton(
            onPressed: _loadHistory,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: _history.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history_rounded, size: 64, color: colorScheme.outlineVariant),
                  const SizedBox(height: 16),
                  const Text('Your history folder is empty.', 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _history.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                final item = _history[index];
                return Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerLow,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: colorScheme.outlineVariant.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(Icons.qr_code_2_rounded, color: colorScheme.onPrimaryContainer),
                    ),
                    title: Text(
                      item.content, 
                      maxLines: 1, 
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      _formatDateTime(item.timestamp),
                      style: TextStyle(fontSize: 12, color: colorScheme.onSurfaceVariant),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                      onPressed: () => _delete(index),
                    ),
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: item.content));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('Copied to clipboard!'),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  String _formatDateTime(DateTime dt) {
    // Basic formatting: "Apr 06, 20:05"
    return "${dt.day}/${dt.month}/${dt.year}  ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}";
  }
}