abstract class BaseView<T> {
  void onError(String key);

  void showError(String errorMessage);

  void showProgress();

  void hideProgress();
}
