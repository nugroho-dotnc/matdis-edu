import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matdis_edu/app/data/component/add_card.dart';
import 'package:matdis_edu/app/data/component/button.dart';
import 'package:matdis_edu/app/data/component/input.dart';
import 'package:matdis_edu/app/data/component/loading_page.dart';
import 'package:matdis_edu/app/data/component/video_card.dart';
import 'package:matdis_edu/app/data/global_data.dart';
import 'package:video_player/video_player.dart';

import '../../../../data/theme/colours.dart';
import '../controllers/video_form_controller.dart';

class VideoFormView extends GetView<VideoFormController> {
  const VideoFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Video'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: MainSection(controller: controller),
          ),
          Obx(() {
            return Visibility(
              visible: controller.isLoading.value,
              child: const Align(
                alignment: Alignment.center,
                child: LoadingPage(),
              ),
            );
          })
        ],
      ),
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({
    super.key,
    required this.controller,
  });

  final VideoFormController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: CasualTextField(
            controller: controller.titleController,
            hint: "Judul",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: CasualTextArea(
            controller: controller.descriptionController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: CategoryDropdown(controller: controller),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Obx(() {
            if (controller.thumbnail.value != null) {
              return GestureDetector(
                onTap: controller.pickThumbnail,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: Image.file(
                      File(controller.thumbnail.value!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            } else {
              return PickCard(
                text: "Upload Thumbnail",
                onClick: controller.pickThumbnail,
              );
            }
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(() {
            if (controller.video.value == null) {
              return PickCard(
                text: "Upload video",
                onClick: controller.pickVideo,
              );
            } else {
              return VideoCard(
                path: controller.video.value!.path,
                uploadOption: UploadOption.file,
              );
            }
          }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: CustomButton(
            onClick: controller.uploadVideo,
            text: "Upload Video",
          ),
        ),
      ],
    );
  }
}

class PickCard extends StatelessWidget {
  const PickCard({
    super.key,
    required this.text,
    required this.onClick,
  });

  final String text;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colours.primary100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              color: Colours.primary500,
              size: 40,
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: GoogleFonts.poppins(color: Colours.primary500),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({
    super.key,
    required this.controller,
  });

  final VideoFormController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        elevation: 2,
        color: Colors.white,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton<String>(
          value: controller.selectedValue.value,
          padding: EdgeInsets.symmetric(horizontal: 10),
          isDense: false,
          isExpanded: true,
          underline: SizedBox(),
          items: controller.items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  color: item == controller.selectedValue.value
                      ? Colours.primary500
                      : Colours.font,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              controller.updateSelectedValue(newValue);
            }
          },
        ),
      );
    });
  }
}
