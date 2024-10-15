import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_tiktok/models/job_post.dart';

class JobService {
  static const String _key = 'job_posts';

  // 添加新的招聘信息
  static Future<void> addJob(JobPost job) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jobsJson = prefs.getStringList(_key) ?? [];
    jobsJson.add(jsonEncode(job.toJson()));
    await prefs.setStringList(_key, jobsJson);
  }

  // 获取所有招聘信息
  static Future<List<JobPost>> getJobs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jobsJson = prefs.getStringList(_key) ?? [];
    return jobsJson.map((json) => JobPost.fromJson(jsonDecode(json))).toList();
  }

  // 清除所有招聘信息（用于测试）
  static Future<void> clearJobs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}