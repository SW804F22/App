class poi {
  String name = "";
  String UUID = "";
  String description = "";
  double long = 0.0;
  double lat = 0.0;
  String categories = "";
  String website = "";
  String address = "";
  int price = 0;

  poi(String _name, String _UUID, String _description, double _long, double _lat, String _categories, String _website, String _address, int _price){
    name = _name;
    UUID = _UUID;
    description = _description;
    long = _long;
    lat = _lat;
    categories = _categories;
    website = _website;
    address = _address;
    price = _price;
  }

}