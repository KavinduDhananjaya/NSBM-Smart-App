import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';
import 'package:flutter/material.dart';
import 'package:smart_app/db/model/user.dart';
import 'package:smart_app/util/db_util.dart';

class UserRepository extends FirebaseRepository<User> {
  @override
  User fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot == null) return null;
    final data = snapshot.data();
    if (data == null) return null;

    try {
      return User(
        ref: snapshot.reference,
        name: data[User.NAME_FIELD] ?? "",
        role: data[User.ROLE_FIELD] ?? "",
        universityId: data[User.UNIVERSITY_ID_FIELD] ?? "",
        universityEmail: data[User.UNIVERSITY_EMAIL_FIELD] ?? "",
        nsbmEmail: data[User.NSBM_EMAIL_FIELD] ?? "",
        degree: data[User.DEGREE_FIELD] ?? "",
        nsbmId: data[User.NSBM_ID_FIELD] ?? "",
        profileImage: data[User.PROFILE_IMAGE_FIELD] ?? "",
        registeredUniversity: data[User.REGISTERED_UNIVERSITY_FIELD] ?? "",
        batch: data[User.BATCH] ?? "",
      );
    } catch (e) {
      print("Fetching Data Exception >>>>>>>${e}");
      return null;
    }
  }

  @override
  Map<String, dynamic> toMap(User user) {
    return {
      User.NAME_FIELD: user.name,
      User.ROLE_FIELD: user.role,
      User.UNIVERSITY_EMAIL_FIELD: user.universityEmail,
      User.UNIVERSITY_ID_FIELD: user.universityId,
      User.NSBM_EMAIL_FIELD: user.nsbmEmail,
      User.NSBM_ID_FIELD: user.nsbmId,
      User.DEGREE_FIELD: user.degree,
      User.REGISTERED_UNIVERSITY_FIELD: user.registeredUniversity,
      User.PROFILE_IMAGE_FIELD: user.profileImage,
      User.BATCH: user.batch,
    };
  }

  @override
  Future<DocumentReference> update({
    @required User item,
    String type,
    DocumentReference parent,
    MapperCallback<User> mapper,
  }) {
    return super.update(
      item: item,
      type: DBUtil.USER,
      mapper: mapper,
    );
  }

  @override
  Future<List<User>> querySingle({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.querySingle(
      specification: specification,
      type: DBUtil.USER,
    );
  }

  @override
  Stream<List<User>> query({
    @required SpecificationI specification,
    String type,
    DocumentReference parent,
  }) {
    return super.query(
      specification: specification,
      type: DBUtil.USER,
    );
  }
}
