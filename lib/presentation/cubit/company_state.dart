import 'package:equatable/equatable.dart';
import '../../data/models/company_model.dart';

abstract class CompanyState extends Equatable {
  @override
  List<Object> get props => [];
}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanySuccess extends CompanyState {
  final List<CompanyModel> companies;

  CompanySuccess({required this.companies});

  @override
  List<Object> get props => [companies];
}

class CompanyError extends CompanyState {
  final String message;

  CompanyError({required this.message});

  @override
  List<Object> get props => [message];
}
