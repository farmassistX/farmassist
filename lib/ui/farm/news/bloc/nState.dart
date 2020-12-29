import 'package:equatable/equatable.dart';
import 'package:farmassist/data/farm/models/News.dart';
import 'package:flutter/material.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class Loading extends NewsState {}

class Loaded extends NewsState {
  final List<Article> items;
  final String type;

  const Loaded({@required this.items, this.type});

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded { items: ${items.length} }';
}

class Failure extends NewsState {}
