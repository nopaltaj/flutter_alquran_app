part of 'surah_cubit.dart';

abstract class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object> get props => [];
}

class SurahInitial extends SurahState {}

class surahLoading extends SurahState {}

class surahLoaded extends SurahState {
  final List<SurahModel> listSurah;

  const surahLoaded({required this.listSurah});

  @override
  List<Object> get props => [listSurah];
}

class SurahError extends SurahState {
  final String message;

  const SurahError({required this.message});

  @override
  List<Object>get props => [message];
}
