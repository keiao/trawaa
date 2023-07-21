{#/*============================================================================
    #Specific store JS functions: product variants, cart, shipping, etc
==============================================================================*/#}

{#/*============================================================================

  Table of Contents

  	#Lazy load
  	#Notificactions
    #Accordions
    #Modals
    #Cards
    #Links
  	#Header and nav
        // Nav
        // Search suggestions
        // Lang select
	#Sliders
	  	// Home slider
	  	// Banner services slider
	#Social
		// Youtube or Vimeo video
        // Facebook login
	#Product grid
		// Show filters
		// Sort by
		// Infinite scroll
	#Product detail functions
		// Installments
		// Change Variant
		// Submit to contact form
		// Product labels on variant change
		// Color and size variants change
		// Custom mobile variants change
		// Submit to contact
		// Product slider
		// Pinterest sharing
		// Add to cart
		// Product quantity
	#Cart
		// Free shipping bar
		// Toggle cart 
		// Add to cart
		// Cart quantitiy changes
		// Empty cart alert
		// Go to checkout
	#Shipping calculator
		// Select and save shipping function
		// Calculate shipping function
		// Calculate shipping by submit
		// Shipping and branch click
		// Select shipping first option on results
		// Toggle branches link
		// Toggle more shipping options
		// Calculate shipping on page load
		// Shipping provinces
		// Change store country
    #Forms
    #Footer
    #Empty placeholders

==============================================================================*/#}
// Move to our_content
window.urls = {
    "shippingUrl": "{{ store.shipping_calculator_url | escape('js') }}"
}

{#/*============================================================================
  #Lazy load
==============================================================================*/ #}

document.addEventListener('lazybeforeunveil', function(e){
    if ((e.target.parentElement) && (e.target.nextElementSibling)) {
        var parent = e.target.parentElement;
        var sibling = e.target.nextElementSibling;
        if (sibling.classList.contains('js-lazy-loading-preloader')) {
            sibling.style.display = 'none';
            parent.style.display = 'block';
        }
    }
});


window.lazySizesConfig = window.lazySizesConfig || {};
lazySizesConfig.hFac = 0.4;


DOMContentLoaded.addEventOrExecute(() => {

	{#/*============================================================================
	  #Notifications
	==============================================================================*/ #}

    {# Notifications variables #}

    var $notification_status_page = jQueryNuvem(".js-notification-status-page");
    var $notification_order_cancellation = jQueryNuvem(".js-notification-order-cancellation");
    var $fixed_bottom_button = jQueryNuvem(".js-btn-fixed-bottom");

	{# /* // Close notification */ #}

    jQueryNuvem(".js-notification-close").on( "click", function(e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).closest(".js-notification").hide();
    });


    {# /* // Follow order status notification */ #}
    
    if ($notification_status_page.length > 0){
        if (LS.shouldShowOrderStatusNotification($notification_status_page.data('url'))){
            $notification_status_page.show();
        };
        jQueryNuvem(".js-notification-status-page-close").on( "click", function(e) {
            e.preventDefault();
            LS.dontShowOrderStatusNotificationAgain($notification_status_page.data('url'));
        });
    }

    {# /* // Follow order cancellation notification */ #}
    
    if ($notification_order_cancellation.length > 0){
        if (LS.shouldShowOrderCancellationNotification($notification_order_cancellation.data('url'))){
            {% if not params.preview %}
                {# Show order cancellation notification only if cookie banner is not visible #}

                if (window.cookieNotificationService.isAcknowledged()) {
            {% endif %}
                    $notification_order_cancellation.show();
            {% if not params.preview %}
                }
            {% endif %}
            $fixed_bottom_button.css("marginBottom", "40px");
        };
        jQueryNuvem(".js-notification-order-cancellation-close").on( "click", function(e) {
            e.preventDefault();
            LS.dontShowOrderCancellationNotification($notification_order_cancellation.data('url'));
        });
    }

    {# /* // Cart notification: Dismiss notification */ #}

    jQueryNuvem(".js-cart-notification-close").on("click", function(){
        jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
        setTimeout(function(){
            jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
            jQueryNuvem(".js-alert-added-to-cart").hide();
        },2000);
    });

    {% if not settings.head_fix %}

        {# /* // Add to cart notification on non fixed header */ #}

        var headHeight = jQueryNuvem(".js-head-main").outerHeight();
        var $addedToCartNotification = jQueryNuvem(".js-alert-added-to-cart");

        $addedToCartNotification.css("top" , headHeight.toString() + 'px');

        !function() {
            window.addEventListener("scroll", function () {
                if (window.pageYOffset == 0) {
                    $addedToCartNotification.css("top" , headHeight.toString() + 'px').addClass("notification-with-arrow");
                } else {
                    $addedToCartNotification.css("top" , "-1px");
                }
            });
        }();

    {% endif %}

    {% if not params.preview %}

        {# /* // Cookie banner notification */ #}

        restoreNotifications = function(){

            // Whatsapp button position
            if (window.innerWidth < 768) {
                $fixed_bottom_button.css("marginBottom", "10px");
            }

            {# Restore notifications when Cookie Banner is closed #}

            var show_order_cancellation = ($notification_order_cancellation.length > 0) && (LS.shouldShowOrderCancellationNotification($notification_order_cancellation.data('url')));

            {% if store.country == 'AR' %}
                {# Order cancellation #}
                if (show_order_cancellation){
                    $notification_order_cancellation.show();
                    $fixed_bottom_button.css("marginBottom", "40px");
                }
            {% endif %}
        };

        if (!window.cookieNotificationService.isAcknowledged()) {
            jQueryNuvem(".js-notification-cookie-banner").show();

            {# Whatsapp button position #}
            if (window.innerWidth < 768) {
                $fixed_bottom_button.css("marginBottom", "120px");
            }
        }

        jQueryNuvem(".js-acknowledge-cookies").on( "click", function(e) {
            window.cookieNotificationService.acknowledge();
            restoreNotifications();
        });

    {% endif %}

    {#/*============================================================================
      #Accordions
    ==============================================================================*/ #}

    jQueryNuvem(document).on("click", ".js-accordion-toggle", function(e) {
        e.preventDefault();
        if(jQueryNuvem(this).hasClass("js-accordion-show-only")){
            jQueryNuvem(this).hide();
        }else{
            jQueryNuvem(this).find(".js-accordion-toggle-inactive").toggle();
            jQueryNuvem(this).find(".js-accordion-toggle-active").toggle();
        }
        jQueryNuvem(this).prev(".js-accordion-container").slideToggle().removeClass("d-none");
    });

    {#/*============================================================================
      #Modals
    ==============================================================================*/ #}

    {# Full screen mobile modals back events #}

    if (window.innerWidth < 768) {

        {# Clean url hash function #}

        cleanURLHash = function(){
            const uri = window.location.toString();
            const clean_uri = uri.substring(0, uri.indexOf("#"));
            window.history.replaceState({}, document.title, clean_uri);
        };

        {# Go back 1 step on browser history #}

        goBackBrowser = function(){
            cleanURLHash();
            history.back();
        };

        {# Clean url hash on page load: All modals should be closed on load #}

        if(window.location.href.indexOf("modal-fullscreen") > -1) {
            cleanURLHash();
        }

        {# Open full screen modal and url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-open", function(e) {
            e.preventDefault();
            var modal_url_hash = jQueryNuvem(this).data("modalUrl");
            window.location.hash = modal_url_hash;
        });

        {# Close full screen modal: Remove url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-close", function(e) {
            e.preventDefault();
            goBackBrowser();
        });

        {# Hide panels or modals on browser backbutton #}

        window.onhashchange = function() {
            if(window.location.href.indexOf("modal-fullscreen") <= -1) {

                {# Close opened modal #}

                if(jQueryNuvem(".js-fullscreen-modal").hasClass("modal-show")){

                    {# Remove body lock only if a single modal is visible on screen #}

                    if(jQueryNuvem(".js-modal.modal-show").length == 1){
                        jQueryNuvem("body").removeClass("overflow-none");
                    }

                    var $opened_modal = jQueryNuvem(".js-fullscreen-modal.modal-show");
                    var $opened_modal_overlay = $opened_modal.prev();

                    $opened_modal.removeClass("modal-show");
                    setTimeout(() => $opened_modal.hide(), 500);
                    $opened_modal_overlay.fadeOut(500);
                }
            }
        }

    }

    jQueryNuvem(document).on("click", ".js-modal-open", function(e) {
        e.preventDefault(); 
        var modal_id = jQueryNuvem(this).data('toggle');
        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="' + modal_id + '"]');
        if (jQueryNuvem(modal_id).hasClass("modal-show")) {
            let modal = jQueryNuvem(modal_id).removeClass("modal-show");
            setTimeout(() => modal.hide(), 500);
        } else {
            if (jQueryNuvem(modal_id).hasClass("modal-context-md") && window.innerWidth > 768) {
                jQueryNuvem(modal_id).show().addClass("modal-show");
            } else {

                {# Lock body scroll if there is no modal visible on screen #}
                
                if(!jQueryNuvem(".js-modal.modal-show").length){
                    jQueryNuvem("body").addClass("overflow-none");
                }
                $overlay_id.fadeIn(400);
                jQueryNuvem(modal_id).detach().appendTo("body");
                $overlay_id.detach().insertBefore(modal_id);
                jQueryNuvem(modal_id).show().addClass("modal-show");
            }
            
        }         
    });

    jQueryNuvem(document).on("click", ".js-modal-close", function(e) {
        e.preventDefault();

        {# Remove body lock only if a single modal is visible on screen #}

        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }
        var $modal = jQueryNuvem(this).closest(".js-modal");
        var modal_id = $modal.attr('id');
        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="#' + modal_id + '"]');
        $modal.removeClass("modal-show");
        setTimeout(() => $modal.hide(), 500);
        $overlay_id.fadeOut(500);

        {# Close full screen modal: Remove url hash #}

        if ((window.innerWidth < 768) && (jQueryNuvem(this).hasClass(".js-fullscreen-modal-close"))) {
            goBackBrowser();
        }     
    });

    jQueryNuvem(document).on("click", ".js-modal-overlay", function(e) {
        e.preventDefault();

        {# Remove body lock only if a single modal is visible on screen #}

        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }
        var modal_id = jQueryNuvem(this).data('modalId');
        let modal = jQueryNuvem(modal_id).removeClass("modal-show");
        setTimeout(() => modal.hide(), 500);
        jQueryNuvem(this).fadeOut(500);
    });

    {#/*============================================================================
      #Cards
    ==============================================================================*/ #}
    jQueryNuvem(document).on("click", ".js-card-collapse-toggle", function(e) {
        e.preventDefault();
        jQueryNuvem(this).toggleClass('active');
        jQueryNuvem(this).closest(".js-card-collapse").toggleClass('active');
    });

    {#/*============================================================================
      #Links
    ==============================================================================*/ #}

    jQueryNuvem(".js-toggle").on("click", function(e){
        e.preventDefault();
        jQueryNuvem(e.currentTarget).toggleClass("toggled").trigger('blur');
    });

	{#/*============================================================================
      #Header and nav
    ==============================================================================*/ #}

    {# /* // Header */ #}

    {% if template == 'home' and settings.head_transparent %}
        {% if settings.slider and settings.slider is not empty %}        

            var $swiper_height = window.innerHeight - 100;

            document.addEventListener("scroll", function() {
                if (document.documentElement.scrollTop > $swiper_height ) {
                    jQueryNuvem(".js-head-main").removeClass("head-transparent");
                } else {
                    jQueryNuvem(".js-head-main").addClass("head-transparent");
                }
            });

        {% endif %}
    {% endif %}

    {# /* // Nav offset */ #}

    function applyOffset(selector){

        // Get nav height on load
        if (window.innerWidth > 768) {
            var head_height = jQueryNuvem(".js-head-main").height();
            jQueryNuvem(selector).css("paddingTop", head_height.toString() + 'px');
        }else{

            {# On mobile there is no top padding due to position sticky CSS #}
            var head_height = 0;
        }

        // Apply offset nav height on load

        window.addEventListener("resize", function() {

            // Get nav height on resize
            var head_height = jQueryNuvem(".js-head-main").height();

            // Apply offset on resize
            if (window.innerWidth > 768) {
                jQueryNuvem(selector).css("paddingTop", head_height.toString() + 'px');
            }else{

                {# On mobile there is no top padding due to position sticky CSS #}
                jQueryNuvem(selector).removeAttr("style");
            }
        });
    }

    {% if settings.head_fix and ((settings.head_transparent and template != 'home') or (not settings.head_transparent)) %}
        applyOffset(".js-head-offset");
    {% endif %}

    {# /* // Nav */ #}

    var $top_nav = jQueryNuvem(".js-mobile-nav");
    var $page_main_content = jQueryNuvem(".js-main-content");
    var $search_backdrop = jQueryNuvem(".js-search-backdrop");

    $top_nav.addClass("move-down").removeClass("move-up");


    {# Nav subitems #}

    jQueryNuvem(".js-toggle-page-accordion").on("click", function (e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).toggleClass("selected").closest(".js-nav-list-toggle-accordion").next(".js-pages-accordion").slideToggle(300);
    });

    {# /* // Toggle account link */ #}

    jQueryNuvem(document).on("click", ".js-toggle-account", function (e) {
        e.preventDefault();
        jQueryNuvem(".js-account-container").toggleClass("hidden");
        jQueryNuvem(".js-account-arrow").toggleClass("selected");
        jQueryNuvem(".js-toggle-account-container").toggleClass("selected");
    });

    {# /* // Search suggestions */ #}

    LS.search(jQueryNuvem(".js-search-input"), function (html, count) {
        $search_suggests = jQueryNuvem(this).closest(".js-search-container").next(".js-search-suggest");
        if (count > 0) {
            $search_suggests.html(html).show();
        } else {
            $search_suggests.hide();
        }
        if (jQueryNuvem(this).val().length == 0) {
            $search_suggests.hide();
        }
    }, {
        snipplet: 'header/header-search-results.tpl'
    });

    if (window.innerWidth > 768) {

        {# Hide search suggestions if user click outside results #}

        jQueryNuvem("body").on("click", function () {
            jQueryNuvem(".js-search-suggest").hide();
        });

        {# Maintain search suggestions visibility if user click on links inside #}

        jQueryNuvem(document).on("click", ".js-search-suggest a", function () {
            jQueryNuvem(".js-search-suggest").show();
        });
    }

    jQueryNuvem(".js-search-suggest").on("click", ".js-search-suggest-all-link", function (e) {
        e.preventDefault();
        $this_closest_form = jQueryNuvem(this).closest(".js-search-suggest").prev(".js-search-form");
        $this_closest_form.submit();
    });

    {# /* // Lang select */ #}

    jQueryNuvem('.js-lang-select').on("change", function (e) {
        var lang_select_val = jQueryNuvem(e.currentTarget).val();
        var $lang_container = jQueryNuvem(e.currentTarget).closest(".js-languages");
        $lang_container.find(".js-" + lang_select_val).get()[0].click();
    });


	{#/*============================================================================
	  #Sliders
	==============================================================================*/ #}

	{% if template == 'home' %}

		{# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {  
            var slider_autoplay = {delay: 6000,};
        } else {
            var slider_autoplay = false;
        }

        {% if params.preview %}
            window.homeSlider = {
                getAutoRotation: function() {
                    return slider_autoplay;
                },
                updateSlides: function(slides) {
                    homeSwiper.removeAllSlides();
                    slides.forEach(function(aSlide){
                        homeSwiper.appendSlide(
                            '<div class="swiper-slide slide-container">' +
                                (aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
                                    '<img src="' + aSlide.src + '" class="slider-image"/>' + 
                                    '<div class="swiper-text swiper-' + aSlide.color + '">' +
                                        {% if settings.theme_variant == 'rounded' %}
                                            (aSlide.description ? '<div class="swiper-description mb-1">' + aSlide.description + '</div>' : '' ) +
                                        {% endif %}
                                        (aSlide.title ? '<div class="swiper-title">' + aSlide.title + '</div>' : '' ) +
                                        {% if settings.theme_variant == 'squared' %}
                                            (aSlide.description ? '<div class="swiper-description mt-4">' + aSlide.description + '</div>' : '' ) +
                                        {% endif %}
                                        (aSlide.button && aSlide.link ? '<div class="btn btn-line btn-small swiper-btn mt-4">' + aSlide.button + '</div>' : '' ) +
                                    '</div>' +
                                (aSlide.link ? '</a>' : '' ) +
                            '</div>'
                        );
                    });

                    {% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}

                    if(!slides.length){
                        jQueryNuvem(".js-home-main-slider-container").addClass("hidden");
                        jQueryNuvem(".js-home-empty-slider-container").removeClass("hidden");
                        jQueryNuvem(".js-home-mobile-slider-visibility").removeClass("d-md-none");
                        {% if has_mobile_slider %}
                            jQueryNuvem(".js-home-main-slider-visibility").removeClass("d-none d-md-block");
                            homeMobileSwiper.update();
                        {% endif %}
                    }else{
                        jQueryNuvem(".js-home-main-slider-container").removeClass("hidden");
                        jQueryNuvem(".js-home-empty-slider-container").addClass("hidden");
                        jQueryNuvem(".js-home-mobile-slider-visibility").addClass("d-md-none");
                        {% if has_mobile_slider %}
                            jQueryNuvem(".js-home-main-slider-visibility").addClass("d-none d-md-block");
                        {% endif %}
                    }
                },
                changeAutoRotation: function(){

                },
            };

        {% endif %}

        {# Slider options #}

        var preloadImagesValue = false;
        var lazyValue = true;
        var loopValue = true;
        var watchOverflowValue = true;
        var paginationClickableValue = true;

        var homeSwiper = null;
        createSwiper(
            '.js-home-slider',
            {
                preloadImages: preloadImagesValue,
                lazy: lazyValue,
                {% if settings.slider | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                watchOverflow: watchOverflowValue,
                pagination: {
                    el: '.js-swiper-home-pagination',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next',
                    prevEl: '.js-swiper-home-prev',
                },
            },
            function(swiperInstance) {
                homeSwiper = swiperInstance;
            }
        );

        var homeMobileSwiper = null;
        createSwiper(
            '.js-home-slider-mobile',
            {
                preloadImages: preloadImagesValue,
                lazy: lazyValue,
                {% if settings.slider | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                watchOverflow: watchOverflowValue,
                pagination: {
                    el: '.js-swiper-home-pagination-mobile',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next-mobile',
                    prevEl: '.js-swiper-home-prev-mobile',
                },
            },
            function(swiperInstance) {
                homeMobileSwiper = swiperInstance;
            }
        );


        {% if sections.slider.products %}

                var width = window.innerWidth;
                if (width > 767) {  
                    var productsqty = 3;
                } else {
                    var productsqty = 1;
                }

            window.swiperLoader('.js-swiper-featured', {
                slidesPerView: {% if settings.theme_variant == 'squared' %} 1{% else %} productsqty{% endif %},
                watchOverflow: true,
                threshold: 5,
                pagination: {
                    el: '.js-swiper-featured-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-featured-next',
                    prevEl: '.js-swiper-featured-prev',
                },
            });

        {% endif %}

	{% endif %}

    {% if template == 'product' %}

        {# /* // Product Related */ #}

            {% set columns = settings.grid_columns %}
            createSwiper('.js-swiper-related', {
                slidesPerView: 1,
                watchOverflow: true,
                threshold: 5,
                pagination: {
                    el: '.js-swiper-related-pagination',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-related-next',
                    prevEl: '.js-swiper-related-prev',
                },
                breakpoints: {
                    640: {
                        slidesPerView: {% if columns == 2 %}2{% elseif columns == 3 %}3{% else %}4{% endif %},
                    }
                }
            });

    {% endif %}



	{% set has_banner_services = settings.banner_services %}

	{% if has_banner_services %}

    	{# /* // Banner services slider */ #}

        window.swiperLoader('.js-informative-banners', {
            slidesPerView: 1,
            watchOverflow: true,
            centerInsufficientSlides: true,
            pagination: {
                el: '.js-informative-banners-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-informative-banners-next',
                prevEl: '.js-informative-banners-prev',
            },
            breakpoints: {
                640: {
                    slidesPerView: 3,
                }
            }
        });

    {% endif %}

	{#/*============================================================================
	  #Social
	==============================================================================*/ #}

    {% if template == 'home' %}
        {% set video_url = settings.video_embed %}
    {% elseif template == 'product' and product.video_url %}
        {% set video_url = product.video_url %}
    {% endif %}

    {% if video_url %}

        {# /* // Youtube or Vimeo video for home or each product */ #}

        LS.loadVideo('{{ video_url }}');
        
    {% endif %}

	{#/*============================================================================
	  #Product grid
	==============================================================================*/ #}

	{% if template == 'category' %}

        {# /* // Filters */ #}

        {# /* // Set sticky filters */ #}

        var head_height = jQueryNuvem(".js-head-main").height();
        jQueryNuvem(".js-sticky-filters").css("position", "sticky").css("top", {% if settings.head_fix %}head_height.toString() + 'px'{% else %}"0px"{% endif %}).css("zIndex", 1000);

        window.addEventListener("resize", function() {
            var head_height = jQueryNuvem(".js-head-main").height();
            jQueryNuvem(".js-sticky-filters").css("position", "sticky").css("top", {% if settings.head_fix %}head_height.toString() + 'px'{% else %}"0px"{% endif %}).css("zIndex", 1000);
        });

        var head_height = jQueryNuvem(".js-head-main").height();

        jQueryNuvem(".js-sticky-filters").css("position", "sticky").css("top", {% if settings.head_fix %}head_height.toString() + 'px'{% else %}"0px"{% endif %}).css("zIndex", 1000);

        {# /* // Filter apply and remove */ #}

        jQueryNuvem(document).on("click", ".js-apply-filter, .js-remove-filter", function(e) {
            e.preventDefault();
            var filter_name = jQueryNuvem(this).data('filterName');
            var filter_value = jQueryNuvem(this).attr('data-filter-value');
            if(jQueryNuvem(this).hasClass("js-apply-filter")){
                jQueryNuvem(this).find("[type=checkbox]").prop("checked", true);
                LS.urlAddParam(
                    filter_name, 
                    filter_value, 
                    true
                );
            }else{
                jQueryNuvem(this).find("[type=checkbox]").prop("checked", false);
                LS.urlRemoveParam(
                    filter_name, 
                    filter_value
                );   
            }
            {# Toggle class to avoid adding double parameters in case of double click and show applying changes feedback #}

            if (jQueryNuvem(this).hasClass("js-filter-checkbox")){
                if (window.innerWidth < 768) {
                    jQueryNuvem(".js-filters-overlay").show();
                    if(jQueryNuvem(this).hasClass("js-apply-filter")){
                        jQueryNuvem(".js-applying-filter").show();
                    }else{
                        jQueryNuvem(".js-removing-filter").show();
                    }
                }
                jQueryNuvem(this).toggleClass("js-apply-filter js-remove-filter");
            }
        });

        jQueryNuvem(document).on("click", ".js-remove-all-filters", function(e) {
            e.preventDefault();
            LS.urlRemoveAllParams();
        });

		{# /* // Sort by */ #}

        jQueryNuvem('.js-sort-by').on("change", function (e) {
            var params = LS.urlParams;
            params['sort_by'] = jQueryNuvem(e.currentTarget).val();
            var sort_params_array = [];
            for (var key in params) {
                if (!['results_only', 'page'].includes(key)) {
                    sort_params_array.push(key + '=' + params[key]);
                }
            }
            var sort_params = sort_params_array.join('&');
            window.location = window.location.pathname + '?' + sort_params;
        });

	{% endif %}

    {% if template == 'category' or template == 'search' %}

        !function() {

        	{# /* // Infinite scroll */ #}

            {% if pages.current == 1 and not pages.is_last %}
                LS.hybridScroll({
                    productGridSelector: '.js-product-table',
                    spinnerSelector: '#js-infinite-scroll-spinner',
                    loadMoreButtonSelector: '.js-load-more',
                    hideWhileScrollingSelector: ".js-hide-footer-while-scrolling",
                    productsBeforeLoadMoreButton: 50,
                    productsPerPage: 12
                });
            {% endif %}
        }();

	{% endif %}

    {# /* // Quickshop */ #}

    jQueryNuvem(document).on("click", ".js-item-buy-open", function(e) {
        e.preventDefault();
        {% if settings.theme_variant == 'squared' %}
            jQueryNuvem(this).next('.js-item-variants').slideToggle(300);
        {% else %}
            jQueryNuvem(this).next('.js-item-variants').slideToggle(300).toggleClass("visible");
        {% endif %}
    });

    {% if settings.product_color_variants %}

        {# Product color variations #}

        jQueryNuvem(document).on("click", ".js-color-variant", function(e) {
            e.preventDefault();
            $this = jQueryNuvem(this);
            $this.siblings().removeClass("selected");
            $this.addClass("selected");
            var option_id = $this.data('option');
            $selected_option = $this.closest('.js-item-product').find('.js-variation-option option').filter(function(el) {
                return el.value == option_id;
            });
            $selected_option.prop('selected', true).trigger('change');
            var available_variant = jQueryNuvem(this).closest(".js-quickshop-container").data('variants');

            var available_variant_color = jQueryNuvem(this).closest('.js-color-variant-active').data('option');

            for (var variant in available_variant) {
                if (option_id == available_variant[variant]['option'+ available_variant_color ]) {
                    if (available_variant[variant]['stock'] == null || available_variant[variant]['stock'] > 0 ) {
                        var otherOptions = getOtherOptionNumbers(available_variant_color);
                        var otherOption = available_variant[variant]['option' + otherOptions[0]];
                        var anotherOption = available_variant[variant]['option' + otherOptions[1]];
                        changeSelect(jQueryNuvem(this), otherOption, otherOptions[0]);
                        changeSelect(jQueryNuvem(this), anotherOption, otherOptions[1]);
                        break;
                    }
                }
            }

            $this.siblings().removeClass("selected");
            $this.addClass("selected");
        });

        function getOtherOptionNumbers(selectedOption) {
            switch (selectedOption) {
                case 0:
                    return [1, 2];
                case 1:
                    return [0, 2];
                case 2:
                    return [0, 1];
            }
        }

        function changeSelect(element, optionToSelect, optionIndex) {
            if (optionToSelect != null) {
                var selected_option_attribute = element.closest('.js-item-product').find('.js-color-variant-available-' + (optionIndex + 1)).data('value');
                var selected_option = element.closest('.js-item-product').find('#' + selected_option_attribute + " option").filter(function(el) {
                    return el.value == optionToSelect;
                });

                selected_option.prop('selected', true).trigger('change');
            }
        }
    {% endif %}

    {% if settings.quick_shop or settings.product_color_variants %}

        LS.registerOnChangeVariant(function(variant){
            {# Show product image on color change #}
            var current_image = jQueryNuvem('.js-item-product[data-product-id="'+variant.product_id+'"] .js-item-image');
            current_image.attr('srcset', variant.image_url);
        });

    {% endif %}

    {#/*============================================================================
	  #Product detail functions
	==============================================================================*/ #}

	{# /* // Installments */ #}

	{# Installments without interest #}

	function get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests) {
	    if (parseInt(number_of_installment) > parseInt(max_installments_without_interests[0])) {
	        if (installment_data.without_interests) {
	            return [number_of_installment, installment_data.installment_value.toFixed(2)];
	        }
	    }
	    return max_installments_without_interests;
	}

	{# Installments with interest #}

	function get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests) {
	    if (parseInt(number_of_installment) > parseInt(max_installments_with_interests[0])) {
	        if (installment_data.without_interests == false) {
	            return [number_of_installment, installment_data.installment_value.toFixed(2)];
	        }
	    }
	    return max_installments_with_interests;
	}

	{# Refresh installments inside detail popup #}

	function refreshInstallmentv2(price){
        jQueryNuvem(".js-modal-installment-price" ).each(function( el ) {
	        const installment = Number(jQueryNuvem(el).data('installment'));
            jQueryNuvem(el).text(LS.currency.display_short + (price/installment).toLocaleString('de-DE', {maximumFractionDigits: 2, minimumFractionDigits: 2}));
	    });
	}

    {# Refresh price on payments popup with payment discount applied #}

    function refreshPaymentDiscount(price){
        jQueryNuvem(".js-price-with-discount" ).each(function( el ) {
            const payment_discount = jQueryNuvem(el).data('paymentDiscount');
            jQueryNuvem(el).text(LS.formatToCurrency(price - ((price * payment_discount) / 100)))
        });
    }

	{# /* // Change variant */ #}

	{# Updates price, installments, labels and CTA on variant change #}

	function changeVariant(variant){
        jQueryNuvem(".js-product-detail .js-shipping-calculator-response").hide();
        jQueryNuvem("#shipping-variant-id").val(variant.id);

	    var parent = jQueryNuvem("body");
	    if (variant.element){
	        parent = jQueryNuvem(variant.element);
	    }

	    var sku = parent.find('#sku');
	    if(sku.length) {
	        sku.text(variant.sku).show();
	    }

	    {% if settings.product_stock %}
	        var stock = parent.find('.js-product-stock');
	        stock.text(variant.stock).show();
	    {% endif %}

	    var installment_helper = function($element, amount, price){
	        $element.find('.js-installment-amount').text(amount);
	        $element.find('.js-installment-price').attr("data-value", price);
	        $element.find('.js-installment-price').text(LS.currency.display_short + parseFloat(price).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        if(variant.price_short && Math.abs(variant.price_number - price * amount) < 1) {
	            $element.find('.js-installment-total-price').text((variant.price_short).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        } else {
	            $element.find('.js-installment-total-price').text(LS.currency.display_short + (price * amount).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        }
	    };

	    if (variant.installments_data) {
	        var variant_installments = JSON.parse(variant.installments_data);
	        var max_installments_without_interests = [0,0];
	        var max_installments_with_interests = [0,0];
	        for (let payment_method in variant_installments) {
                let installments = variant_installments[payment_method];
                for (let number_of_installment in installments) {
                    let installment_data = installments[number_of_installment];

	                max_installments_without_interests = get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests);
	                max_installments_with_interests = get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests);
	                var installment_container_selector = '#installment_' + payment_method + '_' + number_of_installment;

	                if(!parent.hasClass("js-quickshop-container")){
	                    installment_helper(jQueryNuvem(installment_container_selector), number_of_installment, installment_data.installment_value.toFixed(2));
	                }
	            }
	        }
	        var $installments_container = jQueryNuvem(variant.element + ' .js-max-installments-container .js-max-installments');
	        var $installments_modal_link = jQueryNuvem(variant.element + ' #btn-installments');
	        var $payments_module = jQueryNuvem(variant.element + ' .js-product-payments-container');
	        var $installmens_card_icon = jQueryNuvem(variant.element + ' .js-installments-credit-card-icon');

	        {% if product.has_direct_payment_only %}
	        var installments_to_use = max_installments_without_interests[0] >= 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 0 ) {
	        {%  else %}
	        var installments_to_use = max_installments_without_interests[0] > 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 1 ) {
	        {% endif %}
	            $installments_container.hide();
	            $installments_modal_link.hide();
	            $payments_module.hide();
	            $installmens_card_icon.hide();
	        } else {
	            $installments_container.show();
	            $installments_modal_link.show();
	            $payments_module.show();
	            $installmens_card_icon.show();
	            installment_helper($installments_container, installments_to_use[0], installments_to_use[1]);
	        }
	    }

	    if(!parent.hasClass("js-quickshop-container")){
            jQueryNuvem('#installments-modal .js-installments-one-payment').text(variant.price_short).attr("data-value", variant.price_number);
		}
	    
		if (variant.price_short){
			var variant_price_clean = variant.price_short.replace('$', '').replace('R', '').replace(',', '').replace('.', '');
			var variant_price_raw = parseInt(variant_price_clean, 10);

			parent.find('.js-price-display').text(variant.price_short).show();
			parent.find('.js-price-display').attr("content", variant.price_number).data('productPrice', variant_price_raw);
		} else {
	        parent.find('.js-price-display').hide();
	    }

	    if ((variant.compare_at_price_short) && !(parent.find(".js-price-display").css("display") == "none")) {
	        parent.find('.js-compare-price-display').text(variant.compare_at_price_short).show();
	    } else {
	        parent.find('.js-compare-price-display').hide();
	    }

	    var button = parent.find('.js-addtocart');
	    button.removeClass('cart').removeClass('contact').removeClass('nostock');
	    var $product_shipping_calculator = parent.find("#product-shipping-container");
	    {% if not store.is_catalog %}
	    if (!variant.available){
	        button.val('{{ "Sin stock" | translate }}');
	        button.addClass('nostock');
	        button.attr('disabled', 'disabled');
	        $product_shipping_calculator.hide();
	    } else if (variant.contact) {
	        button.val('{{ "Consultar precio" | translate }}');
	        button.addClass('contact');
	        button.removeAttr('disabled');
	        $product_shipping_calculator.hide();
	    } else {
	        button.val('{{ "Agregar al carrito" | translate }}');
	        button.addClass('cart');
	        button.removeAttr('disabled');
	        $product_shipping_calculator.show();
	    }

	    {% endif %}

        {% if template == 'product' %}
            const base_price = Number(jQueryNuvem("#price_display").attr("content"));
            refreshInstallmentv2(base_price);
            refreshPaymentDiscount(variant.price_number);
        {% endif %}
    
        {# Update shipping on variant change #}

        LS.updateShippingProduct();

        zipcode_on_changevariant = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
        jQueryNuvem("#product-shipping-container .js-shipping-calculator-current-zip").text(zipcode_on_changevariant);

        {% if cart.free_shipping.min_price_free_shipping.min_price %}
            {# Updates free shipping bar #}

            LS.freeShippingProgress(true);

        {% endif %}

	}

	{# /* // Product labels on variant change */ #}

    
	{# Stock, Offer and discount labels update #}

    jQueryNuvem(document).on("change", ".js-variation-option", function(e) {
        var $parent = jQueryNuvem(this).closest(".js-product-variants");
        var $variants_group = jQueryNuvem(this).closest(".js-product-variants-group");
        var quick_id = jQueryNuvem(this).closest(".js-quickshop-container").attr("id");
        if($parent.hasClass("js-product-quickshop-variants")){
            LS.changeVariant(changeVariant, '#' + quick_id);

            {% if settings.product_color_variants %}
                {# Match selected color variant with selected quickshop variant #}

                if(($variants_group).hasClass("js-color-variants-container")){
                    var selected_option_id = jQueryNuvem(this).find("option").filter((el) => el.selected).val();
                    jQueryNuvem('#' + quick_id).find('.js-color-variant').removeClass("selected");
                    jQueryNuvem('#' + quick_id).find('.js-color-variant[data-option="'+selected_option_id+'"]').addClass("selected");
                }
            {% endif %} 
        } else {
            LS.changeVariant(changeVariant, '#single-product');
        }

        {# Offer and discount labels update #}

        var $this_product_container = jQueryNuvem(this).closest(".js-product-container");
        var $this_compare_price = $this_product_container.find(".js-compare-price-display");
        var $this_price = $this_product_container.find(".js-price-display");
        var $installment_container = $this_product_container.find(".js-product-payments-container");
        var $installment_text = $this_product_container.find(".js-max-installments-container");
        var $this_add_to_cart = $this_product_container.find(".js-prod-submit-form");

        // Get the current product discount percentage value
        var current_percentage_value = $this_product_container.find(".js-offer-percentage");

        // Get the current product price and promotional price
        var compare_price_value = $this_compare_price.html();
        var price_value = $this_price.html();

        // Calculate new discount percentage based on difference between filtered old and new prices
        const percentageDifference = window.moneyDifferenceCalculator.percentageDifferenceFromString(compare_price_value, price_value);
        if(percentageDifference){
            $this_product_container.find(".js-offer-percentage").text(percentageDifference);
            $this_product_container.find(".js-offer-label").css("display" , "table");
        }

	    if ($this_compare_price.css("display") == "none" || !percentageDifference) {
	        $this_product_container.find(".js-offer-label").hide();
	    }

	    if ($this_add_to_cart.hasClass("nostock")) {
	        $this_product_container.find(".js-stock-label").show();
	    }
	    else {
	        $this_product_container.find(".js-stock-label").hide();
	    }
	    if ($this_price.css('display') == 'none'){
	        $installment_container.hide();
	        $installment_text.hide();
	    }else{
	        $installment_text.show();
	    }
	});

	{# /* // Submit to contact */ #}

	{# Submit to contact form when product has no price #}

    jQueryNuvem(".js-product-form").on("submit", function (e) {
	    var button = jQueryNuvem(e.currentTarget).find('[type="submit"]');
	    button.attr('disabled', 'disabled');
	    if ((button.hasClass('contact')) || (button.hasClass('catalog'))) {
	        e.preventDefault();
	        var product_id = jQueryNuvem(e.currentTarget).find("input[name='add_to_cart']").val();
	        window.location = "{{ store.contact_url | escape('js') }}?product=" + product_id;
	    } else if (button.hasClass('cart')) {
	        button.val('{{ "Agregando..." | translate }}');
	    }
	});

	{% if template == 'product' %}

	    {# /* // Product slider */ #}

        {% set has_multiple_slides = product.images_count > 1 or video_url %}

        var productSwiper = null;

        function productSliderNav() {
            createSwiper(
                '.js-swiper-product',
                {
                    lazy: true,
                    loop: false,
                    pagination: {
                        el: '.js-swiper-product-pagination',
                        type: 'fraction',
                        clickable: true,
                    },
                    navigation: {
                        nextEl: '.js-swiper-product-next',
                        prevEl: '.js-swiper-product-prev',
                    },
                    on: {
                        init: function () {
                            jQueryNuvem(".js-product-slider-placeholder").hide();
                            jQueryNuvem(".js-swiper-product").css("visibility", "visible").css("height", "auto");
                            {% if product.video_url and settings.theme_variant == 'rounded' %}
                                if (window.innerWidth < 768) {
                            {% endif %}
                                    productSwiperHeight = jQueryNuvem(".js-swiper-product").height();
                                    jQueryNuvem(".js-product-video-slide").height(productSwiperHeight);
                            {% if product.video_url and settings.theme_variant == 'rounded' %}
                                }
                            {% endif %}
                        },
                        {% if product.video_url %}
                            slideChangeTransitionEnd: function () {
                                if(jQueryNuvem(".js-product-video-slide").hasClass("swiper-slide-active")){
                                    jQueryNuvem(".js-labels-group").fadeOut(100);
                                }else{
                                    jQueryNuvem(".js-labels-group").fadeIn(100);
                                }
                                jQueryNuvem('.js-video').show();
                                jQueryNuvem('.js-video-iframe').hide().find("iframe").remove();
                            },
                        {% endif %}
                    },
                },
                function (swiperInstance) {
                    productSwiper = swiperInstance;
                }
            );

            {% if has_multiple_slides %}
                LS.registerOnChangeVariant(function(variant){
                    var liImage = jQueryNuvem('.js-swiper-product').find("[data-image='"+variant.image+"']");
                    var selectedPosition = liImage.data('imagePosition');
                    var slideToGo = parseInt(selectedPosition);
                    productSwiper.slideTo(slideToGo);
                    jQueryNuvem(".js-product-slide-img").removeClass("js-active-variant");
                    liImage.find(".js-product-slide-img").addClass("js-active-variant");
                });
                
                jQueryNuvem(".js-product-thumb").on("click", function(e){
                    e.preventDefault();
                    var current_thumb_index = jQueryNuvem(e.currentTarget).attr("data-slide-index");
                    var match_thumb_image = jQueryNuvem('.js-swiper-product').find("[data-image-position='"+current_thumb_index+"']");
                    var selectedPosition = match_thumb_image.attr("data-image-position");
                    var slideToGo = parseInt(selectedPosition);
                    productSwiper.slideTo(slideToGo);        
                });
            {% endif %}
        }

        {% if store.useNativeJsLibraries() %}

            Fancybox.bind('[data-fancybox="product-gallery"]', {
                Toolbar: { display: ['counter', 'close'] },
                Thumbs: { autoStart: false },
                on: {
                    shouldClose: (fancybox, slide) => {
                        if (!productSwiper) {
                            return;
                        }

                        // Update position of the slider
                        productSwiper.slideTo( fancybox.getSlide().index, 0 );
                    },
                },
            });

        {% else %}

            $().fancybox({
                selector : '[data-fancybox="product-gallery"]',
                toolbar  : false,
                smallBtn : true,
                beforeClose : function(instance) {
                    if (!productSwiper) {
                        return;
                    }

                    // Update position of the slider
                    productSwiper.slideTo( instance.currIndex, 0 );

                }
            });

        {% endif %}

        {% if  settings.theme_variant == 'squared' %}
            productSliderNav ()
        {% else %}
            if ( window.innerWidth < 768 ) {
                productSliderNav ()
            } else {
                var headHeight = jQueryNuvem(".js-head-main").outerHeight();
                var topOffset = 50;

                jQueryNuvem(".js-sticky-product")
                    .addClass("sticky-product")
                    .css("top" , (headHeight + topOffset).toString() + 'px');

                LS.registerOnChangeVariant(function(variant){
                    var liImage = jQueryNuvem('.js-swiper-product').find("[data-image='"+variant.image+"']");
                    var selectedScroll = liImage.position.top;
                    document.documentElement.scroll({
                        top: jQueryNuvem(liImage).offset().top,
                        behavior: 'smooth'
                    });
                });

                window.addEventListener("resize", function() {
                    if ( window.innerWidth < 768 ) {
                        productSliderNav()
                    }
                });
            }
        {% endif %}

	   
        {# /* // Pinterest sharing */ #}

        jQueryNuvem('.js-pinterest-share').on("click", function(e){
            e.preventDefault();
            jQueryNuvem(".pinterest-hidden a").get()[0].click();
        });

	{% endif %}

    {# Product quantitiy #}

    jQueryNuvem('.js-quantity .js-quantity-up').on('click', function(e) {
        $quantity_input = jQueryNuvem(e.currentTarget).closest(".js-quantity").find(".js-quantity-input");
        $quantity_input.val( parseInt($quantity_input.val(), 10) + 1);
    });

    jQueryNuvem('.js-quantity .js-quantity-down').on('click', function(e) {
        $quantity_input = jQueryNuvem(e.currentTarget).closest(".js-quantity").find(".js-quantity-input");
        quantity_input_val = $quantity_input.val();
        if (quantity_input_val>1) { 
            $quantity_input.val( parseInt($quantity_input.val(), 10) - 1);
        }
    });

	{#/*============================================================================
	  #Cart
	==============================================================================*/ #}

    {# /* // Free shipping bar */ #}

    {% if cart.free_shipping.min_price_free_shipping.min_price %}

        {# Updates free progress on page load #}

        LS.freeShippingProgress(true);

    {% endif %}


    {# /* // Position of cart page summary */ #}

    var head_height = jQueryNuvem(".js-head-main").outerHeight();
    {% if settings.theme_variant == 'rounded' %}
        var top_offset = 50;
    {% else %}
        var top_offset = 10;
    {% endif %}

    if (window.innerWidth > 768) {
        {% if settings.head_fix %}
            jQueryNuvem("#cart-sticky-summary").css("top" , (head_height + top_offset).toString() + 'px');
        {% else %}
            jQueryNuvem("#cart-sticky-summary").css("top" , "10px");
        {% endif %}
    }

    {# /* // Add to cart */ #}

	jQueryNuvem(document).on("click", ".js-addtocart:not(.js-addtocart-placeholder)", function (e) {

        {# Button variables for transitions on add to cart #}

        var $productContainer = jQueryNuvem(this).closest('.js-product-container');
        var $productVariants = $productContainer.find(".js-variation-option");
        var $productButton = $productContainer.find("input[type='submit'].js-addtocart");
        var $productButtonPlaceholder = $productContainer.find(".js-addtocart-placeholder");
        var $productButtonText = $productButtonPlaceholder.find(".js-addtocart-text");
        var $productButtonAdding = $productButtonPlaceholder.find(".js-addtocart-adding");
        var $productButtonSuccess = $productButtonPlaceholder.find(".js-addtocart-success");

        {# Define if event comes from quickshop or product page #}

        var isQuickShop = $productContainer.hasClass('js-quickshop-container');
        var price = $productContainer.find('.js-price-display').text();

        if (!isQuickShop) {
            if(jQueryNuvem(".js-product-slide-img.js-active-variant").length) {
                var imageSrc = $productContainer.find('.js-product-slide-img.js-active-variant').attr('srcset').split(' ')[0];
            } else {
                var imageSrc = $productContainer.find('.js-product-slide-img').attr('srcset').split(' ')[0];
            }
            
            var quantity = jQueryNuvem('.js-quantity-input').val();
            var name = $productContainer.find('.js-product-name').text();
        } else {
            var imageSrc = jQueryNuvem(this).closest('.js-item-product').find('img').attr('srcset').split(' ')[0];
            var quantity = 1;
            var name = $productContainer.find('.js-item-name').text();
        }

        if (!jQueryNuvem(this).hasClass('contact')) {

            {% if settings.ajax_cart %}
                e.preventDefault();
            {% endif %}

            {# Hide real button and show button placeholder during event #}

            $productButton.hide();
            $productButtonPlaceholder.show().addClass("active");
            $productButtonText.fadeOut();
            $productButtonAdding.addClass("active");

            {% if settings.ajax_cart %}
                var callback_add_to_cart = function(){

                    {# Animate cart amount #}

                    jQueryNuvem(".js-cart-widget-amount").addClass("beat");

                    setTimeout(function(){
                        jQueryNuvem(".js-cart-widget-amount").removeClass("beat");
                    },4000);

                    {# Fill notification info #}

                    jQueryNuvem('.js-cart-notification-item-img').attr('src', imageSrc);
                    jQueryNuvem('.js-cart-notification-item-name').text(name);
                    jQueryNuvem('.js-cart-notification-item-quantity').text(quantity);
                    jQueryNuvem('.js-cart-notification-item-price').text(price);

                    if($productVariants.length){
                        var output = [];

                        $productVariants.each( function(el){
                            var variants = jQueryNuvem(el);
                            output.push(variants.val());
                        });
                        jQueryNuvem(".js-cart-notification-item-variant-container").show();
                        jQueryNuvem(".js-cart-notification-item-variant").text(output.join(', '))
                    }else{
                        jQueryNuvem(".js-cart-notification-item-variant-container").hide();
                    }

                    {# Set products amount wording visibility #}

                    var cartItemsAmount = jQueryNuvem(".js-cart-widget-amount").text();

                    if(cartItemsAmount > 1){
                        jQueryNuvem(".js-cart-counts-plural").show();
                        jQueryNuvem(".js-cart-counts-singular").hide();
                    }else{
                        jQueryNuvem(".js-cart-counts-singular").show();
                        jQueryNuvem(".js-cart-counts-plural").hide();
                    }

                    {# Show button placeholder with transitions #}

                    $productButtonAdding.removeClass("active");
                    $productButtonSuccess.addClass("active");
                    setTimeout(function(){
                        $productButtonSuccess.removeClass("active");
                        setTimeout(function(){
                            $productButtonText.fadeIn();
                        },500);
                        $productButtonPlaceholder.removeClass("active");
                    },2000);

                    setTimeout(function(){
                        $productButtonPlaceholder.removeAttr("style").hide();
                        $productButton.show();
                    },4000);

                    $productContainer.find(".js-added-to-cart-product-message").slideDown();
                    
                    if (window.innerWidth > 768) {
                        jQueryNuvem(".js-toggle-cart").trigger('click');
                    }else{
                       {# Show notification and hide it only after second added to cart #}

                       setTimeout(function(){
                            jQueryNuvem(".js-alert-added-to-cart").show().addClass("notification-visible").removeClass("notification-hidden");
                        },500);

                        if (!cookieService.get('first_product_added_successfully')) {
                            cookieService.set('first_product_added_successfully', 1, 7 );
                        } else{
                            setTimeout(function(){
                                jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
                                setTimeout(function(){
                                    jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
                                    jQueryNuvem(".js-alert-added-to-cart").hide();
                                },2000);
                            },8000);
                        }
                    }

                    {# Update shipping input zipcode on add to cart #}

                    {# Use zipcode from input if user is in product page, or use zipcode cookie if is not #}

                    if (jQueryNuvem("#product-shipping-container .js-shipping-input").val()) {
                        zipcode_on_addtocart = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
                        jQueryNuvem("#cart-shipping-container .js-shipping-input").val(zipcode_on_addtocart);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_on_addtocart);
                    } else if (cookieService.get('calculator_zipcode')){
                        var zipcode_from_cookie = cookieService.get('calculator_zipcode');
                        jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);
                    }
                   
                }
                var callback_error = function(){

                    {# Restore real button visibility in case of error #}

                    $productButtonPlaceholder.removeClass("active");
                    $productButtonText.fadeIn("active");
                    $productButtonAdding.removeClass("active");
                    $productButtonPlaceholder.hide();
                    $productButton.show();
                }
                $prod_form = jQueryNuvem(this).closest("form");
                LS.addToCartEnhanced(
                    $prod_form,
                    '{{ "Agregar al carrito" | translate }}',
                    '{{ "Agregando..." | translate }}',
                    '{{ "¡Uy! No tenemos más stock de este producto para agregarlo al carrito." | translate }}',
                    {{ store.editable_ajax_cart_enabled ? 'true' : 'false' }},
                        callback_add_to_cart,
                        callback_error
                );
            {% endif %}
        }
    });


    {# /* // Cart quantitiy changes */ #}

    jQueryNuvem(document).on("keypress", ".js-cart-quantity-input", function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    jQueryNuvem(document).on("focusout", ".js-cart-quantity-input", function (e) {
        var itemID = jQueryNuvem(this).attr("data-item-id");
        var itemVAL = jQueryNuvem(this).val();
        if (itemVAL == 0) {
            var r = confirm("{{ '¿Seguro que quieres borrar este artículo?' | translate }}");
            if (r == true) {
                LS.removeItem(itemID, true);
            } else {
                jQueryNuvem(this).val(1);
            }
        } else {
            LS.changeQuantity(itemID, itemVAL, true);
        }
    });

    {# /* // Empty cart alert */ #}

    jQueryNuvem(".js-trigger-empty-cart-alert").on("click", function (e) {
        e.preventDefault();
        let emptyCartAlert = jQueryNuvem(".js-mobile-nav-empty-cart-alert").fadeIn(100);
        setTimeout(() => emptyCartAlert.fadeOut(500), 1500);
    });

    {# /* // Go to checkout */ #}

    {# Clear cart notification cookie after consumers continues to checkout #}

    jQueryNuvem('form[action="{{ store.cart_url | escape('js') }}"]').on("submit", function() {
        cookieService.remove('first_product_added_successfully');
    }); 

	{#/*============================================================================
	  #Shipping calculator
	==============================================================================*/ #}

    if (jQueryNuvem('.js-selected-shipping-method').length) {
        var shipping_cost = jQueryNuvem('.js-selected-shipping-method').data("cost");
        var $shippingCost = jQueryNuvem("#shipping-cost");
        $shippingCost.text(shipping_cost);
        $shippingCost.removeClass('opacity-40');
    }
    
    {# /* // Select and save shipping function */ #}

    selectShippingOption = function(elem, save_option) {
        jQueryNuvem(".js-shipping-method, .js-branch-method").removeClass('js-selected-shipping-method');
        jQueryNuvem(elem).addClass('js-selected-shipping-method');

        var shipping_cost = jQueryNuvem(elem).data("cost");
        var shipping_price_clean = jQueryNuvem(elem).data("price");

        if(shipping_price_clean = 0.00){
            var shipping_cost = '{{ Gratis | translate }}'
        }

        // Updates shipping (ship and pickup) cost on cart
        var $shippingCost = jQueryNuvem("#shipping-cost");
        $shippingCost.text(shipping_cost);
        $shippingCost.removeClass('opacity-40');
        // TODO we need to clear the shipping cost if there is no selected option (white recalculating)

        if (save_option) {
            LS.saveCalculatedShipping(true);
        }
        if(jQueryNuvem(elem).hasClass("js-shipping-method-hidden")){

            {# Toggle other options visibility depending if they are pickup or delivery for cart and product at the same time #}

            if(jQueryNuvem(elem).hasClass("js-pickup-option")){
                jQueryNuvem(".js-other-pickup-options, .js-show-other-pickup-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-more").hide();

            }else{
                jQueryNuvem(".js-other-shipping-options, .js-show-more-shipping-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-more").hide()
            }          
        }
    };

    {# Apply zipcode saved by cookie if there is no zipcode saved on cart from backend #}

    if (cookieService.get('calculator_zipcode')) {

        {# If there is a cookie saved based on previous calcualtion, add it to the shipping input to triggert automatic calculation #}

        var zipcode_from_cookie = cookieService.get('calculator_zipcode');

        {% if settings.ajax_cart %}

            {# If ajax cart is active, target only product input to avoid extra calulation on empty cart #}

            jQueryNuvem('#product-shipping-container .js-shipping-input').val(zipcode_from_cookie);

        {% else %}

            {# If ajax cart is inactive, target the only input present on screen #}

            jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);
            
        {% endif %}
        
        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);

        {# Hide the shipping calculator and show spinner  #}

        jQueryNuvem(".js-shipping-calculator-head").addClass("with-zip").removeClass("with-form");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").addClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-spinner").show();
    } else {

        {# If there is no cookie saved, show calcualtor #}

        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    }

    {# Remove shipping suboptions from DOM to avoid duplicated modals #}

    removeShippingSuboptions = function(){
        var shipping_suboptions_id = jQueryNuvem(".js-modal-shipping-suboptions").attr("id");
        jQueryNuvem("#" + shipping_suboptions_id).remove();
        jQueryNuvem('.js-modal-overlay[data-modal-id="#' + shipping_suboptions_id + '"').remove();
    };

    {# /* // Calculate shipping function */ #}

	jQueryNuvem(".js-calculate-shipping").on("click", function (e) {
	    e.preventDefault();

        {# Take the Zip code to all shipping calculators on screen #}
        
        let shipping_input_val = jQueryNuvem(e.currentTarget).closest(".js-shipping-calculator-form").find(".js-shipping-input").val();

        jQueryNuvem(".js-shipping-input").val(shipping_input_val);

        {# Calculate on page load for both calculators: Product and Cart #}

        {% if template == 'product' %}
            if (!vanillaJS) {
                LS.calculateShippingAjax(
                    jQueryNuvem('#product-shipping-container').find(".js-shipping-input").val(),
                    '{{store.shipping_calculator_url | escape('js')}}',
                    jQueryNuvem("#product-shipping-container").closest(".js-shipping-calculator-container") );
            }
        {% endif %}

        if (jQueryNuvem(".js-cart-item").length) {
            LS.calculateShippingAjax(
                jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val(),
                '{{store.shipping_calculator_url | escape('js')}}',
                jQueryNuvem("#cart-shipping-container").closest(".js-shipping-calculator-container") );
        }

        jQueryNuvem(".js-shipping-calculator-current-zip").html(shipping_input_val);
        removeShippingSuboptions();
	});

	{# /* // Calculate shipping by submit */ #}

	jQueryNuvem(".js-shipping-input").on("keydown", function (e) {
	    var key = e.which ? e.which : e.keyCode;
	    var enterKey = 13;
	    if (key === enterKey) {
	        e.preventDefault();
            jQueryNuvem(e.currentTarget).closest(".js-shipping-calculator-form").find(".js-calculate-shipping").trigger('click');
	        if (window.innerWidth < 768) {
	            jQueryNuvem(e.currentTarget).trigger('blur');
	        }
	    }
	});

    {# /* // Shipping and branch click */ #}

    jQueryNuvem(document).on("change", ".js-shipping-method, .js-branch-method", function () {
        selectShippingOption(this, true);
        jQueryNuvem(".js-shipping-method-unavailable").hide();
    });

    {# /* // Select shipping first option on results */ #}

    jQueryNuvem(document).on('shipping.options.checked', '.js-shipping-method', function (e) {
        let shippingPrice = jQueryNuvem(this).attr("data-price");
        LS.addToTotal(shippingPrice);

        let total = (LS.data.cart.total / 100) + parseFloat(shippingPrice);
        jQueryNuvem(".js-cart-widget-total").html(LS.formatToCurrency(total));

        selectShippingOption(this, false);
    });

    {# /* // Toggle branches link */ #}

    jQueryNuvem(document).on("click", ".js-toggle-branches", function (e) {
        e.preventDefault();
        jQueryNuvem(".js-store-branches-container").slideToggle("fast");
        jQueryNuvem(".js-see-branches, .js-hide-branches").toggle();
    });

    {# /* // Toggle more shipping options */ #}

    jQueryNuvem(document).on("click", ".js-toggle-more-shipping-options", function(e) {
        e.preventDefault();

        {# Toggle other options depending if they are pickup or delivery for cart and product at the same time #}

        if(jQueryNuvem(this).hasClass("js-show-other-pickup-options")){
            jQueryNuvem(".js-other-pickup-options").slideToggle(600);
            jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-less, .js-show-other-pickup-options .js-shipping-see-more").toggle();
        }else{
            jQueryNuvem(".js-other-shipping-options").slideToggle(600);
            jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-less, .js-show-more-shipping-options .js-shipping-see-more").toggle();
        }
    });

    {# Only shipping input has value, cart has saved shipping and there is no branch selected #}

    calculateCartShippingOnLoad = function(){

        {# Triggers function when a zipcode input is filled #}

        if(jQueryNuvem("#cart-shipping-container .js-shipping-input").val()){
       
            // If user already had calculated shipping: recalculate shipping

            setTimeout(function() { 
                LS.calculateShippingAjax(
                    jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val(),
                    '{{store.shipping_calculator_url | escape('js')}}',
                    jQueryNuvem("#cart-shipping-container").closest(".js-shipping-calculator-container") );
                    removeShippingSuboptions();
            }, 100);
        } 

        if(jQueryNuvem(".js-branch-method").hasClass('js-selected-shipping-method')){
            {% if store.branches|length > 1 %}
                jQueryNuvem(".js-store-branches-container").slideDown("fast");
                jQueryNuvem(".js-see-branches").hide();
                jQueryNuvem(".js-hide-branches").show();
            {% endif %}
        }
    };

    {% if cart.has_shippable_products %}
        calculateCartShippingOnLoad();
    {% endif %}

    {# /* // Calculate product detail shipping on page load */ #}

    {% if template == 'product' %}
        if (!vanillaJS) {
            if(jQueryNuvem('#product-shipping-container').find(".js-shipping-input").val()){
                setTimeout(function() {
                    LS.calculateShippingAjax(
                        jQueryNuvem('#product-shipping-container').find(".js-shipping-input").val(),
                        '{{store.shipping_calculator_url | escape('js')}}',
                        jQueryNuvem("#product-shipping-container").closest(".js-shipping-calculator-container") );

                    removeShippingSuboptions();
                }, 100);
            }
        }

    {% endif %}

    {# /* // Change CP */ #}

    jQueryNuvem(document).on("click", ".js-shipping-calculator-change-zipcode", function(e) {
        e.preventDefault();
        jQueryNuvem(".js-shipping-calculator-response").fadeOut(100);
        jQueryNuvem(".js-shipping-calculator-head").addClass("with-form").removeClass("with-zip");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").removeClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    }); 

	{# /* // Shipping provinces */ #}

	{% if provinces_json %}
        jQueryNuvem('select[name="country"]').on("change", function (e) {
		    var provinces = {{ provinces_json | default('{}') | raw }};
		    LS.swapProvinces(provinces[jQueryNuvem(e.currentTarget).val()]);
		}).trigger("change");
	{% endif %}

    {# /* // Change store country: From invalid zipcode message */ #}

    jQueryNuvem(document).on("click", ".js-save-shipping-country", function(e) {
        e.preventDefault();
        {# Change shipping country #}

        var selected_country_url = jQueryNuvem(this).closest(".js-modal-shipping-country").find(".js-shipping-country-select option").filter((el) => el.selected).attr("data-country-url");
        location.href = selected_country_url; 

        jQueryNuvem(this).text('{{ "Aplicando..." | translate }}').addClass("disabled");
    });

    {#/*============================================================================
      #Forms
    ==============================================================================*/ #}

    jQueryNuvem(".js-winnie-pooh-form").on("submit", function (e) {
        jQueryNuvem(e.currentTarget).attr('action', '');
    });

    {# Show the success or error message when resending the validation link #}

    {% if template == 'account.register' or template == 'account.login' %}
        jQueryNuvem(".js-resend-validation-link").on("click", function(e){
            window.accountVerificationService.resendVerificationEmail('{{ customer_email }}');
        });
    {% endif %}
    
    jQueryNuvem('.js-password-view').on("click", function (e) {
        jQueryNuvem(e.currentTarget).toggleClass('password-view');

        if(jQueryNuvem(e.currentTarget).hasClass('password-view')){
           jQueryNuvem(e.currentTarget).parent().find(".js-password-input").attr('type', '');
           jQueryNuvem(e.currentTarget).find(".js-eye-open, .js-eye-closed").toggle();
        } else {
           jQueryNuvem(e.currentTarget).parent().find(".js-password-input").attr('type', 'password');
           jQueryNuvem(e.currentTarget).find(".js-eye-open, .js-eye-closed").toggle();
        }
    });

    {#/*============================================================================
      #Footer
    ==============================================================================*/ #}

    {% if store.afip %}

        {# Add alt attribute to external AFIP logo to improve SEO #}

        jQueryNuvem('img[src*="www.afip.gob.ar"]').attr('alt', '{{ "Logo de AFIP" | translate }}');

    {% endif %}

    {#/*============================================================================
      #Empty placeholders
    ==============================================================================*/ #}

    {% set show_help = not has_products %}

    {% if template == 'home' and show_help %}

        {# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {  
            var slider_empty_autoplay = {delay: 6000,};
        } else {
            var slider_empty_autoplay = false;
        }

        window.homeEmptySlider = {
            getAutoRotation: function() {
                return slider_empty_autoplay;
            },
        };
        createSwiper('.js-home-empty-slider', {
            {% if not params.preview %}
            lazy: true,
            {% endif %}
            loop: true,
            autoplay: slider_empty_autoplay,
            pagination: {
                el: '.js-swiper-empty-home-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-swiper-empty-home-next',
                prevEl: '.js-swiper-empty-home-prev',
            },
            on: {
                init: function () {
                  jQueryNuvem(".js-home-empty-slider").css("visibility", "visible").css("height", "100%");
                },
            },
        });

        {# /* // Home products slider */ #}

        var width = window.innerWidth;
            if (width > 767) {  
                var productsqty = 3;
            } else {
                var productsqty = 1;
            }

        window.swiperLoader('.js-swiper-featured', {
            slidesPerView: {% if settings.theme_variant == 'squared' %} 1{% else %} productsqty{% endif %},
            watchOverflow: true,
            pagination: {
                el: '.js-swiper-featured-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-swiper-featured-next',
                prevEl: '.js-swiper-featured-prev',
            },
        });

        {# /* // Banner services slider */ #}

        window.swiperLoader('.js-informative-banners', {
            slidesPerView: 1,
            watchOverflow: true,
            centerInsufficientSlides: true,
            pagination: {
                el: '.js-informative-banners-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-informative-banners-next',
                prevEl: '.js-informative-banners-prev',
            },
            breakpoints: {
                640: {
                    slidesPerView: 3,
                }
            }
        });

    {% endif %}

    {% if template == '404' and show_help %}

        {# /* // Product Related */ #}

        {% set columns = settings.grid_columns %}
        createSwiper('.js-swiper-related', {
            slidesPerView: 1,
            watchOverflow: true,
            pagination: {
                el: '.js-swiper-related-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-swiper-related-next',
                prevEl: '.js-swiper-related-prev',
            },
            breakpoints: {
                640: {
                    slidesPerView: {% if columns == 2 %}2{% elseif columns == 3 %}3{% else %}4{% endif %},
                }
            }
        });

        {# /* // Product slider */ #}

        function productSliderNav(){
            createSwiper('.js-swiper-product', {
                lazy: true,
                loop: false,
                pagination: {
                    el: '.js-swiper-product-pagination',
                    type: 'fraction',
                    clickable: true,
                },
                navigation: {
                    nextEl: '.js-swiper-product-next',
                    prevEl: '.js-swiper-product-prev',
                },
                on: {
                    init: function () {
                      jQueryNuvem(".js-product-slider-placeholder").hide();
                      jQueryNuvem(".js-swiper-product").css("visibility", "visible").css("height", "auto");
                    },
                },
            });
        }

        jQueryNuvem(".js-product-thumb").on("click", function(e){
            e.preventDefault();
            var current_thumb_index = jQueryNuvem(e.currentTarget).attr("data-slide-index");
            var match_thumb_image = jQueryNuvem('.js-swiper-product').find("[data-image-position='"+current_thumb_index+"']");
            var selectedPosition = match_thumb_image.attr("data-image-position");
            var slideToGo = parseInt(selectedPosition);
            productSwiper.slideTo(slideToGo);        
        });

        {% if  settings.theme_variant == 'squared' %}
            productSliderNav ()
        {% else %}
            if ( window.innerWidth < 768 ) {
                productSliderNav ()
            } else {
                LS.registerOnChangeVariant(function(variant){
                    var liImage = jQueryNuvem('.js-swiper-product').find("[data-image='"+variant.image+"']");
                    var selectedScroll = liImage.position.top;
                    document.documentElement.scroll({
                        top: jQueryNuvem(liImage).offset().top,
                        behavior: 'smooth'
                    });
                });
            }
        {% endif %}

    {% endif %}

    {# /* 404 handling to show the example product */ #}

    if ( window.location.pathname === "/product/example/" || window.location.pathname === "/br/product/example/" ) {
        document.title = "{{ "Producto de ejemplo" | translate | escape('js') }}";
        jQueryNuvem("#404").hide();
        jQueryNuvem("#product-example").show();
    } else {
        jQueryNuvem("#product-example").hide();
    }

});
