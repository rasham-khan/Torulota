class Product{
  String name;
  int height;
  int price;
  String url;
  String type;
  Product(this.name,this.height,this.price,this.url, this.type);
  static List<Product> generateTopProduct(){
    return [
      Product('Aloe Vera', 38, 350, 'assets/inDoorPlants/Aloe Vera.png', 'indoor'),
      Product('Areca Palm', 164, 1000, 'assets/outDoorPlants/Areca Palm.png', 'outdoor'),
      Product('Dracaena', 178, 1655, 'assets/inDoorPlants/Dracaena Gold Star.png', 'indoor'),
      Product('Yucca', 86, 470, 'assets/outDoorPlants/Yucca.png', 'outdoor')
    ];
  }
  static List<Product> generateInDoorProducts(){
    return[
      Product('Aloe Vera', 38, 350, 'assets/inDoorPlants/Aloe Vera.png', 'indoor'),
      Product('B.N. Fern', 40, 220, 'assets/inDoorPlants/Bird’s Nest Fern.png', 'indoor'),
      Product('Dracaena', 178, 1655, 'assets/inDoorPlants/Dracaena Gold Star.png', 'indoor'),
      Product('Philodendron', 28, 507, 'assets/inDoorPlants/Philodendron Green.png', 'indoor'),
      Product('Pothos', 41, 425, 'assets/inDoorPlants/Pothos.png', 'indoor'),
      Product('Rubber', 40, 400, 'assets/inDoorPlants/Rubber Tree.png', 'indoor'),
      Product('Snake Plant', 49, 500, 'assets/inDoorPlants/Snake Plant Laurentii.png', 'indoor'),
      Product('ZZ Plant', 53, 615, 'assets/inDoorPlants/ZZ Plant.png', 'indoor'),
    ];
  }
  static List<Product> generateOutDoorProducts(){
    return [
      Product('Agava', 62, 360, 'assets/outDoorPlants/agava.png', 'outdoor'),
      Product('Areca Palm', 93, 520, 'assets/outDoorPlants/Areca Palm.png', 'outdoor'),
      Product('Fejka monstera', 86, 790, 'assets/outDoorPlants/Fejka monstera.png', 'outdoor'),
      Product('Pink Rose', 52, 260, 'assets/outDoorPlants/Pink Rose.png', 'outdoor'),
      Product('Red Begonias', 61, 450, 'assets/outDoorPlants/Red Begonias.png', 'outdoor'),
      Product('Yucca', 79, 390, 'assets/outDoorPlants/Yucca.png', 'outdoor'),
    ];
  }
}