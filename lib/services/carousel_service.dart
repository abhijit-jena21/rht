import '../services/carousel_repo.dart';

class CarouselService {
  CarouselRepository _carouselRepository;
  CarouselService() {
    _carouselRepository = CarouselRepository();
  }
  getSliders() async {
    return await _carouselRepository.httpGet('carousel');
  }
}
