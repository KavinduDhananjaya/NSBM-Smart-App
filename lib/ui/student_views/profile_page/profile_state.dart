import 'package:flutter/material.dart';

@immutable
class ProfileState {
  final String error;

  ProfileState({
    @required this.error,
  });

  static ProfileState get initialState => ProfileState(
    error: '',
  );

  ProfileState clone({
    String error,
  }) {
    return ProfileState(
      error: error ?? this.error,
    );
  }
}
