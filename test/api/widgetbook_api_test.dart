import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart';

class MockWidgetbookApiSuccess extends Mock implements WidgetbookApi {
	@override
	Future<String> welcomeToWidgetbook({
    required String message,
  }) async {
			return 'Hello $message';
  }
}

class MockWidgetbookApiFailure extends Mock implements WidgetbookApi {

	@override
	Future<String> welcomeToWidgetbook({
    required String message,
  }) async {
			return throw UnexpectedException();
  }
}

void main(){
	test('welcome to widgetbook when called and is successful', () async {
		final mock = MockWidgetbookApiSuccess();
		final result = await mock.welcomeToWidgetbook(message: 'john');
		expect(result, 'Hello john');
	});
}
