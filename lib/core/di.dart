import 'package:dio/dio.dart';
import 'package:dp_project/core/sql_db.dart';
import 'package:dp_project/feature/logging/data/api/logs_api.dart';
import 'package:dp_project/feature/logging/data/repository/logs_repository_impl.dart';
import 'package:dp_project/feature/logging/domain/usecase/logs_use_case.dart';
import 'package:dp_project/feature/logging/presentation/controller/error_logs_notifier.dart';
import 'package:dp_project/feature/logging/presentation/controller/info_logs_notifier.dart';
import 'package:dp_project/feature/logging/presentation/controller/state/error_logs_state.dart';
import 'package:dp_project/feature/logging/presentation/controller/state/info_logs_state.dart';
import 'package:dp_project/feature/common/domain/repository/logs_repository.dart';
import 'package:dp_project/feature/photos/data/db/photo_sql.dart';
import 'package:dp_project/feature/photos/data/repository/photo_repository_impl.dart';
import 'package:dp_project/feature/photos/domain/repository/photo_repository.dart';
import 'package:dp_project/feature/photos/domain/usecase/photo_use_case.dart';
import 'package:dp_project/feature/photos/presentation/controller/my_photo_notifier.dart';
import 'package:dp_project/feature/photos/presentation/controller/photo_notifier.dart';
import 'package:dp_project/feature/photos/presentation/controller/search_photo_notifier.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/my_photo_state.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/photo_state.dart';
import 'package:dp_project/feature/photos/presentation/controller/state/search_photo_state.dart';
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
final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// ***************** DATASOURCE ***************** //
final userSqlApiProvider =
    Provider<UserSqlApi>((ref) => UserSqlApi(ref.watch(databaseProvider)));

final userFirebaseApi = Provider<UserFirebaseAuthApi>(
    (ref) => UserFirebaseAuthApi(ref.watch(firebaseAuthProvider)));

final photoProvider =
    Provider<PhotoSql>((ref) => PhotoSql(ref.watch(databaseProvider)));

final logsProvider =
    Provider<LogsSqlApi>((ref) => LogsSqlApi(ref.watch(databaseProvider)));

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

final logsRepositoryProvider = Provider<LogsRepository>(
  (ref) => LogsRepositoryImpl(ref.watch(logsProvider)),
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

final logsUseCasesProvider = Provider<LogsUseCase>(
  (ref) => LogsUseCase(ref.watch(logsRepositoryProvider)),
);

// ***************** RIVERPOD ***************** //
final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);

final photoNotifierProvider = NotifierProvider<PhotoNotifier, PhotoState>(
  () => PhotoNotifier(),
);

final userDataNotifierProvider =
    NotifierProvider<UserDataNotifier, UserDataState>(
  () => UserDataNotifier(),
);

final myPhotoNotifierProvider = NotifierProvider<MyPhotoNotifier, MyPhotoState>(
  () => MyPhotoNotifier(),
);

final infoLogsNotifierProvider =
    NotifierProvider<InfoLogsNotifier, InfoLogsState>(
  () => InfoLogsNotifier(),
);

final errorLogsNotifierProvider =
    NotifierProvider<ErrorLogsNotifier, ErrorLogsState>(
  () => ErrorLogsNotifier(),
);

final searchPhotoNotifierProvider =
    NotifierProvider<SearchPhotoNotifier, SearchPhotoState>(
  () => SearchPhotoNotifier(),
);
