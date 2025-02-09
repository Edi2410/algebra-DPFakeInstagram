import 'package:dp_project/core/sql_db.dart';
import 'package:dp_project/feature/profile/domain/entity/custom_user.dart';
import 'package:dp_project/feature/profile/domain/entity/free_package.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:dp_project/feature/common/presentation/utility/package_utis.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSqlApi {
  final SqlDb _sqlDb;

  UserSqlApi(this._sqlDb);

  Future<void> createUserDataIfNotExist(
      final User user, PackageInfo? packageInfo) async {
    final database = await _sqlDb.db;

    var userData = await database.query(
      'UserData',
      where: 'uid = ?',
      whereArgs: [user.uid],
    );

    if (userData.isEmpty) {
      await database.insert(
        'UserData',
        {
          'uid': user.uid,
          'displayName': user.displayName,
          'isAdministrator': user.email == 'graovacedi@gmail.com' ? 1 : 0,
        },
      );
      await database.insert('PackageInfo', {
        'uid': user.uid,
        'packageName': packageInfo != null
            ? packageInfo.getPackageName()
            : FreePackage().getPackageName(),
      });
    }
  }

  Future<CustomUser> getUserData(final User user) async {
    final database = await _sqlDb.db;

    var userInfo = await database.query(
      'UserData',
      where: 'uid = ?',
      whereArgs: [user.uid],
    );

    var packageInfo = await database.rawQuery(
      '''
        SELECT * 
        FROM PackageInfo 
        WHERE uid = ? 
        AND date != date('now') 
        ORDER BY ABS(JULIANDAY(date) - JULIANDAY('now')) 
        LIMIT 1;
        ''',
      [user.uid], // Passing the user's UID as an argument
    );

    if (packageInfo.isNotEmpty && userInfo.isNotEmpty) {
      var packageData = packageInfo.first;
      var userData = userInfo.first;

      String packageName = packageData['packageName'] as String;

      bool test = userData['isAdministrator'] == 1;

      return CustomUser(
        user: user,
        packageInfo: getUserPackageByName(packageName),
        isAdministrator: userData['isAdministrator'] == 1,
      );
    }

    return CustomUser(
        user: user, packageInfo: FreePackage(), isAdministrator: false);
  }

  Future<void> updatePackageInfo(
      CustomUser customUser, PackageInfo newPackage) async {
    final database = await _sqlDb.db;

    await database.insert('PackageInfo', {
      'uid': customUser.user!.uid,
      'packageName': newPackage.getPackageName(),
    });
  }
}
