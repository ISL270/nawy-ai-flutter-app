import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class EventTransformers {
  static EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
  }

  static EventTransformer<T> throttle<T>(Duration duration) {
    return (events, mapper) => events.throttleTime(duration).asyncExpand(mapper);
  }

  static EventTransformer<T> throttleDroppable<T>(Duration duration) {
    return (events, mapper) => events.throttleTime(duration).asyncExpand(mapper);
  }
}
