import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:sf_chat_im/shared/utilities/utils.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('隐私政策'),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: HtmlWidget(
            '''
              <!DOCTYPE html>
              <html>
          <p> 在 SF Chat IM，我们重视并优先考虑用户的隐私。本隐私政策概述了在您使用我们的聊天应用程序时，我们如何收集、使用、存储和保护您的个人信息。使用 SF Chat IM 即表示您同意本政策中所述的条款和做法。</p>
<p>信息收集： 我们可能会收集某些个人信息，如您的姓名、电子邮件地址、个人照片和联系人列表，以便为您提供无缝聊天体验。我们尊重您的隐私，只会收集必要的信息来提升您的用户体验。</p>
<p>信息使用： 我们使用收集到的信息为您提供所需的服务，包括促进交流、发送通知和个性化您的应用体验。我们还可能使用这些信息来改进我们的服务、进行分析和履行法律义务。
<p>
  信息共享： 我们优先保护您个人信息的安全，除非法律要求或得到您的明确同意，否则不会与第三方共享您的个人信息。但请注意，某些信息（如您的用户名或个人资料图片）可能会被 SF Chat IM 社区的其他用户看到。
</p>
<p>
  数据安全： 我们采用行业标准的安全措施来保护您的个人信息，防止未经授权的访问、篡改或披露。我们会定期检查我们的安全措施，以确保您的数据安全。但是，请注意没有任何一种通过互联网或电子存储进行数据传输的方法是完全安全的。
</p>
<p>
  我们存储您的最新联系信息，以便在您的联系人注册 SF Chat IM 后立即通知您，并在通知中正确显示其姓名。我们只需要您的电话号码和姓名（名和姓），不会存储有关您联系人的其他数据。
</p>
<p>
  第三方服务： SF Chat IM 可能与第三方服务整合或显示外部网站链接。我们不对这些第三方服务的隐私惯例或内容负责。我们建议在使用此类服务时查看其各自的隐私政策。
</p>
<p>
  儿童隐私： SF Chat IM面向13岁或以上的用户。如果我们发现无意中收集了此类信息，我们将立即采取措施予以删除。
</p>
<p> 隐私政策更新： 我们可能会不时更新本隐私政策。我们鼓励您定期查看该政策，以便随时了解任何变更。修改后继续使用 SF Chat IM 即表示您接受更新后的隐私政策。</p>
<p> 如果您对本隐私政策有任何问题或疑虑，请通过 <a href="mailto:marketing@superfuture.world">marketing@superfuture.world</a> 与我们联系。生效日期：2023 年 7 月 7 日 使用 SF Chat IM 即表示您已阅读、理解并同意本隐私政策中列出的条款和做法。</p>
              </html>
              ''',
            onTapUrl: (url) {
              launchUrlExternal(url);
              return true;
            },
          ),
        ),
      ),
    );
  }
}
