import 'package:bloc/bloc.dart';
import '../../data/models/company_model.dart';
import '../../data/repository/company_repository.dart';
import 'company_state.dart';


class CompanyCubit extends Cubit<CompanyState> {
  final CompanyRepository companyRepository;

  CompanyCubit({required this.companyRepository}) : super(CompanyInitial());

  Future<void> fetchAllCompanies() async {
    try {
      emit(CompanyLoading());
      final companies = await companyRepository.getAllCompanies();
      emit(CompanySuccess(companies: companies));
    } catch (e) {
      emit(CompanyError(message: e.toString()));
    }
  }
  
}


