import 'package:budgeting_app/ui/core/view_models/main_frame_view_model.dart';
import 'package:budgeting_app/ui/core/widget/budgeting_app_bottom_navigation.dart';
import 'package:budgeting_app/ui/core/widget/project_navigator.dart';
import 'package:flutter/material.dart';

/// アプリ全体でOverlayとして共通で用いるフレームパーツ
class MainFrame extends StatefulWidget {
  const MainFrame({
    super.key,
    required MainFrameViewModel viewModel,
    Widget? child,
    Widget? background,
  }):
    _viewModel = viewModel,
    _child = child,
    _background = background;

  final MainFrameViewModel _viewModel;

  /// 内容
  /// 
  /// AppBarやBottomNavigationがある場合は避けて配置される。
  /// 
  /// ない場合はシステム領域まで表示される。そうしないとスクロール画面が切れてしまうため。
  /// 
  /// システム領域を回避したい場合はSafeAreaPaddingを使用する。
  final Widget? _child;

  /// 背景（システム領域を含んで描画） 
  final Widget? _background;

  @override
  MainFrameState createState() {
    return MainFrameState();
  }
}

class MainFrameState extends State<MainFrame> {
  @override
  void dispose() {
    widget._viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // MaterialAppのhome以下は自動的にNavigator内に配置されるが
    // builderで設置する場合はNavigator外となる。
    // bottomNavigationBarなどはOverlayで覆う必要がある
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => Scaffold(
            // ナビゲーションバー領域までbodyを描画
            extendBody: true,

            // ステータスバー領域までbodyを描画
            extendBodyBehindAppBar: true,

            // AppBarはPreferredSizeでなければならない
            // 不要な時はサイズ0のコンテナを表示させる
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: ValueListenableBuilder(
                valueListenable: widget._viewModel.topBar,
                builder: (_, topBar, _) => topBar != null
                  ? AppBar(
                    title: Text(topBar.title),
                    automaticallyImplyLeading: false,
                    leading: navigator.leading(),
                    actions: topBar.actions?.map(
                      (action) => IconButton(
                        onPressed: action.onPressed, 
                        icon: Icon(action.icon)
                      ),
                    ).toList(),
                  )
                  : SizedBox.shrink(),
              ),
            ),

            bottomNavigationBar: ValueListenableBuilder(
              valueListenable: widget._viewModel.navigatorState,
              builder: (context, state, _) {
                return state ? bottomNavigationBar : Container();
              },
            ),

            floatingActionButton: ValueListenableBuilder(
              valueListenable: widget._viewModel.floatingActionButton,
              builder: (_, models, _) => Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 16.0,
                children: models.map(
                  (model) => FloatingActionButton(
                    onPressed: model.onPressed,
                    // heroタグは指定しないエラーになる場合がある
                    heroTag: model.heroTag, 
                    child: Icon(model.icon),
                  )
                ).toList(),
              ),
            ),

            body: LayoutBuilder(
              builder: (context, constraints) {
                final MediaQueryData metrics = MediaQuery.of(context);
                return MediaQuery(
                  data: metrics.copyWith(
                    padding: metrics.padding.copyWith(
                      top: 0.0,
                      bottom: 0.0,
                    )
                  ), 
                  child: Stack(
                    children:[
                      widget._background ?? Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: double.infinity,
                        height: double.infinity,
                      ),

                      Column(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: widget._viewModel.topBar, 
                            builder: (_, topBar, _) => SizedBox(
                              width: double.infinity,
                              height: topBar != null ? kToolbarHeight + widget._viewModel.edgeInsets.top : 0.0,
                            ),
                          ),

                          if (widget._child != null)
                            Expanded(child: widget._child!),

                          ValueListenableBuilder(
                            valueListenable: widget._viewModel.navigatorState,
                            builder: (_, state, _) => SizedBox(
                              width: double.infinity,
                              height: state ? kBottomNavigationBarHeight + widget._viewModel.edgeInsets.bottom : 0.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
