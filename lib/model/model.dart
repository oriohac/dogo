class Dogmodel{
final String message;
Dogmodel({
  required this.message 
});
factory Dogmodel.fromJson(dynamic json){
  return Dogmodel(message: ['message']as String);
}
}