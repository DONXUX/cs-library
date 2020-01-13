import 'common.dart';

/// 이미지 리소스를 관리합니다.

class Drawable extends Resource {

  String get logo => _routeSVG('logo');
  String get sample => _routePNG('Sample_book');

  String _route(final String route) => 'res/drawable/' + route;
  String _routePNG(final String route) => _route(route + '.png');
  String _routeSVG(final String route) => _route(route + '.svg');

  String _routeDir(final String dir, final String route) => dir + '/' + route;
}