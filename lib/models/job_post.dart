class JobPost {
  final String image;
  final String company;
  final String title;
  final String salary;
  final String description;
  final String videoUrl;
  final String location;

  JobPost({
    required this.image,
    required this.company,
    required this.title,
    required this.salary,
    required this.description,
    required this.videoUrl,
    required this.location,
  });

  // 从 JSON 创建 JobPost 对象
  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      image: json['image'] as String,
      company: json['company'] as String,
      title: json['title'] as String,
      salary: json['salary'] as String,
      description: json['description'] as String,
      videoUrl: json['video_url'] as String,
      location: json['location'] as String,
    );
  }

  // 将 JobPost 对象转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'company': company,
      'title': title,
      'salary': salary,
      'description': description,
      'video_url': videoUrl,
      'location': location,
    };
  }
}
