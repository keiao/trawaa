{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set has_video = settings.video_embed %}
{% set has_informative_banners = settings.banner_services and (settings.banner_services_01_title or settings.banner_services_02_title or settings.banner_services_03_title or settings.banner_services_04_title or settings.banner_services_05_title or settings.banner_services_06_title) %}
{% set has_category_banners =  settings.banner_01_show or settings.banner_02_show or settings.banner_03_show or settings.banner_04_show %}
{% set has_instafeed = store.instagram and settings.show_instafeed and store.hasInstagramToken() %}

{% set show_help = not (has_main_slider or has_mobile_slider or has_informative_banners or has_category_banners or has_video or has_instafeed) and not has_products %}

{% set help_url = has_products ? '/admin/products/feature/' : '/admin/products/new/' %}

{# **** This will show default products in the home page before you upload some products **** #}
{% if show_help %}
    {% snipplet 'defaults/show_help.tpl' %}
{% else %}

	{# END of show default products in the home page #}

	{#  **** Home slider ****  #}

	<section data-store="slider-main">
		{% include 'snipplets/home/home-slider.tpl' %}
		{% if has_mobile_slider %}
			{% include 'snipplets/home/home-slider.tpl' with {mobile: true} %}
		{% endif %}
	</section>
				
	{#  **** Features Order ****  #}
	{% set newArray = [] %}

	{% for section in ['home_order_position_1', 'home_order_position_2', 'home_order_position_3', 'home_order_position_4', 'home_order_position_5', 'home_order_position_6', 'home_order_position_7'] %}
	    {% set section_select = attribute(settings,"#{section}") %}

	    		

	    {% if section_select not in newArray %}

	    	{% if section_select == 'look' %}

				{#  **** Featured slider products ****  #}
				{% include 'snipplets/home/home-products-slider.tpl' %}

			{% elseif section_select == 'welcome' %}

				{#  **** Welcome message ****  #}
				{% include 'snipplets/home/home-welcome-message.tpl' %}

			{% elseif section_select == 'video' %}

				{#  **** Video embed ****  #}
				{% include 'snipplets/home/home-video.tpl' %}
				
		    {% elseif section_select == 'informatives' %}

		    	{#  **** Informative banners ****  #}
				{% include 'snipplets/banner-services/banner-services.tpl' %}

		    {% elseif section_select == 'categories' %}

		    	{#  **** Categories banners ****  #}
				{% include 'snipplets/home/home-banners.tpl' with {'textoverimage': true} %}

			{% elseif section_select == 'instafeed' %}

				{#  **** Instafeed ****  #}
				{% include 'snipplets/home/home-instafeed.tpl' %}

			{% elseif section_select == 'products' %}

		        {#  **** Featured products ****  #}
				{% include 'snipplets/home/home-featured-products.tpl' %}

		    {% endif %}
	   {% set newArray = newArray|merge([section_select]) %}
	   
	   {% endif %}

	{% endfor %}

{% endif %}


{# Newsletter #}
{% include "snipplets/newsletter.tpl" %}

