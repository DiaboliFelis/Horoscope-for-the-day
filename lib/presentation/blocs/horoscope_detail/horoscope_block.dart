import 'package:bloc/bloc.dart';
import 'horoscope_state.dart';
import 'horoscope_event.dart';
import 'package:horoscope_for_the_day/data/datasources/horoscope_data_source.dart';

class HoroscopeBloc extends Bloc<HoroscopeEvent, HoroscopeState> {
  final HoroscopeDataSource horoscopeDataSource;

  HoroscopeBloc(this.horoscopeDataSource) : super(HoroscopeLoading()) {
    on<FetchHoroscope>(_onFetchHoroscope);
  }

  Future<void> _onFetchHoroscope(
    FetchHoroscope event,
    Emitter<HoroscopeState> emit,
  ) async {
    emit(HoroscopeLoading());
    try {
      final horoscope = await horoscopeDataSource.fetchHoroscope(
        event.zodiacSign,
      );
      emit(HoroscopeLoaded(horoscope));
    } on Exception catch (e) {
      emit(HoroscopeError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
