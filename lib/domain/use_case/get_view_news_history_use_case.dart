import 'package:injectable/injectable.dart';
import 'package:spent/data/repository/authentication_repository.dart';
import 'package:spent/data/repository/news_repository.dart';
import 'package:spent/data/repository/user_repository.dart';
import 'package:spent/domain/model/History.dart';
import 'package:spent/domain/model/User.dart';
import 'package:spent/domain/model/news.dart';

@injectable
class GetViewNewsHistoryUseCase {
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  final NewsRepository _newsRepository;

  const GetViewNewsHistoryUseCase(this._authenticationRepository, this._userRepository, this._newsRepository);

  Future<List<News>> call() async {
    User user = await _authenticationRepository.getCurrentUser();
    List<History> histories = await _userRepository.getNewsHistory(user);
    histories.forEach((elem) {
      final id = elem.id;
      final u = elem.updatedAt.add(Duration(hours: 7));
      print('$id $u');
    });
    List<News> news = [];
    histories.forEach((history) async {
      final newsId = history.newId;
      print('get news $newsId');
      News historyNews = await _newsRepository.getNewsById(history.newId);
      if (historyNews != null) news.add(historyNews);
    });
    return news;
  }
}
