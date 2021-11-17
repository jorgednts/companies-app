import 'package:flutter/material.dart';

abstract class UseCase<P, R> {
  @protected
  Future<R> getRawFuture({required P params});

  Future<R> getFuture({required P params}) => getRawFuture(params: params);
}
