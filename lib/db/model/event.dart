import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcode_bloc/fcode_bloc.dart';

class Event extends DBModel {

  static const UP_COMING="upComing";
  static const PASSED="passed";


  static const TITLE='title';
  static const IMG_URL='imgUrl';
  static const DESCRIPTION='description';
  static const STATE='state';
  static const DATE='date';
  static const CREATED_AT='createdAt';
  static const CREATED_BY='createdBy';


  String title;
  String imgUrl;
  String description;
  String state;
  Timestamp date;
  Timestamp createdAt;
  DocumentReference createdBy;

  Event({
    DocumentReference ref,
    this.title,
    this.imgUrl,
    this.description,
    this.state,
    this.date,
    this.createdAt,
    this.createdBy,
  }) : super(ref: ref);

  @override
  Event clone() {
    return Event(
      ref: ref ?? this.ref,
      date: date ?? this.date,
      title: title ?? this.title,
      state: state ?? this.state,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
