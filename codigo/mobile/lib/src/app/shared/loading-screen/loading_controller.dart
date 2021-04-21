import 'package:mobx/mobx.dart';

part 'loading_controller.g.dart';

class LoadingController = _LoadingController with _$LoadingController;

abstract class _LoadingController with Store {
  @observable
  bool isLoading = false;

  @observable
  bool skeletonLoading = false;

  @action
  void startLoading() {
    print('startLoading');
    Future.delayed(Duration(microseconds: 50), () {
      this.isLoading = true;
    });
  }

  @action
  void stopLoading() {
    print('stopLoading');
    Future.delayed(Duration(microseconds: 50), () {
      this.isLoading = false;
    });
  }

  @action
  void startSkeletonLoading() {
    print('startSkeletonLoading');
    Future.delayed(Duration(microseconds: 50), () {
      this.skeletonLoading = true;
    });
  }

  @action
  void stopSkeletonLoading() {
    print('stopSkeletonLoading');
    Future.delayed(Duration(microseconds: 50), () {
      this.skeletonLoading = false;
    });
  }
}
