import 'package:experiments/utils/diff_utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_commons/flutter_commons.dart';

void main() {
  test('diff test', () {
    var previous = List.generate(randomizer.nextInt(25), (index) => randomizer.nextInt(100)); //, (index) => null) [1,2,3,4,1,5,76,2,5,2,5,6,7,];
    print('in   -> $previous');
    var current = List.generate(randomizer.nextInt(25), (index) => randomizer.nextInt(100)); //[1,5,5,2,4,55,1,6,1,8,3,21];
    var actions = DiffUtil().calculateDiff(previous, current);

    var working = List.of(previous);
    actions.forEach((act) {
      act.applyTo(working);
      print('$act => $working');
    });

    print('out  -> $working');
    print('need -> $current');

    assert(current.equals(working));
  });
}
