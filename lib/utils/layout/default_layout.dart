class DefaultLayout {
  final double screenWidth;
  final double screenHeight;
  final double? circularProgressIndicatorHeight;
  final double? cardHeight;
  final double? textBoxHeight;
  final double? titleHeight;
  final double? iconContainerHeight;
  final double? starIconContainerWidth;
  final double? pinIconContainerWidth;
  final double? expandedHeight;
  final double? contentSizedBoxHeight;
  final double? imgSizedBoxWidth;
  final double? imgSizedboxHeight;
  final double? reviewInfoSizedBoxHeight;
  final double? titleContainerHeight;
  final double? starImgWidth;
  final double? starImgHeight;
  final double? ratingWidth;
  final double? categorySizedBoxHeight;
  final double? containerHeight;
  final double? expandedContainerHeight;
  final int? containerFlex;
  final int? expandedContainerFlex;
  final int? textFieldFlex;
  final int? searchHistoryTitleFlex;
  final int? chipButtonFlex;
  final double? bgImgHeight;
  final double? textFieldHeight;
  final double? chipButtonHeight;
  final double? cardSizedBoxHeight;
  final double? imgContainerHeight;

  DefaultLayout({
    required this.screenWidth,
    required this.screenHeight,
    this.circularProgressIndicatorHeight,
    this.cardHeight,
    this.textBoxHeight,
    this.titleHeight,
    this.iconContainerHeight,
    this.starIconContainerWidth,
    this.pinIconContainerWidth,
    this.expandedHeight,
    this.contentSizedBoxHeight,
    this.imgSizedBoxWidth,
    this.imgSizedboxHeight,
    this.reviewInfoSizedBoxHeight,
    this.titleContainerHeight,
    this.starImgWidth,
    this.starImgHeight,
    this.ratingWidth,
    this.categorySizedBoxHeight,
    this.containerHeight,
    this.expandedContainerHeight,
    this.containerFlex,
    this.expandedContainerFlex,
    this.textFieldFlex,
    this.searchHistoryTitleFlex,
    this.chipButtonFlex,
    this.bgImgHeight,
    this.textFieldHeight,
    this.chipButtonHeight,
    this.cardSizedBoxHeight,
    this.imgContainerHeight,
  });
}

class DefaultSize extends DefaultLayout {
  DefaultSize({
    required super.screenWidth,
    required super.screenHeight,
    double? circularProgressIndicatorHeight,
    double? cardHeight,
    double? textBoxHeight,
    double? titleHeight,
    double? iconContainerHeight,
    double? starIconContainerWidth,
    double? pinIconContainerWidth,
    double? expandedHeight,
    double? contentSizedBoxHeight,
    double? imgSizedBoxWidth,
    double? imgSizedboxHeight,
    double? reviewInfoSizedBoxHeight,
    double? titleContainerHeight,
    double? starImgWidth,
    double? starImgHeight,
    double? ratingWidth,
    double? categorySizedBoxHeight,
    double? containerHeight,
    double? expandedContainerHeight,
    int? containerFlex,
    int? expandedContainerFlex,
    int? textFieldFlex,
    int? searchHistoryTitleFlex,
    int? chipButtonFlex,
    double? bgImgHeight,
    double? textFieldHeight,
    double? chipButtonHeight,
    double? cardSizedBoxHeight,
    double? imgContainerHeight,
  }) : super(
          circularProgressIndicatorHeight:
              circularProgressIndicatorHeight ?? screenHeight / 20,
          cardHeight: cardHeight ?? screenHeight / 2,
          textBoxHeight: textBoxHeight ?? screenHeight / 6,
          titleHeight: titleHeight ?? screenHeight / 12,
          iconContainerHeight: iconContainerHeight ?? screenHeight / 30,
          starIconContainerWidth: starIconContainerWidth ?? screenWidth / 6,
          pinIconContainerWidth: pinIconContainerWidth ?? screenWidth / 2,
          expandedHeight: expandedHeight ?? screenHeight / 3,
          contentSizedBoxHeight: contentSizedBoxHeight ?? screenHeight / 6,
          imgSizedBoxWidth: imgSizedBoxWidth ?? screenWidth / 4,
          imgSizedboxHeight: imgSizedboxHeight ?? screenHeight / 10,
          reviewInfoSizedBoxHeight:
              reviewInfoSizedBoxHeight ?? screenHeight / 8,
          titleContainerHeight: titleContainerHeight ?? screenHeight / 15,
          starImgWidth: starImgWidth ?? screenWidth / 9,
          starImgHeight: starImgHeight ?? screenHeight / 20,
          ratingWidth: ratingWidth ?? screenWidth / 9,
          categorySizedBoxHeight: categorySizedBoxHeight ?? screenHeight / 35,
          containerHeight: containerHeight ?? screenHeight / 3,
          expandedContainerHeight:
              expandedContainerHeight ?? screenHeight / 1.8,
          containerFlex: containerFlex ?? 1,
          expandedContainerFlex: expandedContainerFlex ?? 9,
          textFieldFlex: textFieldFlex ?? 20,
          searchHistoryTitleFlex: searchHistoryTitleFlex ?? 3,
          chipButtonFlex: chipButtonFlex ?? 4,
          bgImgHeight: bgImgHeight ?? screenHeight / 5,
          textFieldHeight: textFieldHeight ?? screenHeight / 15,
          chipButtonHeight: chipButtonHeight ?? screenHeight / 20,
          cardSizedBoxHeight: cardSizedBoxHeight ?? screenHeight / 5,
          imgContainerHeight: imgContainerHeight ?? screenHeight / 6,
        );
}
