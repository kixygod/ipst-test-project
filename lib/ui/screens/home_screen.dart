import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipst_test_project/blocs/camera/camera_bloc.dart';
import 'package:ipst_test_project/blocs/camera/camera_event.dart';
import 'package:ipst_test_project/blocs/camera/camera_state.dart';
import 'package:ipst_test_project/routes/app_router.gr.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ipst_test_project/blocs/locale/locale_bloc.dart';
import 'package:ipst_test_project/ui/localization/app_localizations.dart';
import 'package:ipst_test_project/ui/widgets/camera_tile.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    context.read<CameraBloc>().add(CameraFetched());
  }

  void _toggleLanguage() {
    final currentLocale = context.read<LocaleBloc>().state.locale;

    final newLocale = currentLocale.languageCode == 'ru' ? const Locale('en', 'US') : const Locale('ru', 'RU');

    context.read<LocaleBloc>().add(LocaleChanged(newLocale));
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    final crossAxisCount = isPortrait ? 2 : 5;
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.homeScreenTitle),
        actions: [
          IconButton(
            onPressed: _toggleLanguage,
            icon: const Icon(Icons.language),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
            icon: Icon(isEditing ? Icons.check : Icons.edit),
          ),
          IconButton(
            onPressed: () {
              context.pushRoute(const CameraForm());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          if (state is CameraLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CameraError) {
            return Center(child: Text(state.message));
          }
          if (state is CameraLoaded) {
            final cameras = state.cameras;

            if (cameras.isEmpty) {
              return Center(child: Text(localizations.homeScreenNoObjects));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: AlignedGridView.count(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                itemCount: cameras.length,
                itemBuilder: (context, index) {
                  return CameraTile(
                    camera: cameras[index],
                    index: index,
                    isEditing: isEditing,
                  );
                },
              ),
            );
          }
          return Center(child: Text(localizations.noData));
        },
      ),
    );
  }
}
