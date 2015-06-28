$ ->
  app =
    init: ->
      @initCache()
      @initYandexMap()
      @initSlider()
      @initFancybox()
      @initAnchorLinks()
      @initBrandItems()
    initCache: ->
      @map            = $ '#map'
      @mainSlider     = $ '#mainSlider'
      @mainSliderIcon = @mainSlider.find '.js-main-slider-icon'
      @fancyboxLinks  = $ '.js-fancybox-link'
      @anchorLinks    = $ '.js-anchor-link'
      @brandItem      = $ '.js-brand-item'

    initYandexMap: ->
      $.getScript '//api-maps.yandex.ru/2.1/?lang=ru_RU', ->
        if window.ymaps
          ymaps.ready ->
            $balloon = $ '#balloon'
            myMap = new ymaps.Map 'map',
              center: [47.20958, 38.935194]
              zoom: 16
            myPlacemark = new ymaps.Placemark [47.204529, 38.940342],
                balloonContent: $balloon.html()
                hintContent: $balloon.data('name')
              ,
                balloonCloseButton: no
                iconImageHref: '/img/r-icon-pin.png'
                iconImageSize: [28, 37]
            myMap.geoObjects.add myPlacemark
    initSlider: ->
      @mainSlider.slick
        dots: no
        infinite: on
        slidesToShow: 1

      @mainSliderIcon.on 'click', ->
        $(this)
          .closest '.js-main-slider-item'
          .find '.js-main-slider-tip'
          .toggleClass '_active'
    initFancybox: ->
      @fancyboxLinks.on 'click', (e)->
        e.preventDefault()
        $.fancybox
          href:       $(this).attr 'href'
          width:      'auto'
          height:     'auto'
          padding:    0
          autoSize:   on
          autoResize: on
          scrolling:  'no'
          helpers:
              overlay:
                  locked: on
          close  : [27]
    initAnchorLinks: ->
      @anchorLinks.on 'click', (e)->
        e.preventDefault()
        $('html, body').animate
          scrollTop: $($(this).attr 'href').offset().top - 100
    initBrandItems: ->
      $('.js-brand-table-close').on 'click', (e)->
        e.preventDefault()
        $('.js-brand-item').removeClass('_active')
        $('.js-brand-table').removeClass('_active')

      @brandItem.on 'click', (e)->
        e.preventDefault()
        $('.js-brand-item').removeClass('_active')
        $('.js-brand-table').removeClass('_active')
        $(this).addClass('_active')
        $('.js-brand-table-' + $(this).data('brand')).addClass('_active')


  app.init()
