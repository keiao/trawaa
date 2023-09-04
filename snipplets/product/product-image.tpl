{% set has_multiple_slides = product.images_count > 1 or product.video_url %}

{% if product.images_count > 0 %}
	<div class="js-swiper-product nube-slider-product swiper-container" style="visibility:hidden; height:0;">
		{% include 'snipplets/labels.tpl' with {'product_detail': true} %}
	    <div class="swiper-wrapper collage-images">
	    	{% for image in product.images %}
	         <div class="swiper-slide js-product-slide collage-slide" data-image="{{image.id}}" data-image-position="{{loop.index0}}">
	         	<a href="{{ image | product_image_url('huge') }}" data-fancybox="product-gallery" class="d-block p-relative" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
         			<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w, {{  image | product_image_url('original') }} 1024w' data-sizes="auto" class="js-product-slide-img product-slider-image img-absolute img-absolute-centered lazyautosizes lazyload" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
         			<img src="{{ image | product_image_url('tiny') }}" class="js-product-slide-img product-slider-image img-absolute img-absolute-centered blur-up" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
	        	</a>
	         </div>
	        {% endfor %}
	        {% include 'snipplets/product/product-video.tpl' %}
	    </div>
	    <div class="js-swiper-product-pagination swiper-pagination swiper-pagination-white right"></div>
	    {% if has_multiple_slides %}
		    <div class="js-swiper-product-prev swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-2x svg-icon-text"} %}</div>
	        <div class="js-swiper-product-next swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-2x svg-icon-text"} %}</div>
        {% endif %}
	</div>
	{% snipplet 'placeholders/product-detail-image-placeholder.tpl' %}
	{% if settings.theme_variant == 'squared' %}
		{% if has_multiple_slides %}
	        <div class="thumbs d-none d-md-flex visible-when-content-ready mt-1">
	            {% for image in product.images %}
	                <a href="#" class="js-product-thumb thumb-link" data-slide-index="{{loop.index0}}">
	                    <img data-sizes="auto" src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w, {{  image | product_image_url('original') }} 1024w' class="thumb-image lazyautosizes lazyload" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
	                </a>
	            {% endfor %}
	            {% include 'snipplets/product/product-video.tpl' with {thumb: true} %}
	        </div>
	    {% endif %}
	{% endif %}
{% endif %}