import 'package:el_resto_app/model/menu.dart';
import 'package:el_resto_app/model/menu_category.dart';

final menuCategory1 = [
  MenuCategory(
    id: '1',
    restoId: '1',
    title: 'Argentinian-style',
    subtitle: 'pizza',
    menuItems: [
      Menu(
          id: '1',
          menuCategoryId: '1',
          name: 'NAPOLITANA',
          description: 'Tomatoes, oreganos, green olives',
          price: 150),
      Menu(
          id: '2',
          menuCategoryId: '1',
          name: 'PEPPERONI',
          description: 'Beef pepperoni',
          price: 160),
      Menu(
          id: '3',
          menuCategoryId: '1',
          name: 'MORRONES Y JAMON',
          description: 'Red bell peppers and ham',
          price: 170),
      Menu(
          id: '4',
          menuCategoryId: '1',
          name: 'MOZARELLA',
          description: 'Tomato sauces and olives',
          price: 150),
      Menu(
          id: '5',
          menuCategoryId: '1',
          name: 'SALMON',
          description: 'Smoked salmon, capers, black olives',
          price: 220),
      Menu(
          id: '6',
          menuCategoryId: '1',
          name: 'MIXED MUSHROOMS',
          description: 'Cream Based and mushrooms',
          price: 190),
      Menu(
          id: '7',
          menuCategoryId: '1',
          name: 'FUGAZETTA',
          description: 'Cream Based, oregano, and onions',
          price: 150),
      Menu(
          id: '8',
          menuCategoryId: '1',
          name: 'IBERICO PIZZA',
          description: 'Tomato sauces and Iberico ham',
          price: 265),
    ],
  ),
];

final menuCategory2 = [
  MenuCategory(id: '2', restoId: '1', title: 'Empanadas', menuItems: [
    Menu(id: '9', menuCategoryId: '2', name: 'HAM & MOZZARELA', price: 55),
    Menu(id: '10', menuCategoryId: '2', name: 'HAND-CUT BEEF', price: 55),
    Menu(id: '11', menuCategoryId: '2', name: 'SPINACH & RICOTTA', price: 55),
    Menu(id: '12', menuCategoryId: '2', name: 'EMPANADAS PLATTER', price: 140),
  ])
];

final menuCategory3 = [
  MenuCategory(id: '13', restoId: '2', title: 'Main Course', menuItems: [
    Menu(
        id: '13',
        menuCategoryId: '3',
        name: 'CANELONES DE VERDURA',
        description:
            'Rolled savory crepes, filled with sauteed creamy cheesy spinach, tomatoes, onion, olives, garlic, and herbs, served with a mixture of Bechamel and tomato sauce.',
        price: 91),
    Menu(
        id: '14',
        menuCategoryId: '3',
        name: 'CANELONES DE CARNE',
        description:
            'Rolled savory crepes, filled with minced beef, onion, boiled egg, olives, garlic, capsicum, and herbs, served with a mixture of Bechamel and tomato sauce.',
        price: 110),
    Menu(
        id: '15',
        menuCategoryId: '3',
        name: 'MILANESA DE POLLO',
        description:
            'Juicy marinated chicken breast cooked schnitzel-style, coated with breadcrumbs, served with beef ham, and topped with mozarella cheese, tomato paste, and green peas. Choose one side dish : Russian salad or Seasoned French Fries',
        price: 110),
  ])
];
