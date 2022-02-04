class BurgerData {
  String imgUrl;
  String name;
  double price;

  BurgerData(
      {required this.imgUrl,
      required this.name,
      required this.price});
}

List<BurgerData> burgerData = [
  BurgerData(
    imgUrl:
        "https://i.ibb.co/LNfC863/non-veg-classic.jpg",
    name: "Non-Veg Classic",
    price: 150.0,
  ),
  BurgerData(
    imgUrl:
        "https://i.ibb.co/CVwv2r4/crispy-meat.jpg",
    name: "Crispy Meat",
    price: 250.0,
  ),
  BurgerData(
    imgUrl:
        "https://i.ibb.co/XyTwmcw/classic-veg.jpg",
    name: "Veg Classic",
    price: 120.0,
  ),
  BurgerData(

    imgUrl:
        "https://i.ibb.co/C6VShDJ/crispy-veg-double-patty.png",
    name: "Veg Double Patty",
    price: 170.0,
  ),
  BurgerData(
    imgUrl:
        "https://i.ibb.co/pRKzMQY/chicken-cheese.jpg",
    name: "Chicken Cheese",
    price: 250.0,
  ),
  BurgerData(

   imgUrl:
        "https://i.ibb.co/f9RN6D7/mac-burger.jpg",
    name: "Mac Cheese",
    price: 150.0,
  ),
];
