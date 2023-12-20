import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sf_chat_im/features/discover/blocs/bloc/discovery_bloc.dart';
import 'package:sf_chat_im/features/discover/screens/widgets/discovery_widget.dart';
import 'package:sf_chat_im/shared/enums/api_fetch_status.dart';
import 'package:sf_chat_im/shared/themes/color_selector.dart';
import 'package:sf_chat_im/shared/widgets/common_empty.dart';
import 'package:sf_chat_im/shared/widgets/common_loading.dart';

class DiscoverDetailScreen extends StatefulWidget {
  const DiscoverDetailScreen({Key? key, required this.messageId})
      : super(key: key);

  final String? messageId;
  @override
  State<DiscoverDetailScreen> createState() => _DiscoverDetailScreenState();
}

class _DiscoverDetailScreenState extends State<DiscoverDetailScreen> {
  final controller = TextEditingController();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final index = context
        .read<DiscoveryBloc>()
        .state
        .discoverList
        ?.data
        ?.indexWhere((element) => element.msgId == widget.messageId);
    if (index == null || index < 0) {
      context.read<DiscoveryBloc>().add(
            DiscoverSingleItem(messageId: widget.messageId),
          );
    } else {
      context.read<DiscoveryBloc>().add(
            DiscoverCommentList(messageId: widget.messageId),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<DiscoveryBloc, DiscoveryState>(
        builder: (context, state) {
          final msgId = widget.messageId;
          return Scaffold(
            backgroundColor: Colors.white,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: CustomColors.white,
                  iconTheme: IconThemeData(color: Colors.black),
                ),
                SliverToBoxAdapter(
                  child: Builder(builder: (context) {
                    if (state.apiFetchStatus == ApiFetchStatus.loading ||
                        state.discoverDetailStatus == ApiFetchStatus.loading) {
                      return Container(
                        height: 0.7.sh,
                        child: Center(
                          child: CommonLoadingCircular(),
                        ),
                      );
                    }
                    if (state.discoverList == null) {
                      return Container(
                        height: 0.7.sh,
                        child: Center(
                          child: CommonEmpty(),
                        ),
                      );
                    }
                    final list = state.discoverList!.data;
                    final index = list?.indexWhere((element) {
                      return element.msgId == msgId;
                    });

                    if (index == null ||
                        index < 0 ||
                        state.discoverList?.data?[index] == null ||
                        state.discoverList?.data?[index].userId == null) {
                      return Container(
                        height: 0.7.sh,
                        child: Center(
                          child: CommonEmpty(),
                        ),
                      );
                    }
                    return DiscoverDetailItem(
                      discoverData: state.discoverList!.data![index],
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0).r,
                      commentLimit: 50,
                      scrollController: scrollController,
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
