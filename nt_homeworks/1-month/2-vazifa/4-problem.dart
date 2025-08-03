class Person {
  String ism;

  //Person(this.ism)
  factory Person(String ism){
    if(ism != "Nodirbek"){
      throw Exception("Boshqa ism kiriting.");
    }
    return Person._create(ism);
  }
  Person._create(this.ism);
}
void main(){
  try{
  Person shaxs = Person("Nodirbek");
  print(shaxs.ism);
  }
  catch(e){
    print(e);
  }
}