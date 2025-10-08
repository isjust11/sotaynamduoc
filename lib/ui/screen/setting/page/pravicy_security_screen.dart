import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sotaynamduoc/blocs/cubit.dart';
import 'package:sotaynamduoc/ui/widget/base_screen.dart';
import 'package:sotaynamduoc/ui/widget/base_loading.dart';
import 'package:sotaynamduoc/blocs/base_bloc/base.dart';
import 'package:sotaynamduoc/gen/i18n/generated_locales/l10n.dart';
import 'package:sotaynamduoc/res/dimens.dart';
import 'package:sotaynamduoc/blocs/page_cubit.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sotaynamduoc/utils/html_style_helper.dart';
import 'package:sotaynamduoc/utils/html_content_processor.dart';
import 'package:sotaynamduoc/ui/widget/loading_template.dart';
import 'package:sotaynamduoc/res/colors.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PageCubit>().getPageBySlug('securityandpravicy');
    return BaseScreen(
      title: AppLocalizations.current.privacyAndSecurity,
      colorTitle: AppColors.white,
      stateWidget: CustomLoading<PageCubit>(
        message: AppLocalizations.current.loading,
        size: AppDimens.SIZE_32,
        loadingType: LoadingType.threeArchedCircle,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<PageCubit, BaseState>(
      bloc: context.read<PageCubit>(),
      builder: (context, state) {
        if (state is LoadedState) {
          final rawContent = state.data.content ?? '';

          // Process HTML content to handle encoded entities and code blocks
          final processedContent = HtmlContentProcessor.processHtmlContent(
            rawContent,
          );

          if (processedContent.isEmpty) {
            return const Center(
              child: Text(
                'Không có nội dung để hiển thị',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Html(
              data: processedContent,
              style: HtmlStyleHelper.getNewsContentStyle(),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
