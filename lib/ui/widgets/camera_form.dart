import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:ipst_test_project/blocs/camera/camera_bloc.dart';
import 'package:ipst_test_project/blocs/camera/camera_event.dart';
import 'package:ipst_test_project/data/models/camera.dart';
import 'package:ipst_test_project/ui/localization/app_localizations.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class CameraForm extends StatefulWidget {
  @override
  _CameraFormState createState() => _CameraFormState();
}

class _CameraFormState extends State<CameraForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(localizations.cameraFormAdd)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'cameraName',
                decoration: InputDecoration(labelText: localizations.cameraFormName),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: localizations.cameraFormNameError),
                ]),
              ),
              FormBuilderTextField(
                name: 'cameraUrl',
                decoration: InputDecoration(labelText: localizations.cameraFormUrl),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(errorText: localizations.cameraFormUrlError),
                  FormBuilderValidators.url(errorText: localizations.cameraFormUrlValidationError),
                ]),
              ),
              FormBuilderCheckbox(
                name: 'cameraEnabled',
                initialValue: false,
                title: Text(localizations.cameraFormEnabled),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final cameraName = _formKey.currentState?.fields['cameraName']?.value;
                    final cameraUrl = _formKey.currentState?.fields['cameraUrl']?.value;
                    final cameraEnabled = _formKey.currentState?.fields['cameraEnabled']?.value ?? false;
                    final DateTime now = DateTime.now();
                    final startTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

                    final String cameraId = const Uuid().v4();

                    final camera = Camera(id: cameraId, name: cameraName, url: cameraUrl, isActive: cameraEnabled, date: startTime);

                    context.read<CameraBloc>().add(CameraAdded(camera));
                    Navigator.pop(context);
                  }
                },
                child: Text(localizations.cameraFormAdd),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
