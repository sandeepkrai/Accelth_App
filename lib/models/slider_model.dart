class SliderModel{
  String? image;

// images given
  SliderModel({this.image});

// setter for image
  void setImage(String getImage){
    image = getImage;
  }

// getter for image
  String? getImage(){
    return image;
  }
}
List<SliderModel> getSlides(){
  List<SliderModel> slides = <SliderModel>[];
  SliderModel sliderModel = SliderModel();

  // 1
  sliderModel.setImage("assets/images/slider1.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  // 2
  sliderModel.setImage("assets/images/slider2.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();

  // 3
  sliderModel.setImage("assets/images/slider3.png");
  slides.add(sliderModel);

  sliderModel = SliderModel();
  return slides;
}