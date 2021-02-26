part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();
  
  @override
  List<Object> get props => [];
}

class FilterInitial extends FilterState {}
