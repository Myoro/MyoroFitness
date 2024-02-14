enum UnitEnum {
  grams('G'),
  milligrams('MG'),
  calories('KCAL'),
  kilojoules('kJ');

  final String notation;

  const UnitEnum(this.notation);
}
