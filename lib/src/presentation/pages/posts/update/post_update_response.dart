import 'package:flutter/widgets.dart';
import 'package:paw_rescue/src/domain/utils/resource.dart';
import 'package:paw_rescue/src/presentation/pages/posts/update/posts_update_event.dart';
import 'package:paw_rescue/src/presentation/utils/show_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostUpdateResponse {
  BuildContext context;
  PostsUpdateEvent vm;

  PostUpdateResponse(this.context, this.vm) {
    if (vm.response is Loading) {
      buildShowDialog(context);
    } else if (vm.response is Error) {
      final data = vm.response as Error;
      Navigator.pop(context);
      Fluttertoast.showToast(msg: data.error, toastLength: Toast.LENGTH_LONG);
      vm.resetResponse();
    } else if (vm.response is Success) {
      final success = vm.response as Success<String>;
      Navigator.pop(context);
      Fluttertoast.showToast(msg: success.data, toastLength: Toast.LENGTH_LONG);
      vm.resetResponse();
    }
  }
}
