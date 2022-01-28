class Boat {
  final String model;
  final String by;
  final String description;
  final String imgPath;
  final List<String> gallery;
  final Map<String, String> specs;

  Boat({
    required this.model,
    required this.by,
    required this.description,
    required this.imgPath,
    required this.gallery,
    required this.specs,
  });

  static const List<String> _gallery = [
    'assets/gallery1.jpg',
    'assets/gallery2.jpg',
    'assets/gallery3.jpg',
    'assets/gallery4.jpg',
    'assets/gallery5.jpg',
  ];

  static const String _description =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ligula metus, gravida vel sapien sed, luctus porta sem. Suspendisse tempor ex quis malesuada aliquet. Praesent.';

  static const Map<String, String> _specs = {
    "Boat Length": "24'2",
    "Beam": "102'",
    "Weight": "2765 KG",
    "Fuel Capacity": "322 L"
  };

  static List<Boat> boats = [
    Boat(
      model: 'XCLR8 Speed',
      by: 'Tennison',
      description: _description,
      imgPath: 'assets/boat1.png',
      gallery: _gallery,
      specs: _specs,
    ),
    Boat(
      model: 'X21 Strength',
      by: 'NeoCraft',
      description: _description,
      imgPath: 'assets/boat4.png',
      gallery: _gallery,
      specs: _specs,
    ),
    Boat(
      model: 'X12 Force',
      by: 'Mastercraft',
      description: _description,
      imgPath: 'assets/boat3.png',
      gallery: _gallery,
      specs: _specs,
    ),
    Boat(
      model: 'X-FORCE',
      by: 'W - Wilson',
      description: _description,
      imgPath: 'assets/boat2.png',
      gallery: _gallery,
      specs: _specs,
    ),
  ];
}
