// presentation/widgets/calendar/glass_event_card.dart
import 'package:flutter/material.dart';

class GlassEventCard extends StatefulWidget {
  final String title;
  final String? description;
  final Color color;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAllDay;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const GlassEventCard({
    Key? key,
    required this.title,
    this.description,
    required this.color,
    required this.startTime,
    required this.endTime,
    required this.isAllDay,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  State<GlassEventCard> createState() => _GlassEventCardState();
}

class _GlassEventCardState extends State<GlassEventCard> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: widget.onTap,
        onLongPress: widget.onLongPress,
        onTapDown: (_) => _animationController.forward(),
        onTapUp: (_) => _animationController.reverse(),
        onTapCancel: () => _animationController.reverse(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.color.withOpacity(0.15),
                      widget.color.withOpacity(0.05),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                    // Description
                    if (widget.description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          widget.description!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    
                    // Time
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        _formatTime(),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime() {
    if (widget.isAllDay) {
      return 'All day';
    }
    
    final startFormat = TimeOfDay.fromDateTime(widget.startTime);
    final endFormat = TimeOfDay.fromDateTime(widget.endTime);
    
    return '${startFormat.format(context)} - ${endFormat.format(context)}';
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}