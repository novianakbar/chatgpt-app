import 'package:ChatGPT/constants/constants.dart';
import 'package:ChatGPT/models/models_model.dart';
import 'package:ChatGPT/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ChatGPT/services/api_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import "package:ChatGPT/providers/models_provider.dart";
import 'package:provider/provider.dart';

class ModelsDropDownWidget extends StatefulWidget {
  const ModelsDropDownWidget({super.key});

  @override
  State<ModelsDropDownWidget> createState() => _ModelsDropDownWidgetState();
}

class _ModelsDropDownWidgetState extends State<ModelsDropDownWidget> {
  String? currentModel;

  bool isFirstLoading = true;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);

    currentModel = modelsProvider.getCurrentModel;
    return FutureBuilder(
      future: modelsProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final models = snapshot.data as List<ModelsModel>;
          return FittedBox(
            child: DropdownButton(
              dropdownColor: scaffoldBackgroundColor,
              iconEnabledColor: Colors.white,
              items: models.map((model) {
                return DropdownMenuItem(
                  value: model.id,
                  child: TextWidget(
                    label: model.id,
                    fontSize: 16,
                  ),
                );
              }).toList(),
              value: currentModel,
              onChanged: (value) {
                setState(() {
                  currentModel = value.toString();
                });

                modelsProvider.setCurrentModel(
                  value.toString(),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: TextWidget(label: snapshot.error.toString()),
          );
        } else {
          return const FittedBox(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 30,
            ),
          );
        }
      },
    );
  }
}


// DropdownButton(
//       dropdownColor: scaffoldBackgroundColor,
//       iconEnabledColor: Colors.white,
//       value: currentModel,
//       items: getDropDownMenuItems,
//       onChanged: (value) {
//         setState(() {
//           currentModel = value.toString();
//         });
//       },
//     );