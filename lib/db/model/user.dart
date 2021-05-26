import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class User extends DBModel {
  static const NAME_FIELD = 'name';
  static const UNIVERSITY_EMAIL_FIELD = 'universityEmail';
  static const UNIVERSITY_ID_FIELD = 'universityId';
  static const NSBM_ID_FIELD = 'nsbmId';
  static const NSBM_EMAIL_FIELD = 'nsbmEmail';
  static const ROLE_FIELD = 'role';
  static const PROFILE_IMAGE_FIELD = 'profileImage';
  static const REGISTERED_UNIVERSITY_FIELD = 'registeredUniversity';
  static const DEGREE_FIELD = 'degree';
  static const BATCH = 'batch';

  String name;
  String universityEmail;
  String nsbmEmail;
  String universityId;
  String nsbmId;
  String role;
  String degree;
  String registeredUniversity;
  String profileImage;
  String batch;

  User({
    DocumentReference ref,
    this.name,
    this.degree,
    this.nsbmEmail,
    this.nsbmId,
    this.profileImage,
    this.registeredUniversity,
    this.role,
    this.universityEmail,
    this.universityId,
    this.batch,
  }) : super(ref: ref);

  @override
  User clone() {
    return User(
      ref: ref,
      name: name,
      role: role,
      degree: degree,
      nsbmEmail: nsbmEmail,
      nsbmId: nsbmId,
      profileImage: profileImage,
      registeredUniversity: registeredUniversity,
      universityEmail: universityEmail,
      universityId: universityId,
      batch: batch,
    );
  }
}
