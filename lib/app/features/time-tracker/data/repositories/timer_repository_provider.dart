import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_app/app/features/time-tracker/data/repositories/time_tracker_repository_impl.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/entities/activity.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/repositories/time_tracker_repository.dart';
import 'package:time_tracker_app/app/features/time-tracker/domain/repositories/timer_repository.dart';
import 'package:time_tracker_app/core/constants/constants.dart';

class Ticker {
  Stream<int> tick({required int ticks}) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}

class TimerRepositoryProvider extends ChangeNotifier
    implements TimerRepository {
  Activity activity;
  Duration _spentTime;
  TimerState timerState = TimerState.intitial;
  Ticker _ticker = Ticker();
  StreamSubscription<int>? _tickerSubscription;

  TimeTrackerRepository repository = TimeTrackerRepositoryImpl();

  TimerRepositoryProvider({
    required this.activity,
  }) : _spentTime = activity.spentTime {
    if (_spentTime > Duration() && _spentTime < activity.totalTime) {
      timerState = TimerState.paused;
    } else if (_spentTime == activity.totalTime) {
      timerState = TimerState.complete;
    }
  }

  Duration get spentTime => _spentTime;

  Duration get remainingTime => activity.totalTime - _spentTime;

  @override
  void started() {
    if (timerState == TimerState.intitial) {
      _tickerSubscription?.cancel();
      _tickerSubscription =
          _ticker.tick(ticks: activity.totalTime.inSeconds).listen((event) {
        ticked();
      });
    }
    notifyListeners();
  }

  @override
  void ticked() {
    Duration _remainingTime = activity.totalTime - _spentTime;
    if (_remainingTime.inSeconds > 1) {
      timerState = TimerState.playing;
      _spentTime = _spentTime + Duration(seconds: 1);
      activity.spentTime = _spentTime;
    } else {
      timerState = TimerState.complete;
      _spentTime = activity.totalTime;
      activity.spentTime = _spentTime;
    }
    notifyListeners();
  }

  @override
  void paused() {
    if (timerState == TimerState.playing) {
      _tickerSubscription?.pause();
      timerState = TimerState.paused;
    }
    activity.spentTime = _spentTime;
    notifyListeners();
  }

  @override
  void reset() {
    _tickerSubscription?.cancel();
    _spentTime = Duration();
    timerState = TimerState.intitial;
    activity.spentTime = _spentTime;
    notifyListeners();
  }

  @override
  void resumed() {
    if (timerState == TimerState.paused) {
      if (_tickerSubscription == null) {
        _tickerSubscription =
            _ticker.tick(ticks: remainingTime.inSeconds).listen((event) {
          ticked();
        });
      } else {
        _tickerSubscription?.resume();
      }
      timerState = TimerState.playing;
    }
  }

  @override
  void close() {
    _tickerSubscription?.cancel();
  }
}
