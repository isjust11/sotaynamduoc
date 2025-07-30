import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sotaynamduoc/res/resources.dart';
import 'package:sotaynamduoc/utils/html_style_helper.dart';

class HtmlContentDemo extends StatelessWidget {
  const HtmlContentDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTML Content Demo'),
        backgroundColor: AppColors.secondaryBrand,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimens.SIZE_16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Văn bản cơ bản',
              '''
              <p>Đây là một đoạn văn bản cơ bản với <strong>chữ in đậm</strong> và <em>chữ nghiêng</em>.</p>
              <p>Bạn có thể sử dụng <u>gạch chân</u> và <a href="https://example.com">liên kết</a>.</p>
              ''',
            ),
            _buildSection(
              'Tiêu đề',
              '''
              <h1>Tiêu đề cấp 1</h1>
              <h2>Tiêu đề cấp 2</h2>
              <h3>Tiêu đề cấp 3</h3>
              <h4>Tiêu đề cấp 4</h4>
              ''',
            ),
            _buildSection(
              'Danh sách',
              '''
              <h3>Danh sách không có thứ tự:</h3>
              <ul>
                <li>Mục 1</li>
                <li>Mục 2</li>
                <li>Mục 3</li>
              </ul>
              
              <h3>Danh sách có thứ tự:</h3>
              <ol>
                <li>Bước 1</li>
                <li>Bước 2</li>
                <li>Bước 3</li>
              </ol>
              ''',
            ),
            _buildSection(
              'Trích dẫn',
              '''
              <blockquote>
                "Đây là một trích dẫn quan trọng. Nó thường được hiển thị với viền bên trái và chữ nghiêng."
              </blockquote>
              ''',
            ),
            _buildSection(
              'Mã code',
              '''
              <p>Đây là <code>mã inline</code> trong văn bản.</p>
              
              <pre>
&lt;div class="container"&gt;
  &lt;p&gt;Đây là một khối mã&lt;/p&gt;
&lt;/div&gt;
              </pre>
              ''',
            ),
            _buildSection(
              'Bảng',
              '''
              <table>
                <thead>
                  <tr>
                    <th>Tên</th>
                    <th>Tuổi</th>
                    <th>Thành phố</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>Nguyễn Văn A</td>
                    <td>25</td>
                    <td>Hà Nội</td>
                  </tr>
                  <tr>
                    <td>Trần Thị B</td>
                    <td>30</td>
                    <td>TP.HCM</td>
                  </tr>
                </tbody>
              </table>
              ''',
            ),
            _buildSection(
              'Hình ảnh',
              '''
              <p>Hình ảnh sẽ được hiển thị ở giữa:</p>
              <img src="https://via.placeholder.com/300x200/0085FF/FFFFFF?text=Demo+Image" alt="Demo Image" />
              ''',
            ),
            _buildSection(
              'Nội dung phức tạp',
              '''
              <h2>Hướng dẫn sử dụng</h2>
              <p>Đây là một <strong>hướng dẫn chi tiết</strong> về cách sử dụng ứng dụng:</p>
              
              <h3>Bước 1: Đăng ký</h3>
              <ol>
                <li>Nhấn vào nút "Đăng ký"</li>
                <li>Điền thông tin cá nhân</li>
                <li>Xác nhận email</li>
              </ol>
              
              <h3>Bước 2: Sử dụng</h3>
              <ul>
                <li>Tìm kiếm thông tin</li>
                <li>Lưu bài viết yêu thích</li>
                <li>Chia sẻ với bạn bè</li>
              </ul>
              
              <blockquote>
                <strong>Lưu ý:</strong> Hãy đảm bảo bạn đã đọc kỹ các điều khoản sử dụng trước khi bắt đầu.
              </blockquote>
              
              <p>Nếu bạn gặp vấn đề, hãy liên hệ với chúng tôi qua email: <a href="mailto:support@example.com">support@example.com</a></p>
              ''',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String htmlContent) {
    return Container(
      margin: EdgeInsets.only(bottom: AppDimens.SIZE_24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextLabel(
            title,
            fontSize: AppDimens.SIZE_18,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryBrand,
          ),
          SizedBox(height: AppDimens.SIZE_8),
          Container(
            padding: EdgeInsets.all(AppDimens.SIZE_12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimens.SIZE_8),
              border: Border.all(color: AppColors.border),
            ),
            child: Html(
              data: htmlContent,
              style: HtmlStyleHelper.getNewsContentStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget tạm thời để hiển thị text
class CustomTextLabel extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const CustomTextLabel(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize ?? AppDimens.SIZE_14,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? AppColors.textDark,
      ),
      textAlign: textAlign ?? TextAlign.left,
    );
  }
} 