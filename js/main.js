$(function() {
  var app;
  app = {
    init: function() {
      this.initCache();
      this.initYandexMap();
      this.initSlider();
      this.initFancybox();
      this.initAnchorLinks();
      return this.initBrandItems();
    },
    initCache: function() {
      this.map = $('#map');
      this.mainSlider = $('#mainSlider');
      this.mainSliderIcon = this.mainSlider.find('.js-main-slider-icon');
      this.fancyboxLinks = $('.js-fancybox-link');
      this.anchorLinks = $('.js-anchor-link');
      return this.brandItem = $('.js-brand-item');
    },
    initYandexMap: function() {
      return $.getScript('//api-maps.yandex.ru/2.1/?lang=ru_RU', function() {
        if (window.ymaps) {
          return ymaps.ready(function() {
            var $balloon, myMap, myPlacemark;
            $balloon = $('#balloon');
            myMap = new ymaps.Map('map', {
              center: [47.20958, 38.935194],
              zoom: 16
            });
            myPlacemark = new ymaps.Placemark([47.204529, 38.940342], {
              balloonContent: $balloon.html(),
              hintContent: $balloon.data('name')
            }, {
              balloonCloseButton: false,
              iconImageHref: '/img/r-icon-pin.png',
              iconImageSize: [28, 37]
            });
            return myMap.geoObjects.add(myPlacemark);
          });
        }
      });
    },
    initSlider: function() {
      this.mainSlider.slick({
        dots: false,
        infinite: true,
        slidesToShow: 1
      });
      return this.mainSliderIcon.on('click', function() {
        return $(this).closest('.js-main-slider-item').find('.js-main-slider-tip').toggleClass('_active');
      });
    },
    initFancybox: function() {
      return this.fancyboxLinks.on('click', function(e) {
        e.preventDefault();
        return $.fancybox({
          href: $(this).attr('href'),
          width: 'auto',
          height: 'auto',
          padding: 0,
          autoSize: true,
          autoResize: true,
          scrolling: 'no',
          helpers: {
            overlay: {
              locked: true
            }
          },
          close: [27]
        });
      });
    },
    initAnchorLinks: function() {
      return this.anchorLinks.on('click', function(e) {
        e.preventDefault();
        return $('html, body').animate({
          scrollTop: $($(this).attr('href')).offset().top - 100
        });
      });
    },
    initBrandItems: function() {
      $('.js-brand-table-close').on('click', function(e) {
        e.preventDefault();
        $('.js-brand-item').removeClass('_active');
        return $('.js-brand-table').removeClass('_active');
      });
      return this.brandItem.on('click', function(e) {
        e.preventDefault();
        $('.js-brand-item').removeClass('_active');
        $('.js-brand-table').removeClass('_active');
        $(this).addClass('_active');
        return $('.js-brand-table-' + $(this).data('brand')).addClass('_active');
      });
    }
  };
  return app.init();
});
