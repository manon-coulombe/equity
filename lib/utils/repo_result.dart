import 'package:equatable/equatable.dart';

abstract class RepoResult<T> extends Equatable {
  T _getData();
  String _getError();
  
  RepoResult<T> onSuccess(void Function(T data) onSuccessFunction) {
    if (this is RepoSuccess) {
      onSuccessFunction.call(_getData());
    }
    return this;
  }

  RepoResult<T> onError(void Function(String error) onErrorFunction) {
    if (this is RepoError) {
      onErrorFunction.call(_getError());
    }
    return this;
  }
}

class RepoSuccess<T> extends RepoResult<T> {
  final T _data;
  
  RepoSuccess(this._data);

  @override
  T _getData() => _data;

  @override
  String _getError() {
    throw UnsupportedError('Ne devrait pas arriver');
  }

  @override
  List<Object?> get props => [_data];
}

class RepoError<T> extends RepoResult<T> {
  final String _error;

  RepoError(this._error);

  @override
  T _getData() {
    throw UnsupportedError('Ne devrait pas arriver');
  }

  @override
  String _getError() => _error;

  @override
  List<Object?> get props => [_error];
}