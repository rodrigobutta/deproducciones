@extends('layouts.app')


@section('head')
	<title>#{{ $profession->slug }} - Voten</title>
	<meta property="og:type" content="article" />
	<meta property="og:title" content="#{{ $profession->title }} - Voten" />
	<meta property="og:url" content="{{ config('app.url') }}/p/{{ $profession->slug }}" />
	<meta property="og:site_name" content="Voten" />

	<meta name="twitter:card" content="summary" />
	<meta name="twitter:site" content="@voten_co" />
	<meta name="twitter:title" content="#{{ $profession->slug }} - Voten" />

	<meta name="description" content="{{ $profession->description }}"/>
	<meta property="og:description" content="{{ $profession->description }}" />
	<meta name="twitter:description" content="{{ $profession->description }}" />
	<meta property="og:image" content="{{ $profession->avatar }}" />
	<meta name="twitter:image" content="{{ $profession->avatar }}" />
@stop


@section('content')
	<router-view></router-view>
@endsection


@section('script')
	<script>
		var preload = {
			profession: {!! $profession !!},
			submissions: {!! $submissions->toJson() !!}
		};
	</script>
@endsection