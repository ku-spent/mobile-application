import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';

class PaginationOption extends QueryPagination {
  PaginationOption(int from, int size) : super(page: ((from + size) / size).floor() - 1, limit: from + size);
}
