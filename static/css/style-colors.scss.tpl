{#/*============================================================================
style-colors.scss.tpl

    -This file contains all the theme styles related to settings defined by user from config/settings.txt
    -Rest of styling can be found in:
        -snipplets/css/style-async.css.tpl --> For non critical styles witch will be loaded asynchronously
        -snipplets/css/style-critical.tpl --> For critical CSS rendered inline before the rest of the site

==============================================================================*/#}

{# /*============================================================================
  Table of Contents
  #Colors and fonts
    // Colors
    // Font families
    // SVG Icons
  #Components
    // Margin and padding
    // Mixins
    // Animations
    // Functions
    // Wrappers
    // Placeholders
    // Dividers
    // Titles and breadcrumbs
    // Texts
    // Buttons
    // Links
    // Progress bar
    // Modals
    // Forms
    // Alerts and notifiactions
    // Tables
    // Tabs
    // Labels
    // Sliders
    // Lists
  #Home page
    // Banners
    // Video
    // Instafeed
  #Product grid
    // Category image
    // Grid item
    // Filters
  #Product detail
    // Image
    // Form and info
  #Contact page
    // Data contact
  #Account page
    // Order items
  #Header and nav
    // Ad Bar
    // Header
    // Search
  #Footer
  #Media queries
    // Components
    // Product grid
    // Product detail
  #Theme Variants
    // Square
      /Components
      /Labels
      /Home
      /Product grid
      /Product detail
      /Media queries
    // Round
      /Components
      /Home
      /Product detail
      /Product grid

==============================================================================*/ #}

{#/*============================================================================
  #Colors and fonts
==============================================================================*/#}
	
{# /* // Colors */ #}

$primary-color: {{ settings.primary_color }};
$main-foreground: {{ settings.text_color }};
$main-background: {{ settings.background_color }};
$danger-color: #D42007;

{# If store has accent color on it uses the accent color else uses primary color as default fallback #}
{% if settings.accent_color_active %}
  $accent-color: {{ settings.accent_color }};
{% else %}
  $accent-color: {{ settings.primary_color }};
{% endif %}

{# /* // Font families */ #}

$heading-font: {{ settings.font_headings | raw }};
$body-font: {{ settings.font_rest | raw }};

{# /* // SVG Icons */ #}

.svg-icon-primary{
  fill: $primary-color;
}
.svg-icon-text{
  fill: $main-foreground;
}
.svg-icon-accent{
  fill: $accent-color;
  color: $accent-color;
}
.svg-icon-invert{
    fill: $main-background;
}

.svg-stroke-primary{
  stroke: $primary-color;
}
.svg-stroke-text{
  stroke: $main-foreground;
}
.svg-stroke-invert{
  stroke: $main-background;
}

{#/*============================================================================
  #Components
==============================================================================*/#}

{# /* // Margin and padding */ #}

%section-margin {
  margin-bottom: 70px;
}
%section-padding {
  padding: 30px 20px;
}
%element-margin {
  margin-bottom: 20px;
}
%element-margin-half {
  margin-bottom: 10px;
}

{# /* // Mixins */ #}

@mixin text-decoration-none(){
  text-decoration: none;
  outline: 0;
  &:hover,
  &:focus{
    text-decoration: none;
    outline: 0;
  }
}

@mixin no-wrap(){
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	font-weight: normal;
}

@mixin drop-shadow(){
	-moz-box-shadow: 0 0 3px #ccc;
	-webkit-box-shadow: 0 0 3px #ccc;
	box-shadow: 0 0 3px #ccc;
}

{# This mixin adds browser prefixes to a CSS property #}

@mixin prefix($property, $value, $prefixes: ()) {
	@each $prefix in $prefixes {
    	#{'-' + $prefix + '-' + $property}: $value;
	}
   	#{$property}: $value;
}

{# /* // Animations */ #}

%simplefade {
  transition: all 0.5s ease;
}

{# /* // Functions */ #}

@function set-foreground-color($bg-color, $foreground-color) {
  @if (lightness($bg-color) > 50) {
    @return $foreground-color; // Lighter backgorund, return dark color
  } @else {
    @return lighten($foreground-color, 15%); // Darker background, return light color
  }
}

@function set-foreground-color-invert($bg-color, $foreground-color) {
  @if (lightness($bg-color) > 50) {
    @return darken($foreground-color, 100%); // black foreground over white background
  } @else {
    @return lighten($foreground-color, 15%); // no dark foreground on dark background
  }
}

@function set-foreground-color-footer($bg-color, $foreground-color) {
  @if (lightness($bg-color) > 50) {
    @return $foreground-color; // Lighter backgorund, return dark color
  } @else {
    @return lighten($foreground-color, 30%); // Darker background, return light color
  }
}

{# /* // Wrappers */ #}

%body-font {
  font-size: 14px;
}

body{
  color: $main-foreground;
  font-family: $body-font;
  background-color:$main-background;
  @extend %body-font;
}

.section-product-detail,
.section-cart-detail{
  border-top: 1px solid rgba($main-foreground, .14);
  border-bottom: 1px solid rgba($main-foreground, .14);
}

{# /* // Placeholders */ #}

.placeholder-container{
  background-color:rgba($main-foreground, 0.1);
}
.placeholder-color{
  background-color:rgba($main-foreground, 0.07);
}
.placeholder-icon svg{
  fill:rgba($main-foreground, 0.2);
}
.placeholder-page{
  background: $main-foreground;
  &:hover,
  &.active{
      background: $primary-color;
      opacity: 0.8;
  }
}
.placeholder-shine,
.placeholder-fade{
  background-color:rgba($main-foreground, 0.2);
}
.spinner-ellipsis {
  position: relative;
  width: 18px;
  height: 18px;
  margin: -30px auto 50px auto;
  border-radius: 50%;
  @include prefix(animation, spinner-ellipsis 0.9s ease alternate infinite, webkit ms moz o);
  animation-delay: 0.36s;
  @include prefix(animation-delay, 0.36s, webkit ms moz o);
  &:after,
  &:before {
    content: '';
    position: absolute;
    width: 18px;
    height: 18px;
    border-radius: 50%;
    @include prefix(animation, spinner-ellipsis 0.9s ease alternate infinite, webkit ms moz o);
  }
  &:before {
    left: -30px;
    @include prefix(animation-delay, 0.18s, webkit ms moz o);
  }
  &:after {
    right: -30px;
    @include prefix(animation-delay, 0.54s, webkit ms moz o);
  }
}

@keyframes spinner-ellipsis {
  0% {
    box-shadow: 0 28px 0 -28px rgba($main-foreground, .2); 
  }
  100% {
    box-shadow: 0 28px 0 rgba($main-foreground, .2); 
  } 
}

.spinner-ellipsis-invert {
  @extend .spinner-ellipsis;
  animation: spinner-ellipsis-invert 0.9s ease alternate infinite;
  animation-delay: 0.36s;
  &:after,
  &:before {
    animation: spinner-ellipsis-invert 0.9s ease alternate infinite;
  }
}

@keyframes spinner-ellipsis-invert {
  0% {
    box-shadow: 0 28px 0 -28px $main-background; 
  }
  100% {
    box-shadow: 0 28px 0 $main-background; 
  } 
}

{# /* // Dividers */ #}

.divider{
  margin-top: 20px;
  margin-bottom: 20px;
  clear: both;
  border-bottom: 1px solid rgba($main-foreground, .1);
  &-full-width{
    margin-left: -10px;
    margin-right: -10px;
  }
}

{# /* // Titles and breadcrumbs */ #}

.h1-huge{
  font-size: 60px;
  font-weight: bold;
}
h1,
.h1 {
  font-size: 60px;
  font-weight: 700;
  line-height: 1;
  margin-bottom: 20px;
}

h2,
.h2 {
  font-size: 40px;
  font-weight: 700;
}

h3,
.h3 {
  font-size: 22px;
  line-height: 1.4;
  font-weight: 300;
}

h4,
.h4 {
  font-size: 18px;
  font-weight: normal;
}

h5,
.h5 {
  font-size: 16px;
  font-weight: normal;
}

h6,
.h6 {
  font-size: 14px;
  font-weight: normal;
}

.font-smallest{
  font-size: 10px!important;
}

.font-big{
  font-size: 16px;
}

.breadcrumbs {
  @extend %element-margin;
  font-size: 12px;
  font-weight: 300;
  .divider {
    margin: 0 5px; 
  }
}

.section-title{
  @extend %section-padding;
  text-align: center;
  background-color: rgba($main-foreground, .03);
  *{
    margin: 0;
  }
  &.transparent{
    background-color: transparent;
  } 
}

h1,.h1,
h2,.h2,
h3,.h3,
h4,.h4,
h5,.h5,
h6,.h6{
  margin-top: 0;
  font-family: $heading-font;
}


{# /* // Texts */ #}

.text-primary {
  color: $primary-color;
}

.text-secondary {
  color: $main-background;
}

.text-foreground {
  color: $main-foreground;
}

.text-accent,
.cart-installments.installment-no-interest {
  color: $accent-color;
}

.font-small{
  font-size: 12px;
}
.font-secondary {
  font-family: $body-font;
}

{# /* // Buttons */ #}

.btn{
  position: relative;
  text-decoration: none;
  text-align: center;
  border: 0;
  cursor: pointer;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  text-transform: uppercase;
  background: none;
  white-space: normal;
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  &:hover,
  &:focus{
    outline: 0;
    opacity: 0.8;
  }
  &[disabled],
  &.disabled,
  &[disabled]:hover,
  &.disabled:hover,{
    opacity: 0.5;
    cursor: not-allowed;
    outline: 0;
  }
  &-default{
    height: 40px;
    padding: 12px 15px; 
    background-color: rgba($main-foreground, .14);
    color: $main-foreground;
  }
  &-primary{
    display: block;
    margin: 0 auto;
    padding: 15px 20px 15px 20px;
  }
  &-block{
    float: left;
    width: 100%;
  }
  &-small{
    display: inline-block;
    padding: 10px;
    letter-spacing: 2px;
  }
  &-medium{
    padding: 10px 10px 10px 14px;
    font-size: 14px;
  }
  &-line{
    padding: 10px 0;
    color: $main-background;
    letter-spacing: 4px;
    @extend %body-font;
    border-bottom: 2px solid;
    &.btn-line-primary {
      color: $primary-color;
      border-color: $primary-color;
    }
  }
  &-icon {
    padding: 5px;
  }
  &-facebook {
    .svg-fb-icon {
      position: relative;
      bottom: -7px;
      height: 26px;
      fill: #1977f2;
    }
  }
}

button{
  cursor: pointer;
  &:focus{
    outline: 0;
    opacity: 0.8;
  }
}

.btn-collapse {
  height: 40px;
  font-size: 12px;
  line-height: 40px;
  cursor: pointer;
}

.collapse-container {
  width: 100%;
  padding: 0 10px;
  border: 1px solid rgba($main-foreground, .14);
}

.btn-smallest{
  height: auto;
  padding: 5px 12px;
  font-size: 12px;
}

{# /* // Links */ #}

a {
  color: $main-foreground;
  @include prefix(transition, all 0.4s ease, webkit ms moz o);
  &:hover,
  &:focus{
    color: rgba($main-foreground, .5);
  }
}

.link-contrast {
  color: $main-background;
  &:hover,
  &:focus{
    color: rgba($main-background, .8);
  }
}

.btn-link{
  color: $main-foreground;
  cursor: pointer;
  &-primary {
    color: $primary-color;
  }
  &:hover,
  &:focus{
    color: $primary-color;
  }
  &.toggled{
    color: $primary-color;
    > i,
    > svg{
      color: $primary-color;
      fill: $primary-color;
    }
  }
}

{# /* // Progress bar */ #}

.bar-progress {
  background: rgba($main-foreground, 0.1);
  &-active {
    background: $accent-color;
  }
}

{# /* // Modals */ #}

.modal{
  color: $main-foreground;
  background-color: $main-background;
  &-close{
    fill: $main-foreground;
  }
  i{
    fill: $main-foreground;
    color: $main-foreground;
  }
  &-right{
    .modal-header {
      background: $main-background;
    }
  }
}

{# /* // Forms */ #}

input,
textarea {
  font-family: $body-font;
}

.form-group{
  @extend %element-margin;
  .alert{
    margin: 10px 0 0 0;
  }
  &-box{
    margin: 0;
  }
}

.form-label{
  width: 100%;
  margin-bottom: 10px;
}

.form-control {
  display: block;
  padding: 12px;
  width: 100%;
  font-size: 16px; /* Hack to avoid autozoom on iOS mobile */
  border: 1px solid rgba($main-foreground, .14);
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  color: $main-foreground;
  background-color: $main-background;
  @extend %body-font;
  &:not(textarea){
    height: 40px;
    &.small{
      height: 32px;
    }
  }
  &:focus{
    outline: 0;
  }
  &-inline{
    display: inline;
  }
}

.form-control {
  &::-webkit-input-placeholder,
  &::-moz-placeholder,
  &::-moz-placeholder,
  &:-ms-input-placeholder {
    color: $main-foreground;
    opacity: .5;
  }
}

.form-select{
  display: block;
  padding: 10px 30px 10px 10px;
  width: 100%;
  min-width: 60px;
  font-size: 16px; /* Hack to avoid autozoom on iOS mobile */
  border: 1px solid rgba($main-foreground, .14);
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;
  color: $main-foreground;
  background-color: $main-background;
  @extend %body-font;
  &.small{
    padding: 5px 8px;
  }
  &:focus{
    outline:0;
  }
  &::-ms-expand {
    display: none;
  }
}

.form-quantity{
  height: 39px;
  padding: 0 5px;
  border: 1px solid rgba($main-foreground, .14);
  .form-control{
    height: 37px;
    padding: 10px;
    border: 0;
    -webkit-appearance: none;
    -moz-appearance:textfield;
  }
  .btn{
    ms-flex: 0 0 30px;
    flex: 0 0 30px;
    height: 30px;
    svg{
      margin-top: 5px;
    }
  }
}

.input-clear-content:before {
  content: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" fill="{{ settings.primary_color |replace("#","%23") }}"><path d="M180.77,255.56l131.7-131.7a5.24,5.24,0,0,0,0-7.4l-14.79-14.79a5.24,5.24,0,0,0-7.4,0L158.58,233.38,26.88,101.67a5.23,5.23,0,0,0-7.39,0L4.7,116.46a5.22,5.22,0,0,0,0,7.4l131.7,131.7L4.7,387.26a5.22,5.22,0,0,0,0,7.4l14.79,14.79a5.23,5.23,0,0,0,7.39,0l131.7-131.71,131.7,131.71a5.24,5.24,0,0,0,7.4,0l14.79-14.79a5.24,5.24,0,0,0,0-7.4Z"/></svg>');
}

input::-webkit-inner-spin-button,
input::-webkit-outer-spin-button{
  -webkit-appearance: none;
  margin: 0;
}

input[type=number] {
  -moz-appearance:textfield;
}

.radio-button {
  .radio-button-icon{
    background-size: 200% 200%;
    background-image: linear-gradient(to top, $main-foreground 50%, transparent 50%);
    border:2px solid $main-foreground;
    @include prefix(transition, all 0.09s ease-in, webkit ms moz o);
    box-shadow: 0 0 1px 2px inset #fff;
  }
}
input[type="radio"]:checked {
  + .radio-button-content {
    .radio-button-icon{
      background-image: linear-gradient(to top, $primary-color 51%, transparent 50%);
      background-position: 0 100%;
    }
    .shipping-price {
      color: $primary-color;
      &.shipping-price-free {
        color: $accent-color;
      }
    }
  }
} 


{# /* // Alerts and notifications */ #}

.alert{
  &-danger,
  &-error{
    color: set-foreground-color($main-background, #cc4845);
    border:1px solid set-foreground-color($main-background, #cc4845);
  }
  &-warning{
    color: set-foreground-color($main-background, #e68b26);
    border:1px solid set-foreground-color($main-background, #e68b26);
  }
  &-info{
    color: $main-foreground;
    border:1px solid $main-foreground;
  }
  &-success{
    color: set-foreground-color($main-background, #3caf65);
    border:1px solid set-foreground-color($main-background, #3caf65);
  }
  &-primary {
    border:1px solid $primary-color;
    color: $primary-color;
  }
}

.notification-primary{
  color: $primary-color;
  background-color: $main-background;
}

.notification-secondary{
  padding: 12px 0;
  background: darken($main-background, 3%);
  color: rgba($main-foreground, .8);
}

.notification-danger {
  color: $danger-color;
  fill: $danger-color;
}

{# /* // Tables */ #}

.table{
  background-color: $main-background;
  color: $main-foreground;
  tbody{
    tr:nth-child(odd){
      background-color: rgba($main-foreground, .05);
    }
  }
  th{
    padding: 8px;
    text-align: left;
  }
}

{# /* // Tabs */ #}

.tab-group{
  border-bottom: 1px solid rgba($main-foreground, .1);
  .tab{
    &-link{
      color: $main-foreground;
    }
    &.active{
      .tab-link{
        border-bottom: 2px solid rgba($primary-color, .5);
        color: $primary-color;
      }
    }
  }
}

{# /* // Labels */ #}

.label {
  background: rgba($main-foreground, .3);
  &.label-accent{
    background: $accent-color;
    color: $main-background;
  }
}

{# /* Cards */ #}

.card {
  background-color: $main-background;
}

{# /* // Sliders */ #}

.swiper-pagination-bullet-active {
  background-color: $main-foreground;
}
.swiper-pagination-fraction{
  background-color: rgba($main-foreground, .2);
  color: $main-foreground;
  @extend %body-font;
}

.swiper-dark {
  color: $main-foreground;
  .btn-line {
    color: $main-foreground;
    border-color: $main-foreground;
  }
}

.swiper-light {
  color: $main-background;
  .btn-line {
    color: $main-background;
    border-color: $main-background;
  }
}

.swiper-title {
  font-family: $heading-font;
}


{#/*============================================================================
  #Home Page
==============================================================================*/#}

{# /* // Banners */ #}

.textbanner {
  background-color: $main-foreground;
}

{# /* // Video */ #}

.video-player {
  color: $main-background;
  background-color: rgba($main-foreground, .5);
  &:hover{
    background-color: rgba($main-foreground, .1);
  }
  &-content{
    stroke: $main-background;
  }
}

.video-player-icon {
  color: $main-background;
}

.embed-responsive {
  background: $main-foreground;
}

{# /* // Instafeed */ #}

.instafeed-title {
  @extend %element-margin;
  color: $main-background;
}

.instafeed-info {
  color: $main-background;
} 

{#/*============================================================================
  #Product grid
==============================================================================*/#}

{# /* // Category image */ #}

.category-image-container {
  .category-image,
  .category-image-wrap {
    background-color: $main-foreground;
  }
  .category-name {
    color: white; {# // Contrast to overlay image #} 
  }
  
}

{# /* // Grid item */ #}

.item-name {
  font-family: $heading-font;
}

.item-link {
  color: $main-foreground;
}

.item-colors-bullet {
  border: 1px solid rgba($main-foreground, .5);
  &.selected {
    border: 2px solid $main-foreground;
  }
}

{# /* // Filters */ #}

.filter-color-container {
  border-top: 1px solid rgba($main-foreground,0.14);
  &.hidden-filters {
    border-top: 0;
  }
} 
.btn-filter,
.chip {
  color: $main-foreground;
  background: none;
  border: 1px solid rgba($main-foreground,0.14);
  &.selected {
    border: 1px solid rgba($main-foreground,0.8);
  }
  &-color.selected {
    border: 1px solid rgba($main-foreground,0.14);
  }
}

.checkbox-color {
  border: 1px solid rgba($main-foreground,0.06);
}

.checkbox-container input:checked + .checkbox {
  background-color: rgba($main-foreground, .06);
}

.filters-overlay {
  background-color: rgba($main-background, .85);
}


{#/*============================================================================
  #Product detail
==============================================================================*/#}

{# /* // Image */ #}

.product-video-container {
  background-color: rgba($main-foreground, .07);
}

{# /* // Form and info */ #}

.product-detail-installments .installment-no-interest {
  color: $accent-color;
  font-weight: bold;
}
    
.social-share {
  @extend %element-margin;
}

.product-description {
  @extend %element-margin;
}

{#/*============================================================================
  #Contact page
==============================================================================*/#}

{# /* // Data contact */ #}

.contact-item {
  @extend %element-margin;
}


{#/*============================================================================
  #Account page
==============================================================================*/#}

{# /* // Order item */ #}

.order-item {
  padding: 15px 0;
  border-bottom: 1px solid rgba($main-foreground, .08);
  &:first-child {
    border-top: 1px solid rgba($main-foreground, .08);
  }
}

{#/*============================================================================
  #Header and nav
==============================================================================*/#}

{# /* // Ad Bar */ #}

{% if settings.ad_bar_background == 'light' %}
  $adbar-bg-color: $main-background;
  $adbar-fg-color: $main-foreground;
{% elseif settings.ad_bar_background == 'dark' %}
  $adbar-bg-color: $main-foreground;
  $adbar-fg-color: $main-background;
{% else %}
  $adbar-bg-color: $primary-color;
  $adbar-fg-color: $main-background;
{% endif %}

{% if settings.ad_bar_transparent %}
  $adbar-opacity: .3;
{% else %}
  $adbar-opacity: 1;
{% endif %}
.section-advertising {
  background-color: rgba($adbar-bg-color, $adbar-opacity);
  color: $adbar-fg-color;
  a {
    color: $adbar-fg-color;
  }
}

{# /* // Header */ #}

.head-main {
  .utilities-container {
    .form-select,
    .search-input {
      background: transparent;
    }
  } 
}

.head-light{
  background-color: $main-background;
  @extend %simplefade;
  .cart-widget-amount,
  .svg-icon-text,
  .text-foreground,
  i {
    color: $main-foreground;
    fill: $main-foreground;
  }
  .cart-widget-amount {
    color: $main-background;
    background-color: $main-foreground;
  }
  .logo-text{
    color: $main-foreground;
  }
  .utilities-container {
    .form-select,
    .search-input {
      border: 1px solid rgba($main-foreground, 1);
    }
    .form-select-account-links {
      background: $main-background;
      border: 1px solid $main-foreground;
      border-top: none;
    }
  } 
}

.head-dark,
.head-primary{
  background-color: $main-foreground;
  @extend %simplefade;
  .cart-widget-amount,
  .svg-icon-text,
  .text-foreground,
  i {
    color: $main-background;
    fill: $main-background;
  }
  .notification-secondary .svg-icon-text {
    fill: $main-foreground;
  }
  .search-suggest-icon {
    color: $main-foreground;
    fill: $main-foreground;
  }
  .cart-widget-amount {
    color: $main-foreground;
    background-color: $main-background;
  }
  .utilities-container{
    ::-webkit-input-placeholder { /* WebKit, Blink, Edge */
      color:$main-background;
    }
    :-moz-placeholder { /* Mozilla Firefox 4 to 18 */
     color:$main-background;
     opacity:  1;
    }
    ::-moz-placeholder { /* Mozilla Firefox 19+ */
     color:$main-background;
     opacity:  1;
    }
    :-ms-input-placeholder { /* Internet Explorer 10-11 */
     color:$main-background;
    }
    ::-ms-input-placeholder { /* Microsoft Edge */
     color:$main-background;
    }

    ::placeholder { /* Most modern browsers support this now. */
     color:$main-background;
    }
    .search-input{
      color:$main-background;
      border-color:$main-background;
    }
    .form-select{
      color:$main-background;
      border-color:$main-background;
      &-account-links {
        background: $main-foreground;
        border: 1px solid $main-background;
        border-top: none;
      }
    }
  } 
  .logo-text{
    color: $main-background;
  }
}
.head-primary{
  background-color: $primary-color;
  .icon-underline:after{
    background-color: rgba($main-background, .4);
  }
  .utilities-container{
    .form-select-account-links{
      background-color: $primary-color;
    }
  }
}
.head-transparent{
  background-color: transparent;
  .section-advertising {
    background-color: rgba($adbar-bg-color, .3);
  }
  &.head-dark,
  &.head-primary{
    .notification-secondary{
      color: $main-background;
      border-color: rgba($main-background, .5);
      .btn-link,
      a,
      i{
        color: $main-background;
      }
      .svg-icon-text {
        fill: $main-background;
      }
    }
    .form-select-account-links{
      background: transparent;
    }
  }
  &.head-light{
    .notification-secondary{
      color: $main-foreground;
      border-color: rgba($main-foreground, .5);
      .btn-link,
      a,
      i{
        color: $main-foreground;
      }
    }
    .form-select-account-links{
      background: transparent;
    }
  }
  .notification-secondary{
    background: transparent;
    border-top: 1px solid;
    border-bottom: 1px solid;
  }
}

.search-suggest{
  background-color: $main-background;
}
.modal-nav-hamburger{
  .search-input{
    background-color: darken($main-background, 5%);
  }
}

.nav-secondary {
  background-color: $main-background;
  border-top: 1px solid rgba($main-foreground, .1);
}

.account-user-icon {
  background-color: $primary-color;
  color: $main-background;
}

{# /* // Search */ #}

.search-suggest-item {
  border-bottom: 1px solid rgba($main-foreground, .1);
}

{#/*============================================================================
  #Footer
==============================================================================*/#}

{% if settings.footer_background == 'light' %}
  $footer-bg-color: $main-background;
  $footer-fg-color: $main-foreground;
{% elseif settings.footer_background == 'dark' %}
  $footer-bg-color: $main-foreground;
  $footer-fg-color: $main-background;
{% elseif settings.footer_background == 'primary' %}
  $footer-bg-color: $primary-color;
  $footer-fg-color: $main-background;
{% else %}
  {% if settings.theme_variant == 'squared' %}
    $footer-bg-color: rgba($main-foreground, .1);
  {% else %}
    $footer-bg-color: $main-background;
  {% endif %}
  $footer-fg-color: $main-foreground;
{% endif %}

footer {
  background-color: $footer-bg-color;
  color: $footer-fg-color;
  .svg-icon-text {
    fill: $footer-fg-color;
  }
  a {
    color: $footer-fg-color;
  }
}

.element-footer {
  @extend %element-margin;
}

.powered-by-logo svg {
  fill: $footer-fg-color;
}

{#/*============================================================================
  #Media queries
==============================================================================*/ #}


{# /* // Min width 768px */ #}

@media (min-width: 768px) { 

  {# /* //// Components */ #}

  {# /* Forms */ #}

  .form-control {
    font-size: 12px;
  }

  .form-select {
    font-size: 14px;
  }

  {# /* Margin and padding */ #}

  %section-padding {
    padding: 50px 30px;
  }

  {# /* Titles and breadcrumbs */ #}

  .h1-huge-md{
    font-size: 80px;
  }
  .h1-md {
    font-size: 60px;
    line-height: 60px;
  }

  .h2-md {
    font-size: 40px;
  }

  .h3-md {
    font-size: 22px;
  }

  .h4-md {
    font-size: 18px;
  }

  .h5-md {
    font-size: 16px;
  }

  .h6-md {
    font-size: 14px;
  }

  .font-small-md{
    font-size: 12px;
  }

  {# /* Modals */ #}

  .modal.modal-context-md{
    @include prefix(box-shadow, 0 0 0 1px rgba($main-foreground, .14), webkit ms moz o);
  }

  {# /* Dividers */ #}

  .border-left-md {
    border-left: 1px solid rgba($main-foreground, .14);
  }

  {# /* //// Product grid */ #}

  .category-control-col{
    border-left: 1px solid rgba($main-foreground, .14);
  }
  .btn-filter.btn-filter-color.color-filter-custom {
    border: 1px solid rgba($main-foreground, .14);
  }

  {# /* //// Product detail */ #}

  .product-detail-form-col{
    border-left: 1px solid rgba($main-foreground, .14);
  }

}


{#/*============================================================================
  #Theme Variants
==============================================================================*/ #}
{# /* The theme variants define changes on buttons, inputs and spacing */ #}

{% if settings.theme_variant == 'squared' %}
  
  {# /* // Square */ #}

  {# /* /Components */ #}

  .box {
    border: 1px solid rgba($main-foreground, .14);
  }

  .card-header {
    background: rgba($main-foreground, .14);
  }
  
  .card-collapse {
    border-bottom: 3px solid $primary-color;
    &.active{
      border: 0;
    }
  }

  .notification-floating .notification{
    border-top: 1px solid rgba($main-foreground, .14);
    border-right: 0;
    border-bottom: 1px solid rgba($main-foreground, .14);
    border-left: 0;
  }
  .notification-with-arrow:after,
  .notification-with-arrow:before{
    position: absolute;
    width: 0;
    height: 0;
    display: block;
    border-style: solid;
    @include prefix(transform, rotate(-90deg), webkit ms moz o);
    content: '';
  }
  .notification-with-arrow:after {
    top: -16px;
    right: 18px;
    border-color: transparent transparent transparent $main-background;
    border-width: 9px;
  }
  .notification-with-arrow:before {
    top: -18px;
    right: 18px;
    border-color: transparent transparent transparent rgba($main-foreground, .14);
    border-width: 9px;
  }

  .btn-primary{
    background-size: 200% 200%;
    background-image: linear-gradient(to top, $primary-color 50%, transparent 50%);
    color: $primary-color;
    border-bottom: 3px solid $primary-color;
    @extend %body-font;
    font-weight: bold;
    @include prefix(transition, all 0.09s ease-in, webkit ms moz o);
    &:hover:not(.btn-transition){
      color: $main-background;
      background-image: linear-gradient(to top, $primary-color 51%, transparent 50%);
      background-position: 0 100%;
    } 
  }
  .btn-transition.active {
    color: $main-background;
    background-image: linear-gradient(to top, $primary-color 51%, transparent 50%);
    background-position: 0 100%;
  }
  .btn-facebook {
    padding-top: 7px;
    background-image: linear-gradient(to top, #1977f2 50%, transparent 50%);
    color: #1977f2;
    border-bottom: 3px solid #1977f2;
    &:hover{
      color: $main-background;
      background-image: linear-gradient(to top, #1977f2 51%, transparent 50%);
      background-position: 0 100%; 
      .svg-fb-icon {
        fill: $main-background;
      }
    }
  }

  .form-select{
    border-radius: 0;
  }

  {# /* /Labels */ #}

  .label-primary{
    background: $main-foreground;
    color: $main-background;
  }

  {# /* /Home */ #}

  .swiper-text {
    @extend %simplefade;
    opacity: 0;
    top: 60%;
  }
  .swiper-slide-active .swiper-text {
    opacity: 1;
    top: 50%;
  }

  .section-featured-home {
    border-bottom: 1px solid rgba($main-foreground, .14);
    .featured-title {
      background: rgba($main-foreground, .14);
      border-color: rgba($main-foreground, .14);
    }
    .featured-item {
      border-color: rgba($main-foreground, .14);
    }
  }

  .item-buy-open {
    background: $main-background;
  }
  .item-buy-variants {
    background: $main-background;
  }

  .section-instafeed-home {
    background: rgba($main-foreground, .8);
  }

  .instafeed-text {
    color: $main-background;
  }

  {# /* Product Grid */ #}

  .category-controls{
    min-height: 40px;
    background-color: $main-background;
    border-top: 1px solid rgba($main-foreground, .14);
    border-bottom: 1px solid rgba($main-foreground, .14);
    .category-control-col:last-of-type{
      border-left: 1px solid rgba($main-foreground, .14);
    }
    .form-select{
      padding-left: 0;
      border: 0;
    }
    .form-control-icon{
      right: 0;
    }
  }

  .product-table {
    border-bottom: 1px solid rgba($main-foreground, .1);
  }
  .item, 
  .item-details {
    border-color: rgba($main-foreground, .1);
  }

  {# /* /Product detail */ #}

  .social-share-button {
    color: $main-foreground;
  }

  {# /* /Media queries */ #}

  @media (min-width: 768px) and (max-width: 1024px) {
    .h2-md {
      font-size: 30px;
    }
  }

  @media (min-width: 768px) { 

    {# /* Home */ #}

    .featured-title {
      background: rgba($main-foreground, .14);
      border-color: rgba($main-foreground, .14);
    }
    .featured-item {
      border-color: rgba($main-foreground, .14);
    }

    {# /* Product detail */ #}

    .product-detail-form-col{
      border-left: 1px solid rgba($main-foreground, .14);
    }
  }


{% else %}

  {# /* // Round */ #}

  .body-border-top,
  .body-border-right,
  .body-border-bottom,
  .body-border-left {
    background-color: $main-background;
  }

  {# /* /Components */ #}

  %border-radius {
    border-radius: 50px;
  }

  .box {
    border-radius: 20px;
    @include prefix(box-shadow,  0 0 10px 0 rgba(0,0,0,0.08), webkit ms moz o);
    &-square {
      border-radius: 0;
    }
  }

  .btn-line{
    @extend %border-radius;
    border: 1px solid;
    padding: 8px 20px 8px 24px;
    line-height: 18px;
    @include prefix(transition, all 0.25s ease-in, webkit ms moz o);
    &:hover{
      color: $main-foreground;
      background-color: $main-background;
    } 
    &.medium{
      padding: 10px;
      letter-spacing: normal;
    }
    &.btn-smallest{
      padding: 6px 10px 6px 14px;
      font-size: 10px;
    }
  }
  .btn-primary{
    @extend %border-radius;
    background-color: $primary-color;
    color: $main-background;
    font-size: 16px;
    letter-spacing: 8px;
    @include prefix(box-shadow, inset 0 0 0 2px $primary-color, webkit ms moz o);
    @include prefix(transition, all 0.25s ease-in, webkit ms moz o);
    &:hover:not(.btn-transition){
      background-color: $main-background;
      color: $primary-color;
    } 
  }
  .btn-facebook {
    padding: 5px 20px 15px 20px;
    background-color: #1977f2;
    @include prefix(box-shadow, inset 0 0 0 2px #1977f2, webkit ms moz o);
    .svg-fb-icon {
        fill: #fff;
      }
    &:hover{
      color: #1977f2;
      .svg-fb-icon {
        fill: #1977f2;
      }
    }
  }

  .btn-small{
    font-size: 12px;
    letter-spacing: 3px;
  }

  .form-select,
  .form-quantity,
  .form-control,
  .btn-default,
  .label,
  .swiper-pagination-fraction{
    @extend %border-radius;
  }

  .form-group-inline{
    .form-control{
      border-radius: 20px 0 0 20px;
    }
    .btn-default{
      border-radius: 0 20px 20px 0;
    }
  }
  .form-control-icon{
    right: 15px;
  }
  .form-quantity .btn {
    border-radius: 50%;
    background-color: $primary-color;
    svg {
      fill: $main-background;
    }
  }

  .category-image-container > .category-controls{
    background-color: transparent;    
  }

  .category-controls{
    background-color: $main-background;
    .form-select{
      border: 1px solid $main-foreground;
    }
  }

  textarea.form-control,
  .alert{
    border-radius: 20px;
  }

  .section-title{
    background-color: transparent;
  }

  .label-primary {
    background: $primary-color;
    color: $main-background;
  }

  .labels{
    top: 10px;
    left: 10px;
  }

  {# /* // Notifications */ #}

  .notification-fixed-bottom {
    @include prefix(box-shadow,  0 0 10px 0 rgba(0,0,0,0.08), webkit ms moz o);
  }

  {# /* // Filters */ #}

  .filter-color-container {
    border-top: none;
  } 
  .btn-filter,
  .chip {
    &.selected {
      border: 1px solid rgba($main-foreground,0.8);
    }
    &-color {
      border: 1px solid rgba($main-foreground,0.14);
      &.selected {
        border: 1px solid rgba($main-foreground,0.14);
      } 
    }
  }
  .checkbox-color {
    border: 1px solid rgba($main-foreground,0.06);
  }

  {# /* /Header */ #}

  .head-light .cart-widget-amount,
  .head-dark .cart-widget-amount {
    background-color: $primary-color;
    color: $main-background;
  }

  {# /* Home */ #}

  .instafeed-title {
    color: $primary-color;
  }
  .swiper-text {
    @extend %simplefade;
    opacity: 0;
    top: 40%;
  }
  .swiper-slide-active .swiper-text {
    opacity: 1;
    top: 50%;
  }

  {# /* Product detail */ #}

  .regular-price {
    color: $primary-color;
  }

  .social-share-button {
    color: $primary-color;
  }

  .product-detail-form-col {
    border-left: none;
  }

  {# /* /Product Grid */ #}

  .item-container {
    background: $main-background;
    @include prefix(box-shadow,  0 0 10px 0 rgba(0,0,0,0.08), webkit ms moz o);
  }
  .item-buy-open {
    background: $primary-color;
    box-shadow: 0 0 10px rgba(0,0,0,0.08); 
    .svg-icon-text {
      fill: $main-background;
    }
  }
  .item-buy-variants {
    background: $main-background;
    box-shadow: 0 0 10px rgba(0,0,0,0.08); 
  }
  .item-price {
    color: $primary-color;
  }

  .item-colors {
    background: $main-background;
    &-bullet-text {
      border: 0;
    }
  }

  @media (min-width: 768px) { 

    .btn-line.btn-smallest{
      padding: 8px 20px 8px 24px;
      font-size: 12px;
    }
    .category-image-container {
      .category-controls{
        background-color: transparent;
        .form-select,
        a {
          border: 1px solid $main-background;
          background-color: transparent;
          color: $main-background;
          fill: $main-background;
        }
        .svg-icon-text,
        .form-group, {
          color: $main-background;
          fill: $main-background;
        }
      }
    }
  }

{% endif %}
