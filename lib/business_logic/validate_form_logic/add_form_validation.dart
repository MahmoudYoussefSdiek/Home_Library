/*
* This file contains the validation logic for the add form that checks on
*  [book name, author name, category, shelf, section].
*
* parameters:
*       [String] is the value we check our validation.
*
*       [void Function(bool)] is the callback function that we use to set the state of the form.
*       so i can use it decide later what is the border color.
 */

String? validateBookName(
    String? bookName, void Function(bool) setStateCallback) {
  if (bookName == null || bookName.isEmpty) {
    setStateCallback(false);
    return 'Enter a valid book name';
  } else {
    setStateCallback(true);
  }
  return null;
}

String? validateAuthorName(
    String? authorName, void Function(bool) setStateCallback) {
  if (authorName == null || authorName.isEmpty) {
    setStateCallback(false);
    return 'Enter a valid author name';
  } else {
    setStateCallback(true);
  }
  return null;
}

String? validateCategory(
    String? category, void Function(bool) setStateCallback) {
  if (category == null || category.isEmpty) {
    setStateCallback(false);
    return 'Enter a valid category';
  } else {
    setStateCallback(true);
  }
  return null;
}

String? validateShelf(String? shelf, void Function(bool) setStateCallback) {
  shelf ??= '-1';
  final int shelfNumber = int.tryParse(shelf) ?? -1;
  if (shelfNumber < 1 || shelfNumber > 4) {
    setStateCallback(false);
    return 'Enter a valid shelf number between 1 and 4!';
  } else {
    setStateCallback(true);
  }
  return null;
}

String? validateSection(String? section, void Function(bool) setStateCallback) {
  section ??= '-1';
  final int sectionNumber = int.tryParse(section) ?? -1;
  if (sectionNumber < 1 || sectionNumber > 4) {
    setStateCallback(false);
    return 'Enter a valid section number between 1 and 4!';
  } else {
    setStateCallback(true);
  }
  return null;
}
