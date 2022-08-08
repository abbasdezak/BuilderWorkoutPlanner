import 'package:localstorage/localstorage.dart';

class TimeHelper {
  static Map<String, int> workoutsCounter(List datesData) {
    var firstDay = DateTime.now().weekday + 1;
    if (firstDay == 8) {
      firstDay = 7;
    }

    DateTime startWeek = DateTime.now().subtract(Duration(days: firstDay));

    // print(startWeek);

    var startMonth = DateTime(DateTime.now().year, DateTime.now().month);

    List<DateTime> listOfWeek = [];
    List<DateTime> listMonth = [];

    datesData.forEach((e) {
      if (e.isAfter(startWeek)) {
        listOfWeek.add(e);
        print(listOfWeek);
      }
      if (e.isAfter(startMonth)) {
        listMonth.add(e);
        print(listMonth);
      }
    });
    return {'Month': listMonth.length, 'Week': listOfWeek.length};
  }

  static void workoutSaver() async {
    final LocalStorage localStorage = new LocalStorage('dates');
    await localStorage.ready;
    if (localStorage.getItem('date') == null) {
      localStorage.setItem('date', {});
    }
    Map map = localStorage.getItem('date');

    //   List? list1 = map['workedout'];

    var list;
    try {
      list = [...map.values.first, '${DateTime.now()}'];
    } catch (e) {
      list = ['${DateTime.now()}'];
      print(e);
    }
    //   print(list);

    await localStorage.setItem('date', {'workedout': list});
  }

  static void settingsSaver(
      {String? name,
      int? weight,
      int? height,
      int? reps,
      int? sets,
      int? rest,
      int? gender}) async {
    final LocalStorage localStorage = new LocalStorage('Settings');
    await localStorage.ready;
    if (localStorage.getItem('Setting') == null) {
      await localStorage.setItem('Setting', {});
    }
    Map map = await localStorage.getItem('Setting');

    await localStorage.setItem('Setting', {
      'Name': name != null ? name : map['Name'],
      'Weight': weight != null ? weight : map['Weight'] as int,
      'Height': height != null ? height : map['Height'] as int,
      'Reps': reps != null ? reps : map['Reps'],
      'Sets': sets != null ? sets : map['Sets'],
      'Rest': rest != null ? rest : map['Rest'],
      'Gender': gender != null ? gender : map['Gender'] as int,
    });
  }

  static Future<Map> dataGetter(fileName, mapName) async {
    final _localStorage = LocalStorage('$fileName');
    await _localStorage.ready;
    final result = await _localStorage.getItem('$mapName');
    return result == null ? {} : result;
  }
}
