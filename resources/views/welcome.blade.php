@extends('layouts.app')


@section('content')
	<router-view></router-view>
@endsection


@section('head')
	<title>welcome.blade</title>
	<meta property="og:type" content="article" />
	<meta property="og:title" content="Voten - Social Bookmarking For The 21st Century" />
	<meta property="og:url" content="{{ config('app.url') }}" />
	<meta property="og:site_name" content="Voten" />

	<meta name="twitter:card" content="summary" />
	<meta name="twitter:site" content="@voten_co" />
	<meta name="twitter:title" content="Voten - Social Bookmarking For The 21st Century" />

	<meta name="description" content="A Modern, real-time, open-source, beautiful, deadly simple and warm community."/>
	<meta property="og:description" content="A Modern, real-time, open-source, beautiful, deadly simple and warm community." />
	<meta name="twitter:description" content="A Modern, real-time, open-source, beautiful, deadly simple and warm community." />
	<meta property="og:image" content="{{ config('app.url') }}/imgs/voten-circle.png">
	<meta name="twitter:image" content="{{ config('app.url') }}/imgs/voten-circle.png" />

	<script type="application/ld+json">
		{
		    "@context": "http://schema.org",
		    "@type": "Organization",
		    "url": "https://voten.co",
		    "name": "Voten",
		    "logo": {
	            "@type": "ImageObject",
	            "url": "https://voten.co/imgs/voten-circle.png",
	            "width": "512",
	            "height": "512"
	        },
		    "sameAs": [
		        "https://www.facebook.com/voten.co/",
		        "https://twitter.com/voten_co"
		    ]
		}
	</script>
@endsection
