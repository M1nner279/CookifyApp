abstract class OtpState {
  final int remainingSeconds;
  final int initialCooldownSeconds;
  
  const OtpState({
    required this.remainingSeconds,
    required this.initialCooldownSeconds,
  });
  
  bool get isCooldownActive => remainingSeconds > 0;
  String get formattedTime {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    if (minutes > 0) {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
    return '$seconds сек';
  }
}

class OtpInitial extends OtpState {
  const OtpInitial({
    int remainingSeconds = 60,
    int initialCooldownSeconds = 60,
  }) : super(
    remainingSeconds: remainingSeconds,
    initialCooldownSeconds: initialCooldownSeconds,
  );
}

class OtpReady extends OtpState {
  const OtpReady({
    required int remainingSeconds,
    required int initialCooldownSeconds,
  }) : super(
    remainingSeconds: remainingSeconds,
    initialCooldownSeconds: initialCooldownSeconds,
  );
}

class OtpCooldown extends OtpState {
  const OtpCooldown({
    required int remainingSeconds,
    required int initialCooldownSeconds,
  }) : super(
    remainingSeconds: remainingSeconds,
    initialCooldownSeconds: initialCooldownSeconds,
  );
}

class OtpLoading extends OtpState {
  const OtpLoading(int remainingSeconds) : super(
    remainingSeconds: remainingSeconds,
    initialCooldownSeconds: 60,
  );
}

class OtpError extends OtpState {
  final String error;
  
  const OtpError({
    required this.error,
    required int remainingSeconds,
    required int initialCooldownSeconds,
  }) : super(
    remainingSeconds: remainingSeconds,
    initialCooldownSeconds: initialCooldownSeconds,
  );
}

class OtpSuccess extends OtpState {
  final String message;
  
  const OtpSuccess({
    required this.message,
    required int remainingSeconds,
    required int initialCooldownSeconds,
  }) : super(
    remainingSeconds: remainingSeconds,
    initialCooldownSeconds: initialCooldownSeconds,
  );
}
