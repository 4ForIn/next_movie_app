class FailureHandling {
  FailureHandling({this.code = -1, this.message = 'something went wrong'});
  final int code;
  final String message;

  @override
  String toString() => 'Failure message: $message. ---- Failure code: $code';
}
