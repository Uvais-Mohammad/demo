// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AudioDuration extends Equatable {
  final String id;
  final Duration duration;

  AudioDuration({
    required this.id,
    required this.duration,
  });

  @override
  List<Object?> get props => [id];

  AudioDuration copyWith({
    Duration? duration,
  }) {
    return AudioDuration(
      id: id,
      duration: duration ?? this.duration,
    );
  }
}
