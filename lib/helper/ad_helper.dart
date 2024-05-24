import 'package:flutter_mobile_app/interface/room_list_item_interface.dart';
import 'package:flutter_mobile_app/model/ad_modes.dart';
import 'package:flutter_mobile_app/view/widgets/roomListWidgets/room_list/ad_item.dart';

class AdHelper {
  static List<RoomListItem> roomListAdInserter(List<RoomListItem> roomList) {
    RoomListAdModel mockAd = RoomListAdModel(
        id: 'ad',
        title: 'Psie klapki',
        content: 'Lelum polelum',
        describe: 'reklama');
    List<RoomListItem> tempList = roomList.toList();
    if (roomList.length < 3) {
      tempList.add(AdItem(adModel: mockAd));
      return tempList;
    }

    for (var i = 0; i < tempList.length; i++) {
      if ((i + 1) % 3 == 0) {
        tempList.insert(i, AdItem(adModel: mockAd));
      }
    }

    return tempList;
  }
}
