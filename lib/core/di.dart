import 'package:dio/dio.dart';
import 'package:dp_project/core/sql_db.dart';
import 'package:dp_project/feature/photos/data/db/photo_sql.dart';
import 'package:dp_project/feature/photos/data/repository/photo_repository_impl.dart';
import 'package:dp_project/feature/photos/domain/repository/photo_repository.dart';
import 'package:dp_project/feature/photos/domain/usecase/photo_use_case.dart';
import 'package:dp_project/feature/photos/presentation/controller/my_photo_notifier.dart';
import 'package:dp_project/feature/photos/presentation/controller/photo_notifier.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/my_photo_state.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/photo_state.dart';
import 'package:dp_project/feature/profile/data/db/user_sql_api.dart';
import 'package:dp_project/feature/profile/data/repository/user_data_repository_impl.dart';
import 'package:dp_project/feature/profile/domain/repository/user_data_repository.dart';
import 'package:dp_project/feature/profile/domain/usecase/user_use_case.dart';
import 'package:dp_project/feature/profile/presentation/controller/state/user_data_state.dart';
import 'package:dp_project/feature/profile/presentation/controller/user_data_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/feature/auth/data/firabase/user_firebase_auth_api.dart';
import 'package:dp_project/feature/auth/data/repository/user_auth_repository_impl.dart';
import 'package:dp_project/feature/auth/domain/repository/user_auth_repository.dart';
import 'package:dp_project/feature/auth/domain/usecase/auth_use_case.dart';
import 'package:dp_project/feature/auth/presentation/controller/auth_notifier.dart';
import 'package:dp_project/feature/auth/presentation/controller/state/auth_state.dart';


// ***************** EXTERNAL LIBRARIES ***************** //
final databaseProvider = Provider<SqlDb>((ref) => SqlDb.instance);
final dioProvider = Provider<Dio>((ref) => Dio());
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);



// ***************** DATASOURCE ***************** //
final userSqlApiProvider = Provider<UserSqlApi>((ref) =>
    UserSqlApi(ref.watch(databaseProvider))
);

final userFirebaseApi = Provider<UserFirebaseAuthApi>((ref) =>
    UserFirebaseAuthApi(ref.watch(firebaseAuthProvider))
);

final photoProvider = Provider<PhotoSql>((ref) =>
    PhotoSql(ref.watch(databaseProvider))
);



// ***************** REPOSITORY ***************** //
final userSqlRepositoryProvider = Provider<UserDataRepository>(
      (ref) => UserDataRepositoryImpl(ref.watch(userSqlApiProvider)),
);

final userFirebaseRepositoryProvider = Provider<UserAuthRepository>(
      (ref) => UserAuthRepositoryImpl(ref.watch(userFirebaseApi)),
);

final photoRepositoryProvider = Provider<PhotoRepository>(
      (ref) => PhotoRepositoryImpl(ref.watch(photoProvider)),
);

// ***************** USE CASE ***************** //
final authUseCasesProvider = Provider<AuthUseCase>(
      (ref) => AuthUseCase(ref.watch(userFirebaseRepositoryProvider)),
);

final photoUseCasesProvider = Provider<PhotoUseCase>(
      (ref) => PhotoUseCase(ref.watch(photoRepositoryProvider)),
);

final userUseCasesProvider = Provider<UserUseCase>(
      (ref) => UserUseCase(ref.watch(userSqlRepositoryProvider)),
);

// ***************** RIVERPOD ***************** //
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
      () => AuthNotifier(),
);

final photoNotifierProvider = NotifierProvider<PhotoNotifier, PhotoState>(
      () => PhotoNotifier(),
);

final userDataNotifierProvider = NotifierProvider<UserDataNotifier, UserDataState>(
      () => UserDataNotifier(),
);

final myPhotoNotifierProvider = NotifierProvider<MyPhotoNotifier, MyPhotoState>(
      () => MyPhotoNotifier(),
);







