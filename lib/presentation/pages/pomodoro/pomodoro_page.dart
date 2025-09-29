// presentation/pages/pomodoro/pomodoro_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PomodoroPage extends StatefulWidget {
  const PomodoroPage({Key? key}) : super(key: key);

  @override
  State<PomodoroPage> createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(minutes: 25),
      vsync: this,
    );
    _animation = Tween(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTimerCircle(),
            const SizedBox(height: 32),
            _buildControlButtons(),
            const SizedBox(height: 16),
            _buildSessionInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerCircle() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 300,
          height: 300,
          child: CircularProgressIndicator(
            value: _animation.value,
            strokeWidth: 8,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getTimerColor(),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final minutes = (_controller.duration!.inMinutes * _animation.value).floor();
            final seconds = (_controller.duration!.inSeconds * _animation.value).floor() % 60;
            return Text(
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!_controller.isAnimating)
          ElevatedButton(
            onPressed: _startTimer,
            child: const Text('Start'),
          )
        else
          ElevatedButton(
            onPressed: _pauseTimer,
            child: const Text('Pause'),
          ),
        const SizedBox(width: 16),
        ElevatedButton(
          onPressed: _resetTimer,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          child: const Text('Reset'),
        ),
      ],
    );
  }

  Widget _buildSessionInfo() {
    return const Column(
      children: [
        Text('Session: 1/4'),
        SizedBox(height: 8),
        Text('Focus Time: 25 minutes'),
      ],
    );
  }

  Color _getTimerColor() {
    if (_animation.value > 0.5) return Colors.green;
    if (_animation.value > 0.25) return Colors.orange;
    return Colors.red;
  }

  void _startTimer() {
    _controller.reverse(from: _controller.value);
  }

  void _pauseTimer() {
    _controller.stop();
  }

  void _resetTimer() {
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}