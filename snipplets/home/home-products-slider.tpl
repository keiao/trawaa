{% if sections.slider.products | length %}
	<section class="section-product-slider-home">
		<div class="container-fluid p-0">
			<div class="row no-gutters">
				<div class="col-md{% if settings.theme_variant == 'squared' %}-6{% else %}-3{% endif %}">
					<div class="textbanner textbanner-slider banner-mid-height m-0">
						{% if settings.product_slider_url %}
                            <a href="{{ settings.product_slider_url | setting_url }}"{% if settings.product_slider_title %} title="{{ settings.product_slider_title }}" aria-label="{{ settings.produact_slider_title }}"{% else %} title="{{ 'Banner de' | translate }} {{ store.name }}" aria-label="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %}>
                        {% endif %}
                        {% set banner_image = "product_slider.jpg" | has_custom_image %}
                        <div class="textbanner-image textbanner-slider-image{% if banner_image and (settings.product_slider_title or settings.product_slider_description) %} overlay{% endif %}">
							{% if banner_image %}
								<img class="textbanner-image-background textbanner-slider-image lazyautosizes lazyload blur-up" src='{{ "product_slider.jpg" | static_url | settings_image_url('tiny') }}' data-srcset='{{ "product_slider.jpg" | static_url | settings_image_url('large') }} 480w, {{ "product_slider.jpg" | static_url | settings_image_url('huge') }} 640w, {{ "product_slider.jpg" | static_url | settings_image_url('original') }} 1024w' data-sizes="auto" data-expand="-10" {% if settings.product_slider_title %}alt="{{ settings.product_slider_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
							{% endif %}
                        </div>
                        {% if settings.product_slider_title or settings.product_slider_description %}
	                        <div class="textbanner-text textbanner-slider-text over-image px-4 text-center text-md-left">
	                        	{% if settings.product_slider_title %}
									<h2 class="textbanner-title">{{ settings.product_slider_title }}</h2>
								{% endif %}
	                            {% if settings.product_slider_description %}
	                                <div class="textbanner-paragraph">{{ settings.product_slider_description }}</div>
	                            {% endif %}
	                        </div>
                        {% endif %}
                        {% if settings.product_slider_url %}
                            </a>
                        {% endif %}
                    </div>
				</div>
				<div class="col-md{% if settings.theme_variant == 'squared' %}-6{% else %}-9{% endif %}">
					<div class="js-swiper-featured swiper-container">
						<div class="swiper-wrapper">
							{% if settings.theme_variant == 'squared' %}
								{% for product in sections.slider.products | take(5) %}
									{% include 'snipplets/grid/item.tpl' with {'slide_item': true}  %}
								{% endfor %}
							{% else %}
								{% for product in sections.slider.products | take(9) %}
									{% include 'snipplets/grid/item.tpl' with {'slide_item': true}  %}
								{% endfor %}
							{% endif %}	
						</div>
						<div class="js-swiper-featured-pagination swiper-pagination"></div>
						<div class="js-swiper-featured-prev swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
						<div class="js-swiper-featured-next swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
					</div>
				</div>
			</div>
		</div>
	</section>
{% endif %}