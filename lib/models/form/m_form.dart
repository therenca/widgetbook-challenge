import 'package:flutter/widgets.dart';

/// model
class Form extends ChangeNotifier {
	String? _result;
	bool _isLoading = false;

	/// value from Api
	String? get result => _result;
	/// while sending results to server
	bool get isLoading => _isLoading;

	set isLoading(bool value){
		_isLoading = value;
		notifyListeners();
	}

	set result(String? value){
		_result = value;
		notifyListeners();
	}
}
