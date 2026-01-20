import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:u_app_utils/u_app_utils.dart';

import '/app/data/database.dart';
import '/app/entities/entities.dart';
import '/app/pages/shared/page_view_model.dart';
import '/app/repositories/app_repository.dart';
import '/app/repositories/buyers_repository.dart';

part 'delivery_point_state.dart';
part 'delivery_point_view_model.dart';

class DeliveryPointPage extends StatelessWidget {
  final BuyerDeliveryPointEx pointEx;

  DeliveryPointPage({
    required this.pointEx,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DeliveryPointViewModel>(
      create: (context) => DeliveryPointViewModel(
        RepositoryProvider.of<AppRepository>(context),
        RepositoryProvider.of<BuyersRepository>(context),
        pointEx: pointEx,
      ),
      child: _DeliveryPointView(),
    );
  }
}

class _DeliveryPointView extends StatefulWidget {
  @override
  _DeliveryPointViewState createState() => _DeliveryPointViewState();
}

class _DeliveryPointViewState extends State<_DeliveryPointView> {
  static const TextStyle formStyle = TextStyle(fontSize: 16);
  final ImagePicker _picker = ImagePicker();
  late final ProgressDialog _progressDialog = ProgressDialog(context: context);

  Future<void> _showPicker(ImageSource source) async {
    final vm = context.read<DeliveryPointViewModel>();
    final file = await _picker.pickImage(source: source, maxHeight: 3840, maxWidth: 2160);

    if (file == null) return;

    await vm.addPhoto(file);
  }

  @override
  void dispose() {
    _progressDialog.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeliveryPointViewModel, DeliveryPointState>(
      builder: (context, state) {
        final vm = context.read<DeliveryPointViewModel>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Информация'),
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                splashRadius: 12,
                tooltip: 'Сохранить изменения',
                onPressed: vm.state.needSync ? vm.save : null
              )
            ]
          ),
          body: _buildBody(context)
        );
      },
      listener: (context, state) async {
        switch (state.status) {
          case DeliveryPointStateStatus.cameraOpened:
            await _showPicker(ImageSource.camera);
            break;
          case DeliveryPointStateStatus.galleryOpened:
            await _showPicker(ImageSource.gallery);
            break;
          case DeliveryPointStateStatus.inProgress:
            _progressDialog.open();
            break;
          case DeliveryPointStateStatus.failure:
          case DeliveryPointStateStatus.success:
            _progressDialog.close();
            Misc.showMessage(context, state.message);
            break;
          default:
        }
      }
    );
  }

  Widget _buildBody(BuildContext context) {
    DeliveryPointViewModel vm = context.read<DeliveryPointViewModel>();
    DeliveryPointState state = vm.state;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          child: Column(
            children: [
              InfoRow.page(
                title: const Text('Контактный телефон', style: formStyle),
                trailing: NumTextField(
                  initialValue: state.pointEx.point.phone,
                  onChanged: vm.updatePhone,
                  textAlign: TextAlign.start,
                  style: formStyle,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: '+7 (###) ###-##-##'
                  ),
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '+7 (###) ###-##-##',
                      filter: { '#': RegExp(r'[0-9]') },
                      initialText: state.pointEx.point.phone,
                      type: MaskAutoCompletionType.lazy
                    )
                  ]
                )
              ),
              InfoRow.page(
                title: const Text('Примечание', style: formStyle),
                trailing: TextFormField(
                  initialValue: state.pointEx.point.info,
                  onChanged: vm.updateInfo,
                  keyboardType: TextInputType.text,
                  minLines: 1,
                  maxLines: null,
                  style: formStyle
                )
              ),
              const ListTile(
                contentPadding: EdgeInsets.all(8),
                title: Text('Фотографии', style: formStyle),
              ),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                mainAxisSpacing: 16,
                children: buildImages(context)
                  ..add(
                    GestureDetector(child: OverflowBar(
                      overflowAlignment: OverflowBarAlignment.center,
                      children: [
                        IconButton(
                          onPressed: vm.tryTakePhoto,
                          icon: const Icon(Icons.add_a_photo),
                          tooltip: 'Сделать фотографию',
                        ),
                        IconButton(
                          onPressed: vm.tryPickPhoto,
                          icon: const Icon(Icons.image_search),
                          tooltip: 'Добавить из галереи',
                        )
                      ],
                    ))
                )
              )
            ],
          )
        )
      ],
    );
  }

  List<Widget> buildImages(BuildContext context) {
    final vm = context.read<DeliveryPointViewModel>();
    final photos = vm.state.photos.map((photo) => RetryableImage(
      key: Key(photo.key),
      color: Theme.of(context).colorScheme.primary,
      cached: photo.needSync,
      imageUrl: photo.url,
      cacheKey: photo.key,
      cacheManager: BuyersRepository.buyerDeliveryPointPhotosCacheManager,
    )).toList();

    return photos.mapIndexed((idx, imageWidget) {
      return GestureDetector(
        onTap: () {
          Navigator.push<String>(
            context,
            MaterialPageRoute(
              fullscreenDialog: false,
              builder: (BuildContext context) => ImagesView(
                idx: idx,
                images: photos,
                onDelete: (idx) async => await vm.deletePointPhoto(vm.state.photos[idx])
              )
            )
          );
        },
        child: imageWidget
      );
    }).toList();
  }
}
