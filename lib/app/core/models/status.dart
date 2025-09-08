// Core status model for handling async operations
abstract class Status<T> {
  const Status();

  bool get isInitial => this is Initial<T>;
  bool get isLoading => this is Loading<T>;
  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  Status<T> toLoading() => Loading<T>();
  Status<T> toSuccess(T data) => Success<T>(data);
  Status<T> toFailure(String message, [Exception? exception]) => Failure<T>(message, exception);
}

class Initial<T> extends Status<T> {
  const Initial();
}

class Loading<T> extends Status<T> {
  const Loading();
}

class Success<T> extends Status<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Status<T> {
  final String message;
  final Exception? exception;
  
  const Failure(this.message, [this.exception]);
}

// Void status for operations that don't return data
typedef VoidStatus = Status<void>;
