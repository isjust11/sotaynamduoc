class AuthorEntity {
  String? id;
  String? name;
  String? slug;
  String? alias;
  String? biography;
  String? career;
  String? achievements;
  String? contributions;
  String? works;
  String? philosophy;
  String? legacy;
  DateTime? birthDate;
  DateTime? deathDate;
  String? birthPlace;
  String? deathPlace;
  String? era;
  String? dynasty;
  String? specialty;
  String? teacher;
  String? students;
  String? portrait;
  String? avatar;
  String? coverImage;
  List<String>? galleryImages;
  String? quotes;
  String? anecdotes;
  String? honors;
  String? memorials;
  String? references;
  int? viewCount;
  int? likeCount;
  bool? isActive;
  DateTime? createdAt;
  DateTime? updatedAt;

  AuthorEntity({
    this.id,
    this.name,
    this.slug,
    this.alias,
    this.biography,
    this.career,
    this.achievements,
    this.contributions,
    this.works,
    this.philosophy,
    this.legacy,
    this.birthDate,
    this.deathDate,
    this.birthPlace,
    this.deathPlace,
    this.era,
    this.dynasty,
    this.specialty,
    this.teacher,
    this.students,
    this.portrait,
    this.avatar,
    this.coverImage,
    this.galleryImages,
    this.quotes,
    this.anecdotes,
    this.honors,
    this.memorials,
    this.references,
    this.viewCount,
    this.likeCount,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'alias': alias,
      'biography': biography,
      'career': career,
      'achievements': achievements,
      'contributions': contributions,
      'works': works,
      'philosophy': philosophy,
      'legacy': legacy,
      'birthDate': birthDate?.toIso8601String(),
      'deathDate': deathDate?.toIso8601String(),
      'birthPlace': birthPlace,
      'deathPlace': deathPlace,
      'era': era,
      'dynasty': dynasty,
      'specialty': specialty,
      'teacher': teacher,
      'students': students,
      'portrait': portrait,
      'avatar': avatar,
      'coverImage': coverImage,
      'galleryImages': galleryImages,
      'quotes': quotes,
      'anecdotes': anecdotes,
      'honors': honors,
      'memorials': memorials,
      'references': references,
      'viewCount': viewCount,
      'likeCount': likeCount,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  static AuthorEntity fromJson(Map<String, dynamic> json) {
    return AuthorEntity(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
      alias: json['alias']?.toString(),
      biography: json['biography']?.toString(),
      career: json['career']?.toString(),
      achievements: json['achievements']?.toString(),
      contributions: json['contributions']?.toString(),
      works: json['works']?.toString(),
      philosophy: json['philosophy']?.toString(),
      legacy: json['legacy']?.toString(),
      birthDate: json['birthDate'] != null ? DateTime.parse(json['birthDate']) : null,
      deathDate: json['deathDate'] != null ? DateTime.parse(json['deathDate']) : null,
      birthPlace: json['birthPlace']?.toString(),
      deathPlace: json['deathPlace']?.toString(),
      era: json['era']?.toString(),
      dynasty: json['dynasty']?.toString(),
      specialty: json['specialty']?.toString(),
      teacher: json['teacher']?.toString(),
      students: json['students']?.toString(),
      portrait: json['portrait']?.toString(),
      avatar: json['avatar']?.toString(),
      coverImage: json['coverImage']?.toString(),
      galleryImages: json['galleryImages'] != null 
          ? List<String>.from(json['galleryImages'])
          : null,
      quotes: json['quotes']?.toString(),
      anecdotes: json['anecdotes']?.toString(),
      honors: json['honors']?.toString(),
      memorials: json['memorials']?.toString(),
      references: json['references']?.toString(),
      viewCount: json['viewCount']?.toInt(),
      likeCount: json['likeCount']?.toInt(),
      isActive: json['isActive'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
} 