import 'package:builderworkoutplanner/models/exercise_model.dart';

class Tabs {

   String? name;
  List<Company>? wrkts;

  Tabs({ this.name,  this.wrkts});
  

  Tabs copyWith({
    String? name,
    List<Company>? wrkts,
  }) {
    return Tabs(
      name: name ?? this.name,
      wrkts: wrkts ?? this.wrkts,
    );
  }
}
