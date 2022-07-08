import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook_challenge/models/form/m_form.dart' as m_form;
import 'package:widgetbook_challenge/screens/form/form.dart';

/// The app.
class App extends StatelessWidget {
  /// Creates a new instance of [App].
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<m_form.Form>(
          create: (BuildContext context) => m_form.Form(),
        ),
      ],
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: [Locale('en', 'US'), Locale('de', 'DE')],
        home: CustomForm(),
      ),
    );
  }
}
