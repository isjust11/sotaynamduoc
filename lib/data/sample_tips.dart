import 'package:sotaynamduoc/domain/data/models/tip_model.dart';

class SampleTips {
  static List<TipModel> getSampleTips() {
    return [
      TipModel(
        id: '1',
        title: 'Cách bảo quản thuốc nam đúng cách',
        summary: 'Hướng dẫn chi tiết cách bảo quản thuốc nam để giữ được dược tính và tránh hư hỏng.',
        content: '''
Thuốc nam cần được bảo quản đúng cách để giữ được dược tính và tránh hư hỏng. Dưới đây là những cách bảo quản hiệu quả:

1. **Bảo quản nơi khô ráo, thoáng mát**
   - Tránh ánh nắng trực tiếp
   - Nhiệt độ phòng từ 20-25°C
   - Độ ẩm dưới 60%

2. **Sử dụng hộp kín**
   - Hộp thủy tinh hoặc nhựa chất lượng cao
   - Đậy kín nắp sau khi sử dụng
   - Tránh không khí ẩm xâm nhập

3. **Phân loại theo loại thuốc**
   - Thuốc khô: bảo quản riêng biệt
   - Thuốc tươi: bảo quản trong tủ lạnh
   - Thuốc bột: đóng gói kín

4. **Kiểm tra định kỳ**
   - Thay mới thuốc hết hạn
   - Loại bỏ thuốc bị mốc, hư hỏng
   - Ghi nhãn ngày sản xuất và hạn sử dụng
        ''',
        thumbnail: 'https://example.com/thumbnail1.jpg',
        category: 'Bảo quản',
        author: 'Bác sĩ Nguyễn Văn A',
        createdAt: '2024-01-15T10:00:00Z',
        viewCount: 1250,
        likeCount: 89,
        bookmarkCount: 45,
        isLiked: false,
        isBookmarked: false,
        tags: ['bảo quản', 'thuốc nam', 'dược liệu'],
        difficulty: 'easy',
        estimatedTime: '5 phút',
        targetAudience: 'beginner',
        source: 'Sách "Thuốc nam Việt Nam"',
      ),
      TipModel(
        id: '2',
        title: 'Mẹo giảm stress bằng thảo dược',
        summary: 'Các loại thảo dược tự nhiên giúp giảm stress và cải thiện tâm trạng hiệu quả.',
        content: '''
Stress là vấn đề phổ biến trong cuộc sống hiện đại. Dưới đây là các mẹo sử dụng thảo dược để giảm stress:

1. **Trà tâm sen**
   - Uống 1-2 ly mỗi ngày
   - Giúp an thần, ngủ ngon
   - Pha với nước sôi 80°C

2. **Cây lạc tiên**
   - Lá và hoa có tác dụng an thần
   - Pha trà hoặc nấu canh
   - Uống trước khi ngủ 30 phút

3. **Hoa cúc**
   - Trà hoa cúc giúp thư giãn
   - Có thể kết hợp với mật ong
   - Uống 2-3 ly mỗi ngày

4. **Tắm thảo dược**
   - Thêm lá bạc hà, sả vào nước tắm
   - Giúp thư giãn cơ bắp
   - Tắm 15-20 phút mỗi ngày
        ''',
        thumbnail: 'https://example.com/thumbnail2.jpg',
        category: 'Sức khỏe tinh thần',
        author: 'Thạc sĩ Lê Thị B',
        createdAt: '2024-01-14T14:30:00Z',
        viewCount: 2100,
        likeCount: 156,
        bookmarkCount: 78,
        isLiked: true,
        isBookmarked: false,
        tags: ['stress', 'thảo dược', 'tâm lý'],
        difficulty: 'easy',
        estimatedTime: '10 phút',
        targetAudience: 'beginner',
        source: 'Nghiên cứu y học cổ truyền',
      ),
      TipModel(
        id: '3',
        title: 'Cách nhận biết thảo dược chất lượng',
        summary: 'Hướng dẫn phân biệt thảo dược thật và giả, chọn mua đúng nơi uy tín.',
        content: '''
Việc nhận biết thảo dược chất lượng rất quan trọng để đảm bảo hiệu quả điều trị:

1. **Kiểm tra nguồn gốc**
   - Mua từ nhà thuốc uy tín
   - Có giấy chứng nhận chất lượng
   - Nguồn gốc rõ ràng

2. **Quan sát hình dáng**
   - Màu sắc tự nhiên, không quá đậm
   - Không có dấu hiệu mốc, ẩm
   - Kích thước đồng đều

3. **Kiểm tra mùi vị**
   - Mùi thơm tự nhiên
   - Không có mùi hóa chất
   - Vị đắng nhẹ, không chua

4. **Thử nghiệm đơn giản**
   - Thả vào nước: thảo dược thật chìm từ từ
   - Đốt thử: cháy đều, không có mùi hóa chất
   - Nếm thử: vị đắng nhẹ, không cay
        ''',
        thumbnail: 'https://example.com/thumbnail3.jpg',
        category: 'Nhận biết',
        author: 'Dược sĩ Trần Văn C',
        createdAt: '2024-01-13T09:15:00Z',
        viewCount: 3200,
        likeCount: 234,
        bookmarkCount: 123,
        isLiked: false,
        isBookmarked: true,
        tags: ['chất lượng', 'nhận biết', 'mua sắm'],
        difficulty: 'medium',
        estimatedTime: '15 phút',
        targetAudience: 'intermediate',
        source: 'Hội Dược liệu Việt Nam',
      ),
      TipModel(
        id: '4',
        title: 'Sơ cứu bằng thuốc nam',
        summary: 'Các phương pháp sơ cứu cơ bản sử dụng thảo dược có sẵn trong nhà.',
        content: '''
Trong tình huống khẩn cấp, thuốc nam có thể giúp sơ cứu hiệu quả:

1. **Vết thương nhỏ**
   - Rửa sạch bằng nước muối
   - Đắp lá chuối non
   - Băng lại bằng vải sạch

2. **Bỏng nhẹ**
   - Ngâm ngay vào nước lạnh
   - Đắp lá nha đam
   - Không bôi dầu mỡ

3. **Ngộ độc thực phẩm**
   - Uống nước gừng tươi
   - Ăn cháo loãng
   - Nghỉ ngơi, uống nhiều nước

4. **Đau bụng**
   - Massage nhẹ vùng bụng
   - Uống trà gừng ấm
   - Chườm nóng vùng đau
        ''',
        thumbnail: 'https://example.com/thumbnail4.jpg',
        category: 'Sơ cứu',
        author: 'Bác sĩ Phạm Thị D',
        createdAt: '2024-01-12T16:45:00Z',
        viewCount: 1800,
        likeCount: 145,
        bookmarkCount: 67,
        isLiked: true,
        isBookmarked: true,
        tags: ['sơ cứu', 'khẩn cấp', 'tự nhiên'],
        difficulty: 'medium',
        estimatedTime: '20 phút',
        targetAudience: 'intermediate',
        source: 'Sách "Sơ cứu tại nhà"',
      ),
      TipModel(
        id: '5',
        title: 'Cách trồng và chăm sóc cây thuốc',
        summary: 'Hướng dẫn trồng các loại cây thuốc phổ biến tại nhà để có nguồn dược liệu tươi.',
        content: '''
Trồng cây thuốc tại nhà giúp bạn có nguồn dược liệu tươi và an toàn:

1. **Chọn cây phù hợp**
   - Cây dễ trồng: húng quế, tía tô, kinh giới
   - Cây cần không gian: sả, gừng, nghệ
   - Cây leo: đậu ván, mướp đắng

2. **Chuẩn bị đất**
   - Đất tơi xốp, thoát nước tốt
   - Trộn phân hữu cơ
   - Độ pH từ 6-7

3. **Cách trồng**
   - Gieo hạt hoặc trồng cây con
   - Tưới nước đều đặn
   - Bón phân định kỳ

4. **Chăm sóc**
   - Cắt tỉa thường xuyên
   - Phòng trừ sâu bệnh
   - Thu hoạch đúng thời điểm
        ''',
        thumbnail: 'https://example.com/thumbnail5.jpg',
        category: 'Trồng trọt',
        author: 'Kỹ sư nông nghiệp Võ Văn E',
        createdAt: '2024-01-11T11:20:00Z',
        viewCount: 950,
        likeCount: 78,
        bookmarkCount: 34,
        isLiked: false,
        isBookmarked: false,
        tags: ['trồng trọt', 'cây thuốc', 'tự nhiên'],
        difficulty: 'hard',
        estimatedTime: '30 phút',
        targetAudience: 'expert',
        source: 'Tạp chí Nông nghiệp',
      ),
    ];
  }

  static List<TipCategory> getSampleCategories() {
    return [
      TipCategory(
        id: '1',
        name: 'Bảo quản',
        description: 'Mẹo bảo quản thuốc nam và thảo dược',
        icon: 'storage',
        color: '#4CAF50',
        tipCount: 15,
      ),
      TipCategory(
        id: '2',
        name: 'Sức khỏe tinh thần',
        description: 'Cải thiện tâm trạng và giảm stress',
        icon: 'psychology',
        color: '#2196F3',
        tipCount: 12,
      ),
      TipCategory(
        id: '3',
        name: 'Nhận biết',
        description: 'Phân biệt thảo dược thật và giả',
        icon: 'search',
        color: '#FF9800',
        tipCount: 8,
      ),
      TipCategory(
        id: '4',
        name: 'Sơ cứu',
        description: 'Sơ cứu bằng thảo dược tự nhiên',
        icon: 'emergency',
        color: '#F44336',
        tipCount: 20,
      ),
      TipCategory(
        id: '5',
        name: 'Trồng trọt',
        description: 'Trồng và chăm sóc cây thuốc',
        icon: 'eco',
        color: '#8BC34A',
        tipCount: 25,
      ),
    ];
  }
}
