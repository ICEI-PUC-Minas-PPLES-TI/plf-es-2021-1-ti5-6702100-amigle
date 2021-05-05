import 'dart:core';

import 'package:amigleapp/src/app/models/dto/tags/CategoryDTO.dart';
import 'package:amigleapp/src/app/models/dto/trending/TrendingDTO.dart';
import 'package:mobx/mobx.dart';

part 'trending_controller.g.dart';

class TrendingController = _TrendingControllerBase with _$TrendingController;

abstract class _TrendingControllerBase with Store {
  @observable
  List<CategoryDTO> categories = [
    CategoryDTO(name: 'Todos', id: 1)..selected = false,
    CategoryDTO(name: 'Filmes', id: 2)..selected = true,
  ];

  @observable
  List<TrendingDTO> trendings = [
    TrendingDTO('Ação', 'Filmes', 10),
    TrendingDTO('Aventura', 'Filmes', 6),
    TrendingDTO('Romance', 'Filmes', 3)
  ];

  @action
  selectCategory(String name) {
    categories.forEach((element) {
      if (element.name == name) {
        element.selected = true;
      } else {
        element.selected = false;
      }
    });
    categories = categories;
  }
}
