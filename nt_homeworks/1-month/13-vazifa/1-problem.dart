void main(List<String> args) {
  List<String> colors = ["Red", "Blue", "Green", "Red", "Yellow",
  "Blue"];
  colors.sort();
  var unique_color = {};
  for(var color in colors){
    unique_color[color] = (unique_color[color] ?? 0) + 1;
  }
  print(unique_color);
} 