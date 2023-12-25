String removeSpacesAtEdges(String input) {
  RegExp leadingSpaces = RegExp(r'^\s+');
  RegExp trailingSpaces = RegExp(r'\s+$');

  input = input.replaceFirst(leadingSpaces, '');

  input = input.replaceAll(trailingSpaces, '');

  return input;
}
