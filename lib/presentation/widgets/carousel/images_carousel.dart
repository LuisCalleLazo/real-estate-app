import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImagesCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  final bool showThumbnails;

  const ImagesCarousel({
    super.key,
    required this.images,
    this.height = 300,
    this.showThumbnails = true,
  });

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  late PageController _pageController;
  late ScrollController _thumbnailController;
  int _currentPage = 0;
  bool _showControls = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _thumbnailController = ScrollController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _thumbnailController.dispose();
    super.dispose();
  }

  void _scrollThumbnailToCenter(int index) {
    if (!_thumbnailController.hasClients) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final thumbnailWidth = isMobile ? 56.0 : 66.0; // Ancho + margin
    final containerWidth = isMobile
        ? screenWidth * 0.4
        : (screenWidth > 1200 ? 300 : 200);

    // Calcular la posición central
    final targetOffset =
        (thumbnailWidth * index) - (containerWidth / 2) + (thumbnailWidth / 2);
    final maxScroll = _thumbnailController.position.maxScrollExtent;
    final clampedOffset = targetOffset.clamp(0.0, maxScroll);

    _thumbnailController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    if (_currentPage < widget.images.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    _scrollThumbnailToCenter(index);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final calculatedHeight = isMobile ? screenWidth * 0.75 : widget.height;

    return InkWell(
      onTap: () {
        context.go("/home");
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _showControls = true),
        onExit: (_) => setState(() => _showControls = false),
        child: SizedBox(
          height: calculatedHeight,
          child: Stack(
            children: [
              // PageView principal
              PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  return AnimatedScale(
                    scale: _currentPage == index ? 1.0 : 0.95,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(isMobile ? 0 : 12),
                        image: DecorationImage(
                          image: NetworkImage(widget.images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(isMobile ? 0 : 12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.1),
                        Colors.black.withValues(alpha: 0.3),
                      ],
                    ),
                  ),
                ),
              ),

              // Flechas de navegación
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isMobile || _showControls ? 1.0 : 0.0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavButton(
                        icon: Icons.arrow_back_ios_new,
                        onPressed: _currentPage > 0 ? _previousPage : null,
                      ),
                      _buildNavButton(
                        icon: Icons.arrow_forward_ios,
                        onPressed: _currentPage < widget.images.length - 1
                            ? _nextPage
                            : null,
                      ),
                    ],
                  ),
                ),
              ),

              // Indicadores de página
              Positioned(
                bottom: widget.showThumbnails ? (isMobile ? 60 : 80) : 20,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (index) => AnimatedContainer(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 32 : 8,
                      height: 8,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: _currentPage == index
                            ? [
                                BoxShadow(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ]
                            : [],
                      ),
                    ),
                  ),
                ),
              ),

              // Miniaturas con scroll automático
              if (widget.showThumbnails)
                Positioned(
                  bottom: isMobile ? 8 : 16,
                  left: isMobile ? 12 : 20,
                  child: Container(
                    height: isMobile ? 50 : 60,
                    width: isMobile
                        ? screenWidth * 0.4
                        : (screenWidth > 1200 ? 300 : 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                    child: ListView.builder(
                      controller: _thumbnailController,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 4 : 8,
                        vertical: isMobile ? 4 : 6,
                      ),
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == _currentPage;
                        return GestureDetector(
                          onTap: () {
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            width: isMobile ? 48 : 54,
                            margin: EdgeInsets.only(right: isMobile ? 6 : 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Colors.orangeAccent
                                    : Colors.white.withValues(alpha: 0.5),
                                width: isSelected ? 2.5 : 1.5,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.orangeAccent.withValues(
                                          alpha: 0.5,
                                        ),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    widget.images[index],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[800],
                                        child: Icon(
                                          Icons.image_not_supported,
                                          color: Colors.white54,
                                          size: isMobile ? 20 : 24,
                                        ),
                                      );
                                    },
                                  ),
                                  if (!isSelected)
                                    Container(
                                      color: Colors.black.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 24,
      color: Colors.white,
      style: IconButton.styleFrom(
        backgroundColor: onPressed != null
            ? Colors.black.withValues(alpha: 0.5)
            : Colors.black.withValues(alpha: 0.2),
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        disabledBackgroundColor: Colors.black.withValues(alpha: 0.2),
      ),
    );
  }
}
