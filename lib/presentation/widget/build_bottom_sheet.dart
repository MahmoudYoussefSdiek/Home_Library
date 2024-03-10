import 'package:flutter/material.dart';
import 'package:home_library/business_logic/validate_form_logic/add_form_validation.dart';
import 'package:home_library/presentation/widget/custom_text_form_field.dart';

Widget buildBottomSheet(
  BuildContext context,
  GlobalKey<FormState> formKey,
  TextEditingController bookNameController,
  TextEditingController authorNameController,
  TextEditingController categoryController,
  TextEditingController shelfController,
  TextEditingController sectionController,
  bool isFullNameValid,
  bool isAuthorNameValid,
  bool isCategoryValid,
  bool isShelfValid,
  bool isSectionValid,
  Function() onSaved,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      color: Colors.grey[200],
    ),
    height: MediaQuery.of(context).size.height * 0.8,
    padding: const EdgeInsets.all(20),
    child: SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: bookNameController,
              hintText: 'Book Name',
              validator: (value) => validateBookName(
                  value, (isValid) => isFullNameValid = isValid),
              colorFlag: isFullNameValid,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: authorNameController,
              hintText: 'Author Name',
              validator: (value) => validateAuthorName(
                  value, (isValid) => isAuthorNameValid = isValid),
              colorFlag: isAuthorNameValid,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: categoryController,
              hintText: 'Category',
              validator: (value) => validateCategory(
                  value, (isValid) => isCategoryValid = isValid),
              colorFlag: isCategoryValid,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: shelfController,
              hintText: 'Shelf',
              validator: (value) =>
                  validateShelf(value, (isValid) => isShelfValid = isValid),
              colorFlag: isShelfValid,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: sectionController,
              hintText: 'Section',
              validator: (value) =>
                  validateSection(value, (isValid) => isSectionValid = isValid),
              colorFlag: isSectionValid,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              onPressed: onSaved,
              child: const Text('Save', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
  );
}
