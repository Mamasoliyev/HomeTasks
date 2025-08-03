void main(List<String> args) {
  List<Map<String, dynamic>> books = [{'title': 'Kitob A',
  'price': 1500}, {'title': 'Kitob B', 'price': 500}, {'title':
  'Kitob C', 'price': 900}];

  List<Map<String, dynamic>> cheap_books = [];
  books.map((element) {
   if(element['price'] <= 1000){
      cheap_books.add(element);
    } 
  }).toList();
  print(cheap_books);
}