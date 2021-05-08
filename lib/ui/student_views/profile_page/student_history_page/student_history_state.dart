import 'package:flutter/material.dart';
import 'package:smart_app/db/model/hall_request.dart';
import 'package:smart_app/db/model/lecturer_request.dart';

@immutable
class StudentHistoryState {
  final String error;
  final List<HallRequest> allHallRequests;
  final List<LectureRequest> allLecturerRequests;

  StudentHistoryState({
    @required this.error,
    @required this.allHallRequests,
    @required this.allLecturerRequests,
  });

  static StudentHistoryState get initialState => StudentHistoryState(
        error: '',
        allHallRequests: null,
        allLecturerRequests: null,
      );

  StudentHistoryState clone({
    String error,
    List<HallRequest> allHallRequests,
    List<LectureRequest> allLecturerRequests,
  }) {
    return StudentHistoryState(
      error: error ?? this.error,
      allLecturerRequests: allLecturerRequests ?? this.allLecturerRequests,
      allHallRequests: allHallRequests ?? this.allHallRequests,
    );
  }
}
