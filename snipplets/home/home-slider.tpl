{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_auto_height_slider = not settings.slider_viewport_height %}

{% if not mobile %}
<div class="js-home-main-slider-container {% if not has_main_slider %}hidden{% endif %}">
{% endif %}
	<div class="{% if mobile %}js-home-mobile-slider{% else %}js-home-main-slider{% endif %}-visibility section-slider {% if has_auto_height_slider %}section-slider-auto{% endif %} {% if has_main_slider and has_mobile_slider %}{% if mobile %}d-md-none{% else %}d-none d-md-block{% endif %}{% elseif not settings.toggle_slider_mobile and mobile %}hidden{% endif %}">
		<div class="js-home-slider{% if mobile %}-mobile{% endif %} nube-slider-home swiper-container">
		    <div class="swiper-wrapper">
		    	{% if mobile %}
		            {% set slider = settings.slider_mobile %}
		        {% else %}
		            {% set slider = settings.slider %}
		        {% endif %}
		        {% for slide in slider %}
		            <div class="swiper-slide slide-container">
		            	{% if slide.link %}
		            		<a href="{{ slide.link | setting_url }}" aria-label="{{ 'Carrusel' | translate }} {{ loop.index }}">
		            	{% endif %}
		            	{% set has_text =  slide.title or slide.description or slide.button %}
		                	<div class="js-slider-slide slider-slide">
		                		{% set load_big_image = loop.first and ((has_main_slider and not has_mobile_slider) or (has_mobile_slider and mobile)) %}
		                		<img 
		                			{% if slide.width and slide.height %} width="{{ slide.width }}" height="{{ slide.height }}" {% endif %}
		                			{% if load_big_image %}src="{{ slide.image | static_url | settings_image_url('xlarge') }}" srcset="{{ slide.image | static_url | settings_image_url('xlarge') }} 1400w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w" class="slider-image"{% else %}src="{{ slide.image | static_url | settings_image_url('tiny') }}" data-srcset="{{ slide.image | static_url | settings_image_url('xlarge') }} 1400w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w" class="slider-image blur-up swiper-lazy{% if has_auto_height_slider %} position-relative d-block{% endif %}" data-sizes="auto"{% endif %} alt="{{ 'Carrusel' | translate }} {{ loop.index }}"
		                		/>
		                		{% if has_text %}
		                			<div class="swiper-text swiper-{{ slide.color }}">
		                				{% set auto_height_slider_description = has_auto_height_slider and not has_mobile_slider ? 'h6-md font-small' : '' %}
		                				{% if slide.description and settings.theme_variant == 'rounded' %}
			                				<div class="swiper-description mb-1 {{ auto_height_slider_description }}">{{ slide.description }}</div>
			                			{% endif %}
			                			{% if slide.title %}
			                				<div class="swiper-title{% if has_auto_height_slider and not has_mobile_slider %} swiper-title-small{% endif %}">{{ slide.title }}</div>
			                			{% endif %}
			                			{% if slide.description and settings.theme_variant == 'squared' %}
			                				<div class="swiper-description mt-4 {{ auto_height_slider_description }}">{{ slide.description }}</div>
			                			{% endif %}
			                			{% if slide.button and slide.link %}
			                				<div class="btn btn-line btn-small swiper-btn {% if has_auto_height_slider and not has_mobile_slider %}btn-smallest mt-md-4 mt-2{% if settings.theme_variant == 'squared' %} px-0{% endif %}{% else %}mt-4{% endif %}">{{ slide.button }}</div>
			                			{% endif %}
			                		</div>
		            			{% endif %}
				            </div>
			            {% if slide.link %}
			            	</a>
			            {% endif %}
		        	</div>
		        {% endfor %}
		    </div>
		    <div class="js-swiper-home-control js-swiper-home-pagination{% if mobile %}-mobile{% endif %} swiper-pagination swiper-pagination-white"></div>
		    <div class="js-swiper-home-control js-swiper-home-prev{% if mobile %}-mobile{% endif %} swiper-button-prev">{% include "snipplets/svg/chevron-left.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
		    <div class="js-swiper-home-control js-swiper-home-next{% if mobile %}-mobile{% endif %} swiper-button-next">{% include "snipplets/svg/chevron-right.tpl" with {svg_custom_class: "svg-inline--fa fa-w-8 fa-lg svg-icon-text"} %}</div>
		</div>
	</div>
{% if not mobile %}
</div>
{% endif %}