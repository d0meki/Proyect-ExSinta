class OptionsModel {
  bool escalar = true;
  bool numerico = false;



  void selectEscalar() {
    escalar = true;
    numerico = false;
  }

  void selectNumerico() {
    escalar = false;
    numerico = true;
  }
}
