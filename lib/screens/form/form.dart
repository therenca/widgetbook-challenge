import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook_challenge/api/widgetbook_api.dart' as api;
import 'package:widgetbook_challenge/models/form/m_form.dart' as m_form;
import 'package:widgetbook_challenge/screens/form/helpers/input.dart';
import 'package:widgetbook_challenge/screens/form/helpers/status_bar.dart';

/// parent widget for building text input and
/// a call to action button
class CustomForm extends StatefulWidget {
	/// Creates a new instance of [CustomForm].
	const CustomForm({ Key? key }) : super(key: key);

	@override
	State<CustomForm> createState() => _FormState();
}

class _FormState extends State<CustomForm> {
	final FocusNode focusNode = FocusNode();
	GlobalKey<InputState> inputKey = GlobalKey();
	final TextEditingController controller = TextEditingController();

	@override
	void dispose(){
		focusNode.dispose();
		controller.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Column(
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					const StatusBar(color: Colors.purple,),
					Container(
						padding: const EdgeInsets.only(left: 20, top: 30),
						child: Text(
							AppLocalizations.of(context)!.form,
							style: const TextStyle(
								fontSize: 20,
								color: Colors.grey,
								fontWeight: FontWeight.bold,
							),
						),
					),
					const SizedBox(height: 20,),
					Consumer<m_form.Form>(
						builder: (context, model, child){
							return AnimatedOpacity(
								opacity: model.result != null ? 1 : 0,
								duration: const Duration(milliseconds: 500),
								child: Container(
									padding: const EdgeInsets.only(left: 20, top: 30),
									child: Text(
										model.result ?? '',
										style: const TextStyle(
											fontSize: 17,
											color: Colors.black,
											fontWeight: FontWeight.bold,
										),
									),
								),
							);
						},
					),
					Expanded(
						child: LayoutBuilder(
							builder: (BuildContext context, BoxConstraints constraints){
								return SizedBox(
									width: constraints.maxWidth,
									height: constraints.maxHeight,
									child: Center(
										child: Column(
											mainAxisSize: MainAxisSize.min,
											children: [
												Input(
													key: inputKey,
													controller: controller,
													focusNode: focusNode,
													label: AppLocalizations.of(context)!.title,
													hint: AppLocalizations.of(context)!.hint,
												),
											],
										),
									),
								);
							},
						),
					),
					Material(
						elevation: 5,
						child: Row(
							children: [
								const Spacer(),
								Consumer<m_form.Form>(
									builder: (context, model, child){
										return model.isLoading ? Container(
											width: 20,
											height: 20,
											margin: const EdgeInsets.all(10),
											child: const CircularProgressIndicator(
												valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
											),
										) : Expanded(
											flex: 2,
											child: ElevatedButton(
												style: ElevatedButton.styleFrom(
													primary: Colors.purple,
													shape: const StadiumBorder(),
												),
												child: Text(
													// 'send',
													AppLocalizations.of(context)!.send,
													style: const TextStyle(
														color: Colors.white,
													),
												),
												onPressed: () async {
													if(controller.text.isNotEmpty){
														if(inputKey.currentState!.error != null){
															inputKey.currentState!.updateError(null);
														}
														inputKey.currentState!.removeFocus();
														model.isLoading = true;
														try {
															model.result = await api.WidgetbookApi()
																.welcomeToWidgetbook(message: controller.text);
														} on api.UnexpectedException {
															inputKey.currentState!.updateError(
																AppLocalizations.of(context)!.error,
															);
														}
														model.isLoading = false;
														controller.text = '';
													} else {
														/// no text input from controller
														/// enforce requirement
														inputKey.currentState!.updateError(
															AppLocalizations.of(context)!.enforce,
														);
													}
												},
											),
										);
									},
								),
								const Spacer(),
							],
						),
					)
				],
			),
		);
	}
}
