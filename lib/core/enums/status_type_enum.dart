enum StatusType {
  idle,
  loading,
  loadingMore,
  success,
  failure,
  finished,
  empty;

  bool get isIdle => this == StatusType.idle;
  bool get isLoading => this == StatusType.loading;
  bool get isLoadingMore => this == StatusType.loadingMore;
  bool get isLoadingOrLoadingMore => isLoading || isLoadingMore;
  bool get isLoadingActiveOrFinished => isLoading || isLoadingMore || isFinished;
  bool get isLoadingActiveOrEmpty => isLoading || isLoadingMore || isEmpty;
  bool get isSuccess => this == StatusType.success;
  bool get isFinished => this == StatusType.finished;
  bool get isSuccessOrFinished => isSuccess || isFinished;
  bool get isSuccessOrFinishedOrEmpty => isSuccessOrFinished || isEmpty;
  bool get isFailure => this == StatusType.failure;
  bool get isEmpty => this == StatusType.empty;
}
