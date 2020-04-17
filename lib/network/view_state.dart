class ViewState<T> {
  Status status;

  T data;

  String message;

  Type type;

  ViewState.loading() : status = Status.LOADING;

  ViewState.completed(this.data) : status = Status.COMPLETED;

  ViewState.error(this.message, this.type) : status = Status.ERROR;

  ViewState();

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum Status { LOADING, COMPLETED, ERROR }

enum Type { CONNECTION, OTHER }
